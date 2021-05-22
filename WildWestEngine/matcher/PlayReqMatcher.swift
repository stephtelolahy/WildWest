//
//  PlayReqMatcher.swift
//  CardGameEngine
//
//  Created by Hugues Stephano Telolahy on 29/09/2020.
//

public protocol PlayReqMatcherProtocol {
    func match(canPlay: [String: Any], ctx: PlayReqContext) -> [[PlayArg: [String]]]?
}

public struct PlayReqContext {
    let ability: String
    let actor: PlayerProtocol
    let state: StateProtocol
    let event: GEvent?
}

public class PlayReqMatcher: PlayReqMatcherProtocol {
    
    public init() {
    }
    
    public func match(canPlay: [String: Any], ctx: PlayReqContext) -> [[PlayArg: [String]]]? {
        let conditions: [Condition] = canPlay.map { key, value in
            guard let requirement = Self.all[key] else {
                fatalError("Requirement \(key) not found")
            }
            return Condition(req: requirement, value: value)
        }
        .sorted(by: { $0.req.priority < $1.req.priority })
        
        var playArgs: [[PlayArg: [String]]] = []
        
        guard conditions.allSatisfy({ $0.req.matchingFunc($0.value, ctx, &playArgs) }) else {
            return nil
        }
        
        return playArgs
    }
    
    public var playReqIds: [String] {
        Array(Self.all.keys)
    }
}

private typealias Condition = (req: PlayReq, value: Any)

private struct PlayReq {
    let id: String
    let desc: String
    var priority: Int = 1
    let matchingFunc: PlayReqFunc
}

private typealias PlayReqFunc = (Any, PlayReqContext, inout [[PlayArg: [String]]]) -> Bool

private extension PlayReqMatcher {
    
    static let all: [String: PlayReq] = [
        isYourTurn(),
        isPhase(),
        isHitsEmpty(),
        isHitName(),
        isPlayersCountMin(),
        isTimesPerTurnMax(),
        isHitCancelable(),
        isHitEliminate(),
        isHandExceedLimit(),
        
        requireTargetAny(),
        requireTargetSelf(),
        requireTargetAt(),
        requireTargetReachable(),
        requireTargetOffender(),
        requireTargetEliminated(),
        requireInPlayCard(),
        requireHandCards(),
        requireStoreCards(),
        requireDeckCards(),
        
        onHitCancelable(),
        onPhase(),
        onLooseHealth(),
        onEliminated(),
        onEliminatingRole(),
        onHandEmpty(),
        onEventsEmpty()
    ].toDictionary { $0.id }
    
    static func isYourTurn() -> PlayReq {
        PlayReq(id: "isYourTurn",
                desc: "Must be your turn",
                matchingFunc: { _, ctx, _ -> Bool in
                    ctx.state.turn == ctx.actor.identifier
                })
    }
    
    static func isPhase() -> PlayReq {
        PlayReq(id: "isPhase",
                desc: "Must be on phase: ",
                matchingFunc: { param, ctx, _ -> Bool in
                    let phase = Parser.number(param)
                    return ctx.state.phase == phase
                })
    }
    
    static func isHitsEmpty() -> PlayReq {
        PlayReq(id: "isHitsEmpty",
                desc: "Hits are empty.",
                matchingFunc: { _, ctx, _ -> Bool in
                    ctx.state.hits.isEmpty
                })
    }
    
    static func requireTargetAny() -> PlayReq {
        PlayReq(id: "requireTargetAny",
                desc: "Must target any other player.",
                priority: 0,
                matchingFunc: { _, ctx, playArgs -> Bool in
                    let others = ctx.state.playOrder
                        .filter { $0 != ctx.actor.identifier }
                    return playArgs.appending(values: others, forArg: .target)
                })
    }
    
    static func isPlayersCountMin() -> PlayReq {
        PlayReq(id: "isPlayersCountMin",
                desc: "The minimum number of players inPlay is: ",
                matchingFunc: { param, ctx, _ -> Bool in
                    let minPlayersCount = Parser.number(param)
                    return ctx.state.playOrder.count >= minPlayersCount
                })
    }
    
    static func requireInPlayCard() -> PlayReq {
        PlayReq(id: "requireInPlayCard",
                desc: "Must choose any card in play of targeted player",
                matchingFunc: { _, ctx, playArgs -> Bool in
                    playArgs.appendingRequiredInPlay(state: ctx.state)
                })
    }
    
    static func requireTargetSelf() -> PlayReq {
        PlayReq(id: "requireTargetSelf",
                desc: "Must be yourself as the target",
                priority: 0,
                matchingFunc: { _, ctx, playArgs -> Bool in
                    playArgs.appending(values: [ctx.actor.identifier], forArg: .target)
                })
    }
    
    static func requireTargetAt() -> PlayReq {
        PlayReq(id: "requireTargetAt",
                desc: "Must target any other player at distance of: ",
                priority: 0,
                matchingFunc: { param, ctx, playArgs -> Bool in
                    let distance = Parser.number(param)
                    let others = ctx.state.playOrder
                        .filter { $0 != ctx.actor.identifier }
                        .filter { ctx.state.distance(from: ctx.actor.identifier, to: $0) <= distance }
                    return playArgs.appending(values: others, forArg: .target)
                })
    }
    
