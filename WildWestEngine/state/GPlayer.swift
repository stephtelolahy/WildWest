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
    
    // MARK: - CardProtocol
    
    public var type: CardType { .figure }
    
    public var suit: String { "" }
    
    public var value: String { " " }
}
