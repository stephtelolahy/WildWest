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
    public let abilities: [String: Int]
    public let attributes: CardAttributesProtocol
    public let role: Role?
    public let maxHealth: Int
    public var health: Int
    public var hand: [CardProtocol]
    public var inPlay: [CardProtocol]
    
    // MARK: - Init
    
    public init(identifier: String,
                name: String,
                desc: String,
                abilities: [String: Int],
                attributes: CardAttributesProtocol,
                role: Role?,
                maxHealth: Int,
                health: Int,
                hand: [CardProtocol],
                inPlay: [CardProtocol]) {
        self.identifier = identifier
        self.name = name
        self.desc = desc
        self.abilities = abilities
        self.attributes = attributes
        self.role = role
        self.maxHealth = maxHealth
        self.health = health
        self.hand = hand
        self.inPlay = inPlay
    }
    
    public convenience init(_ player: PlayerProtocol) {
        self.init(identifier: player.identifier,
                  name: player.name,
                  desc: player.desc,
                  abilities: player.abilities,
                  attributes: player.attributes,
                  role: player.role,
                  maxHealth: player.maxHealth,
                  health: player.health,
                  hand: player.hand,
                  inPlay: player.inPlay)
    }
    
    // MARK: - PlayerComputedProtocol
    
    public var weapon: Int {
        cards.compactMap { $0.attributes.weapon }.max() ?? 1
    }
    
    public var scope: Int {
        cards.compactMap { $0.attributes.scope }.reduce(0, +)
    }
    
    public var mustang: Int {
        cards.compactMap { $0.attributes.mustang }.reduce(0, +)
    }
    
    public var bangsPerTurn: Int {
        cards.compactMap { $0.attributes.bangsPerTurn }.max() ?? 1
    }
    
    public var bangsCancelable: Int {
        cards.compactMap { $0.attributes.bangsCancelable }.max() ?? 1
    }
    
    public var flippedCards: Int {
        cards.compactMap { $0.attributes.flippedCards }.max() ?? 1
    }
    
    public var handLimit: Int {
        cards.compactMap { $0.attributes.handLimit }.max() ?? health
    }
    
    private var cards: [BaseCardProtocol] {
        [self] + inPlay
    }
}