    static func requireTargetReachable() -> PlayReq {
        PlayReq(id: "requireTargetReachable",
                desc: "Must target a player at reachable distance",
                priority: 0,
                matchingFunc: { _, ctx, playArgs -> Bool in
                    let distance = ctx.actor.weapon
                    let others = ctx.state.playOrder
                        .filter { $0 != ctx.actor.identifier }
                        .filter { ctx.state.distance(from: ctx.actor.identifier, to: $0) <= distance }
                    return playArgs.appending(values: others, forArg: .target)
                })
    }
    
    static func requireTargetOffender() -> PlayReq {
        PlayReq(id: "requireTargetOffender",
                desc: "Must target the player that just damaged you",
                priority: 0,
                matchingFunc: { _, ctx, playArgs -> Bool in
                    guard case let .looseHealth(player, offender) = ctx.event,
                          player == ctx.actor.identifier,
                          offender != player,
                          ctx.actor.health > 0 else {
                        return false
                    }
                    return playArgs.appending(values: [offender], forArg: .target)
                })
    }
    
    static func requireTargetEliminated() -> PlayReq {
        PlayReq(id: "requireTargetEliminated",
                desc: "Must target the player that just is eliminated",
                priority: 0,
                matchingFunc: { _, ctx, playArgs -> Bool in
                    guard case let .eliminate(target, _) = ctx.event,
                          target != ctx.actor.identifier else {
                        return false
                    }
                    return playArgs.appending(values: [target], forArg: .target)
                })
    }
    
    static func isTimesPerTurnMax() -> PlayReq {
        PlayReq(id: "isTimesPerTurnMax",
                desc: "May be played at most X-1 times during current turn",
                matchingFunc: { param, ctx, _ -> Bool in
                    let maxTimes = Parser.number(param, ctx: ctx)
                    if maxTimes == 0 {
                        return true
                    }
                    let playedCount = ctx.state.played.filter { $0 == ctx.ability }.count
                    return playedCount < maxTimes
                })
    }
    
    static func isHitCancelable() -> PlayReq {
        PlayReq(id: "isHitCancelable",
                desc: "Must be target of hit that is cancelable",
                matchingFunc: { _, ctx, _ -> Bool in
                    guard let hit = ctx.state.hits.first,
                          hit.player == ctx.actor.identifier,
                          hit.cancelable > 0 else {
                        return false
                    }
                    return true
                })
    }
    
    static func isHitEliminate() -> PlayReq {
        PlayReq(id: "isHitEliminate",
                desc: "Must be target of hit that will eliminates you",
                matchingFunc: { _, ctx, _ -> Bool in
                    guard let hit = ctx.state.hits.first,
                          hit.player == ctx.actor.identifier,
                          hit.abilities.contains("looseHealth"),
                          ctx.actor.health == 1 else {
                        return false
                    }
                    return true
                })
    }
    
    static func isHitName() -> PlayReq {
        PlayReq(id: "isHitName",
                desc: "Must be first to resolve hit named X.",
                priority: 0,
                matchingFunc: { param, ctx, _ -> Bool in
                    let hitName = Parser.string(param)
                    guard let hit = ctx.state.hits.first,
                          hit.player == ctx.actor.identifier, 
                          hit.name == hitName else {
                        return false
                    }
                    return true
                })
    }
    
    static func requireStoreCards() -> PlayReq {
        PlayReq(id: "requireStoreCards",
                desc: "Must choose choose X cards from store.",
                matchingFunc: { param, ctx, playArgs -> Bool in
                    let amount = Parser.number(param)
                    let cards = ctx.state.store
                        .map { $0.identifier }
                    return playArgs.appending(values: cards, by: amount, forArg: .requiredStore)
                })
    }
    
    static func requireDeckCards() -> PlayReq {
        PlayReq(id: "requireDeckCards",
                desc: "Must choose choose X cards from deck among (X + 1).",
                matchingFunc: { param, ctx, playArgs -> Bool in
                    let amount = Parser.number(param)
                    let cards = ctx.state.deck.prefix(amount + 1)
                        .map { $0.identifier }
                    return playArgs.appending(values: cards, by: amount, forArg: .requiredDeck)
                })
    }
    
    static func onHitCancelable() -> PlayReq {
        PlayReq(id: "onHitCancelable",
                desc: "When you are target of hit that is cancelable with 'missed' card",
                matchingFunc: { _, ctx, _ -> Bool in
                    guard case let .addHit(players, _, _, cancelable, _) = ctx.event,
                          players.contains(ctx.actor.identifier),
                          cancelable > 0 else {
                        return false
                    }
                    return true
                })
        
    }
    
    static func onPhase() -> PlayReq {
        PlayReq(id: "onPhase",
                desc: "When phase changed to: ",
                matchingFunc: { param, ctx, _ -> Bool in
                    let phase = Parser.number(param)
                    guard case let .setPhase(aPhase) = ctx.event,
                          phase == aPhase else {
                        return false
                    }
                    
                    return true
                })
    }
    
