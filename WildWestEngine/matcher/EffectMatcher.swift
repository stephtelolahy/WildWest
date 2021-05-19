//
//  EffectMatcher.swift
//  CardGameEngine
//
//  Created by Hugues Stephano Telolahy on 29/09/2020.
//
// swiftlint:disable file_length
// swiftlint:disable cyclomatic_complexity

public protocol EffectMatcherProtocol {
    func map(_ effects: [[String: Any]], ctx: EffectContext) -> [GEvent]
}

public struct EffectContext {
    let ability: String
    let actor: PlayerProtocol
    let card: PlayCard?
    let args: [PlayArg: [String]]
    let state: StateProtocol
}

public class EffectMatcher: EffectMatcherProtocol {

    public init() {
    }

    public func map(_ effects: [[String: Any]], ctx: EffectContext) -> [GEvent] {
        var events: [GEvent] = []

        for effect in effects {

            guard let action = effect["action"] as? String else {
                fatalError("Missing action")
            }

            guard let effectFunc = Self.all[action]?.matchingFunc else {
                fatalError("Effect \(action) not found")
            }

            let effectEvents = effectFunc(effect, ctx)

            if effectEvents.isEmpty,
               effect["optional"] == nil {
                return []
            }

            events.append(contentsOf: effectEvents)
        }

        return events
    }

    public var effectIds: [String] {
        Array(Self.all.keys)
    }
}

private struct Effect {
    let id: String
    let desc: String
    let matchingFunc: EffectFunc
}

private typealias EffectFunc = ([String: Any], EffectContext) -> [GEvent]

private extension EffectMatcher {
    
    static let all: [String: Effect] = [
        setTurn(),
        setPhase(),

        gainHealth(),
        looseHealth(),

        drawDeck(),
        drawHand(),
        drawInPlay(),
        drawStore(),
        drawDiscard(),

        equip(),
        handicap(),
        passInPlay(),

        discardHand(),
        discardInPlay(),

        deckToStore(),
        storeToDeck(),

        addHit(),
        removeHit(),
        cancelHit(),
        reverseHit(),

        // <LOGIC>
        revealDeckIf(),
        revealHandIf(),
        loop()
        // </LOGIC>
    ].toDictionary { $0.id }

    static func equip() -> Effect {
        Effect(id: "equip",
               desc: "Put a hand card in self inPlay.",
               matchingFunc: { params, ctx in
                let player = params.players(forKey: "player", ctx: ctx).first!
                guard let card = params.cards(forKey: "card", player: player, ctx: ctx).first else {
                    return []
                }

                var events: [GEvent] = [.equip(player: player, card: card)]
                
                // <RULE> cannot have two copies of the same card in play
                let playerObject = ctx.state.players[player]!
                let cardObject = playerObject.hand.first(where: { $0.identifier == card })!
                guard !playerObject.inPlay.contains(where: { $0.name == cardObject.name }) else {
                    return []
                }
                // </RULE>

                // <RULE> discard previous weapon if playing new one
                if cardObject.isWeapon,
                   let previousWeapon = playerObject.inPlay.first(where: { $0.isWeapon }) {
                    events.append(.discardInPlay(player: player, card: previousWeapon.identifier))
                }
                // </RULE>
                
                return events
               })
    }
    
    static func handicap() -> Effect {
        Effect(id: "handicap",
               desc: "Put a hand card in other's inPlay.",
               matchingFunc: { params, ctx in
                let player = params.players(forKey: "player", ctx: ctx).first!
                guard let card = params.cards(forKey: "card", player: player, ctx: ctx).first else {
                    return []
                }
                let other = params.players(forKey: "other", ctx: ctx).first!
                
                // <RULE> cannot have two copies of the same card in play
                let cardObject = ctx.actor.hand.first(where: { $0.identifier == card })!
                let otherObject = ctx.state.players[other]!
                if otherObject.inPlay.contains(where: { $0.name == cardObject.name }) {
                    return []
                }
                // </RULE>
                
                return [.handicap(player: player, card: card, other: other)]
               })
    }
    
    static func setPhase() -> Effect {
        Effect(id: "setPhase",
               desc: "Set current turn phase.",
               matchingFunc: { params, ctx in
                let phase = params.number(forKey: "value", ctx: ctx)
                return [.setPhase(value: phase)]
               })
    }
    
