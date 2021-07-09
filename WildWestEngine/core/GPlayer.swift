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
    public let attributes: Card.Attributes
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
                attributes: Card.Attributes,
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
        inPlayCards.compactMap { $0.abilities["weapon"] }.max() ?? 1
    }
    
    public var scope: Int {
        inPlayCards.compactMap { $0.abilities["scope"] }.count
    }
    
    public var mustang: Int {
        inPlayCards.compactMap { $0.abilities["mustang"] }.count
    }
    
    public var bangsPerTurn: Int {
        inPlayCards.compactMap { $0.abilities["bangsPerTurn"] }.max() ?? 1
    }
    
    public var bangsCancelable: Int {
        inPlayCards.compactMap { $0.abilities["bangsCancelable"] }.max() ?? 1
    }
    
    public var flippedCards: Int {
        inPlayCards.compactMap { $0.abilities["flippedCards"] }.max() ?? 1
    }
    
    public var handLimit: Int {
        inPlayCards.compactMap { $0.abilities["handLimit"] }.max() ?? health
    }
    
    private var inPlayCards: [BaseCardProtocol] {
        [self] + inPlay
    }
}