    static func onLooseHealth() -> PlayReq {
        PlayReq(id: "onLooseHealth",
                desc: "when you loose health but not eliminated",
                matchingFunc: { _, ctx, _ -> Bool in
                    guard case let .looseHealth(player, _) = ctx.event,
                          player == ctx.actor.identifier,
                          ctx.actor.health > 0 else {
                        return false
                    }
                    
                    return true
                })
    }
    
    static func onEliminated() -> PlayReq {
        PlayReq(id: "onEliminated",
                desc: "when you loose your last health",
                matchingFunc: { _, ctx, _ -> Bool in
                    guard case let .eliminate(player, _) = ctx.event,
                          player == ctx.actor.identifier else {
                        return false
                    }
                    
                    return true
                })
    }
    
    static func isHandExceedLimit() -> PlayReq {
        PlayReq(id: "isHandExceedLimit",
                desc: "when having more cards than hand limit",
                matchingFunc: { _, ctx, _ -> Bool in
                    ctx.actor.hand.count > ctx.actor.handLimit
                })
    }
    
    static func requireHandCards() -> PlayReq {
        PlayReq(id: "requireHandCards",
                desc: "Must choose X cards from your hand.",
                priority: 0,
                matchingFunc: { param, ctx, playArgs -> Bool in
                    let amount = Parser.number(param)
                    let cards = ctx.actor.hand
                        .map { $0.identifier }
                    return playArgs.appending(values: cards, by: amount, forArg: .requiredHand)
                })
    }
    
    static func onEliminatingRole() -> PlayReq {
        PlayReq(id: "onEliminatingRole",
                desc: "When you eliminated a player with role: ",
                matchingFunc: { param, ctx, _ -> Bool in
                    let role = Parser.role(param)
                    guard case let .eliminate(target, offender) = ctx.event,
                          offender != target,
                          offender == ctx.actor.identifier,
                          let targetObject = ctx.state.players[target],
                          targetObject.role == role else {
                        return false
                    }
                    return true
                })
    }
    
    static func onHandEmpty() -> PlayReq {
        PlayReq(id: "onHandEmpty",
                desc: "When your hand is empty",
                matchingFunc: { _, ctx, _ -> Bool in
                    switch ctx.event {
                    case let .play(player, _):
                        return player == ctx.actor.identifier && ctx.actor.hand.isEmpty
                        
                    case let .discardHand(player, _):
                        return player == ctx.actor.identifier && ctx.actor.hand.isEmpty
                        
                    case let .equip(player, _):
                        return player == ctx.actor.identifier && ctx.actor.hand.isEmpty
                        
                    case let .handicap(player, _, _):
                        return player == ctx.actor.identifier && ctx.actor.hand.isEmpty
                        
                    case let .drawHand(_, target, _):
                        return target == ctx.actor.identifier && ctx.actor.hand.isEmpty
                        
                    default:
                        return false
                    }
                })
    }
    
    static func onEventsEmpty() -> PlayReq {
        PlayReq(id: "onEventsEmpty",
                desc: "When events queue is empty",
                matchingFunc: { _, ctx, _ -> Bool in
                    guard case .emptyQueue = ctx.event else {
                        return false
                    }
                    return true
                })
    }
}

private extension Array where Element == [PlayArg: [String]] {
    
    mutating func appending(values: [String], by count: Int = 1, forArg arg: PlayArg) -> Bool {
        let argValues = values.combine(by: count)
        guard !argValues.isEmpty else {
            return false
        }
        
        var oldArgs = self
        if oldArgs.isEmpty {
            oldArgs = [[:]]
        }
        self = []
        
        for oldArg in oldArgs {
            for value in argValues {
                var dict = oldArg
                dict[arg] = value
                self.append(dict)
            }
        }
        
        return true
    }
    
    mutating func appendingRequiredInPlay(state: StateProtocol) -> Bool {
        var oldArgs = self
        if oldArgs.isEmpty {
            oldArgs = [[:]]
        }
        self = []
        
        for oldArg in oldArgs {
            guard let target = oldArg[.target]?.first else {
                return false
            }
            
            let cards = state.players[target]!.inPlay.map { $0.identifier }
            guard !cards.isEmpty else {
                continue
            }
            
            for card in cards {
                var dict = oldArg
                dict[.requiredInPlay] = [card]
                self.append(dict)
            }
        }
        
        return !self.isEmpty
    }
}

private enum Parser {
    
    static func number(_ param: Any, ctx: PlayReqContext? = nil) -> Int {
        if let stringValue = param as? String,
           stringValue == "bangsPerTurn" {
            return ctx!.actor.bangsPerTurn
        } else if let value = param as? Int {
            return value
        } else {
            fatalError("Invalid number parameter")
        }
    }
    
    static func string(_ param: Any) -> String {
        guard let value = param as? String else {
            fatalError("Invalid String parameter")
        }
        return value
    }
    
    static func role(_ param: Any) -> Role {
        guard let rawValue = param as? String,
              let role = Role(rawValue: rawValue) else {
            fatalError("Invalid role parameter")
        }
        return role
    }
}