    static func gainHealth() -> Effect {
        Effect(id: "gainHealth",
               desc: "Gain life point respecting health limit",
               matchingFunc: { params, ctx in
                let players = params.players(forKey: "player", ctx: ctx)

                return players.compactMap { player -> [GEvent]? in

                    // <RULE> cannot have more health than maxHealth
                    let playerObject = ctx.state.players[player]!
                    guard playerObject.health < playerObject.maxHealth else {
                        return nil
                    }
                    // </RULE>
                    
                    return [.gainHealth(player: player)]
                }
                .flatMap { $0 }
               })
    }
    
    static func drawDeck() -> Effect {
        Effect(id: "drawDeck",
               desc: "Draw X cards from top deck.",
               matchingFunc: { params, ctx in
                let players = params.players(forKey: "player", ctx: ctx)
                let amount = params.number(forKey: "amount", ctx: ctx)
                return players.flatMap { player in
                    Array(0..<amount).map { _ in .drawDeck(player: player) }
                }
               })
    }

    static func drawDiscard() -> Effect {
        Effect(id: "drawDiscard",
               desc: "Draw top card from discard pile.",
               matchingFunc: { params, ctx in
                guard !ctx.state.discard.isEmpty else {
                    return []
                }
                
                let player = params.players(forKey: "player", ctx: ctx).first!
                return [.drawDiscard(player: player)]
               })
    }

    static func revealHandIf() -> Effect {
        Effect(id: "revealHandIf",
               desc: "Show a hand card, then apply effects according to suits and values.",
               matchingFunc: { params, ctx in
                let player = params.players(forKey: "player", ctx: ctx).first!
                let card = params.cards(forKey: "card", player: player, ctx: ctx).first!
                let regex = params.string(forKey: "regex")
                var events: [GEvent] = [.revealHand(player: player, card: card)]

                // <HACK: consider revealed card comes from deck>
                let cardObject = ctx.state.deck.first(where: { $0.identifier == card })!
                // </HACK>

                let success = cardObject.matches(regex: regex)
                if success {
                    events.append(contentsOf: params.effects(forKey: "then", ctx: ctx))
                }
                return events
               })
    }

    static func discardHand() -> Effect {
        Effect(id: "discardHand",
               desc: "Discard hand card to discard pile.",
               matchingFunc: { params, ctx in
                let player = params.players(forKey: "player", ctx: ctx).first!
                let cards = params.cards(forKey: "card", player: player, ctx: ctx)
                return cards.map { .discardHand(player: player, card: $0) }
               })
    }
    
    static func discardInPlay() -> Effect {
        Effect(id: "discardInPlay",
               desc: "Discard inPlay card to discard pile.",
               matchingFunc: { params, ctx in
                let player = params.players(forKey: "player", ctx: ctx).first!
                let cards = params.cards(forKey: "card", player: player, ctx: ctx)
                return cards.map { .discardInPlay(player: player, card: $0) }
               })
    }
    
    static func drawHand() -> Effect {
        Effect(id: "drawHand",
               desc: "Draw a card from other player's hand",
               matchingFunc: { params, ctx in
                let player = params.players(forKey: "player", ctx: ctx).first!
                let other = params.players(forKey: "other", ctx: ctx).first!
                let cards = params.cards(forKey: "card", player: other, ctx: ctx)
                return cards.map { .drawHand(player: player, other: other, card: $0) }
               })
    }
    
    static func drawInPlay() -> Effect {
        Effect(id: "drawInPlay",
               desc: "Draw a card from other player's inPlay",
               matchingFunc: { params, ctx in
                let player = params.players(forKey: "player", ctx: ctx).first!
                let other = params.players(forKey: "other", ctx: ctx).first!
                let cards = params.cards(forKey: "card", player: other, ctx: ctx)
                return cards.map { .drawInPlay(player: player, other: other, card: $0) }
               })
    }
    
    static func addHit() -> Effect {
        Effect(id: "addHit",
               desc: "Add hit",
               matchingFunc: { params, ctx in
                let players = params.players(forKey: "player", ctx: ctx)
                let abilities = params.strings(forKey: "abilities")
                let cancelable = params.number(forKey: "cancelable", ctx: ctx)
                return players.map { .addHit(player: $0, name: ctx.ability, abilities: abilities, cancelable: cancelable, offender: ctx.actor.identifier) }
               })
    }
    
