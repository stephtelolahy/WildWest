//
//  GPlayer.swift
//  CardGameEngine
//
//  Created by Hugues Stephano Telolahy on 25/10/2020.
//

public class GPlayer: PlayerProtocol {
    
    // MARK: - Properties
    
    public let identifier: String
    public let name: String
    public let desc: String
    public let attributes: [CardAttributeKey: Any]
    public let abilities: Set<String>
    public let role: Role?
    public var health: Int
    public var hand: [CardProtocol]
    public var inPlay: [CardProtocol]
    
    // MARK: - Init
    
    public init(identifier: String,
                name: String,
                desc: String,
                attributes: [CardAttributeKey: Any],
                abilities: Set<String>,
                role: Role?,
                health: Int,
                hand: [CardProtocol],
                inPlay: [CardProtocol]) {
        self.identifier = identifier
        self.name = name
        self.desc = desc
        self.attributes = attributes
        self.abilities = abilities
        self.role = role
        self.health = health
        self.hand = hand
        self.inPlay = inPlay
    }
    
    public convenience init(_ player: PlayerProtocol) {
        self.init(identifier: player.identifier,
                  name: player.name,
                  desc: player.desc,
                  attributes: player.attributes,
                  abilities: player.abilities,
                  role: player.role,
                  health: player.health,
                  hand: player.hand,
                  inPlay: player.inPlay)
    }
    
    // MARK: - PlayerComputedProtocol f(InPlay)
    
    public var weapon: Int {
        cards.compactMap { $0.attributes[.weapon] as? Int }.max() ?? 1
    }
    
    public var bangsPerTurn: Int {
        cards.compactMap { $0.attributes[.bangsPerTurn] as? Int }.max() ?? 1
    }
    
    private var cards: [BaseCardProtocol] {
        [self] + inPlay
    }
    
    // MARK: - PlayerComputedProtocol f(Attributes)
    
    public var maxHealth: Int {
        attributes[.bullets] as? Int ?? 0
    }
    
    public var bangsCancelable: Int {
        attributes[.bangsCancelable] as? Int ?? 1
    }
    
    public var flippedCards: Int {
        attributes[.flippedCards] as? Int ?? 1
    }
    
    public var handLimit: Int {
        attributes[.handLimit] as? Int ?? health
    }
}