    static func removeHit() -> Effect {
        Effect(id: "removeHit",
               desc: "Remove player from hit",
               matchingFunc: { params, ctx in
                let player = params.players(forKey: "player", ctx: ctx).first!
                return [.removeHit(player: player)]
               })
    }
    
    static func looseHealth() -> Effect {
        Effect(id: "looseHealth",
               desc: "Loose life point",
               matchingFunc: { params, ctx in
                let player = params.players(forKey: "player", ctx: ctx).first!
                let offender = params.players(forKey: "offender", ctx: ctx).first!
                let playerObject = ctx.state.players[player]!
                if playerObject.health == 1 {
                    return [.eliminate(player: player, offender: offender)]
                } else {
                    return [.looseHealth(player: player, offender: offender)]
                }
               })
    }
    
    static func cancelHit() -> Effect {
        Effect(id: "cancelHit",
               desc: "Cancel hit",
               matchingFunc: { params, ctx in
                let player = params.players(forKey: "player", ctx: ctx).first!
                guard let hit = ctx.state.hits.first(where: { $0.player == player }),
                      hit.cancelable > 0 else {
                    return []
                }
                let remainingCancelable = hit.cancelable - 1
                if remainingCancelable > 0 {
                    return [.cancelHit(player: player)]
                } else {
                    return [.removeHit(player: player)]
                }
               })
    }
    
    static func reverseHit() -> Effect {
        Effect(id: "reverseHit",
               desc: "Permute hit player and offender",
               matchingFunc: { params, ctx in
                let player = params.players(forKey: "player", ctx: ctx).first!
                guard let hit = ctx.state.hits.first(where: { $0.player == player }) else {
                    fatalError("Invalid hit")
                }
                return [.removeHit(player: player),
                        .addHit(player: hit.offender, name: hit.name, abilities: hit.abilities, cancelable: hit.cancelable, offender: player)]
               })
    }
    
    static func deckToStore() -> Effect {
        Effect(id: "deckToStore",
               desc: "Draw X cards from deck to store",
               matchingFunc: { params, ctx in
                let amount = params.number(forKey: "amount", ctx: ctx)
                return  Array(0..<amount).map { _ in .deckToStore }
               })
    }
    
    static func drawStore() -> Effect {
        Effect(id: "drawStore",
               desc: "Draw a card from store",
               matchingFunc: { params, ctx in
                let player = params.players(forKey: "player", ctx: ctx).first!
                let cards = params.cards(forKey: "card", player: player, ctx: ctx)
                return cards.map { .drawStore(player: player, card: $0) }
               })
    }
    
    static func revealDeckIf() -> Effect {
        Effect(id: "revealDeckIf",
               desc: "Flip over the top card of the deck, then apply effects according to suits and values",
               matchingFunc: { params, ctx in
                let regex = params.string(forKey: "regex")
                let amount = ctx.actor.flippedCards
                var events: [GEvent] = Array(0..<amount).map { _ in .revealDeck }
                let cards = ctx.state.deck.prefix(amount)
                let success = cards.contains(where: { $0.matches(regex: regex) })
                if success {
                    events.append(contentsOf: params.effects(forKey: "then", ctx: ctx))
                } else {
                    events.append(contentsOf: params.effects(forKey: "else", ctx: ctx))
                }
                return events
               })
    }

    static func passInPlay() -> Effect {
        Effect(id: "passInPlay",
               desc: "Pass InPlay card to other player",
               matchingFunc: { params, ctx in
                let player = params.players(forKey: "player", ctx: ctx).first!
                let card = params.cards(forKey: "card", player: player, ctx: ctx).first!
                let other = params.players(forKey: "other", ctx: ctx).first!
                return [.passInPlay(player: player, card: card, other: other)]
               })
    }

    static func setTurn() -> Effect {
        Effect(id: "setTurn",
               desc: "Set current turn player to: ",
               matchingFunc: { params, ctx in
                let player = params.players(forKey: "player", ctx: ctx).first!
                return [.setTurn(player: player)]
               })
    }

    static func loop() -> Effect {
        Effect(id: "loop",
               desc: "Repeat effects",
               matchingFunc: { params, ctx in
                let times = params.number(forKey: "times", ctx: ctx)
                let effects = params.effects(forKey: "then", ctx: ctx)
                var events: [GEvent] = []
                for _ in (0..<times) {
                    events.append(contentsOf: effects)
                }
                return events
               })
    }

    static func storeToDeck() -> Effect {
        Effect(id: "storeToDeck",
               desc: "Discard cards from store to top deck",
               matchingFunc: { params, ctx in
                let cards = params.cards(forKey: "card", player: "", ctx: ctx)
                return cards.map { .storeToDeck(card: $0) }
               })
    }
}

private extension Dictionary where Key == String {
    
    func players(forKey key: String, ctx: EffectContext) -> [String] {
        guard let player = self[key] as? String else {
            fatalError("Missing parameter \(key)")
        }
        
        switch player {
        case "actor":
            return [ctx.actor.identifier]
            
        case "target":
            let target = ctx.args[.target]!.first!
            return [target]
            
        case "all":
            return ctx.state.playOrder
                .starting(with: ctx.actor.identifier)
            
        case "others":
            let all = ctx.state.playOrder
                .starting(with: ctx.actor.identifier)
            return Array(all.dropFirst())

        case "next":
            let playing = ctx.state.playOrder
            if playing.contains(ctx.actor.identifier) {
                let next = playing.starting(with: ctx.actor.identifier)[1]
                return [next]
            }
            
            let nexts = ctx.state.initialOrder
                .starting(with: ctx.actor.identifier)
                .dropFirst()
            guard let next = nexts.first(where: { playing.contains($0) }) else {
                fatalError("No next player found after \(ctx.actor.identifier)")
            }
            return [next]

        case "hitOffender":
            if let hit = ctx.state.hits.first(where: { $0.player == ctx.actor.identifier }) {
                return [hit.offender]
            } else {
                fatalError("No matching hit found")
            }
            
        default:
            fatalError("Unsupported players \(player)")
        }
    }

    func cards(forKey key: String, player: String, ctx: EffectContext) -> [String] {
        guard let card = self[key] as? String else {
            fatalError("Missing parameter \(key)")
        }
        
        switch card {
        case "requiredHand":
            return ctx.args[.requiredHand]!
            
        case "randomHand":
            let hand = ctx.state.players[player]!.hand
            guard !hand.isEmpty else {
                return []
            }
            return [hand.randomElement()!.identifier]
            
        case "requiredInPlay":
            return ctx.args[.requiredInPlay]!
            
        case "requiredStore":
            return ctx.args[.requiredStore]!

        case "played":
            switch ctx.card {
            case let .hand(handCard):
                return [handCard]

            case let .inPlay(inPlayCard):
                return [inPlayCard]

            default:
                fatalError("Missing played card")
            }

        case "allHand":
            return ctx.state.players[player]!.hand.map { $0.identifier }

        case "allInPlay":
            return ctx.state.players[player]!.inPlay.map { $0.identifier }

        case "deck[1]":
            return [ctx.state.deck[1].identifier]

        case "unrequiredStore":
            return ctx.state.store
                .map { $0.identifier }
                .filter { !ctx.args[.requiredStore]!.contains($0) }
            
        default:
            fatalError("Unsupported card \(card)")
        }
    }
    
    func number(forKey key: String, ctx: EffectContext) -> Int {
        if let stringValue = self[key] as? String {
            switch stringValue {
            case "bangsCancelable":
                return ctx.actor.bangsCancelable

            case "inPlayPlayers":
                return ctx.state.playOrder.count

            case "excessHand":
                return Swift.max(ctx.actor.hand.count - ctx.actor.handLimit, 0)

            default:
                fatalError("Invalid parameter \(key)")
            }
        }
        
        guard let value = self[key] as? Int else {
            fatalError("Missing parameter \(key)")
        }
        
        return value
    }
    
    func string(forKey key: String) -> String {
        guard let value = self[key] as? String else {
            fatalError("Missing parameter \(key)")
        }
        
        return value
    }
    
    func strings(forKey key: String) -> [String] {
        guard let value = self[key] as? [String] else {
            fatalError("Missing parameter \(key)")
        }
        
        return value
    }
    
    func effects(forKey key: String, ctx: EffectContext) -> [GEvent] {
        guard let effects = self[key] as? [[String: Any]] else {
            fatalError("Missing parameter \(key)")
        }

        return EffectMatcher().map(effects, ctx: ctx)
    }
}

private extension CardProtocol {
    var isWeapon: Bool {
        abilities["weapon"] != nil
    }
}
