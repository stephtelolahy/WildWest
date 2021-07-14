//
//  RoleStrategy.swift
//  CardGameEngine
//
//  Created by Hugues Stephano Telolahy on 06/11/2020.
//

// Define the strategy of a role againts another role
// 1: enemy
// -1: teammate
// 0: netral
public protocol RoleStrategyProtocol {
    func relationship(of role: Role, to otherRole: Role, in state: StateProtocol) -> Int
}

public class RoleStrategy: RoleStrategyProtocol {
    
    public init() {
    }
    
    public func relationship(of role: Role, to otherRole: Role, in state: StateProtocol) -> Int {
        switch role {
        case .sheriff:
            return deputyStrategy[otherRole]!
        case .outlaw:
            return outlawStrategy[otherRole]!
        case .deputy:
            return deputyStrategy[otherRole]!
        case .renegade:
            if state.playOrder.count >= 3 {
                return renegadeStrategy[otherRole]!
            } else {
                return outlawStrategy[otherRole]!
            }
        }
    }
    
    // MARK: Private
    
    private let outlawStrategy: [Role: Int] = 
        [ .sheriff: 1,
          .outlaw: -1, 
          .deputy: 0,
          .renegade: 0]
    
    private let deputyStrategy: [Role: Int] = 
        [ .sheriff: -1,
          .outlaw: 1, 
          .deputy: -1,
          .renegade: 0]
    
    private let renegadeStrategy: [Role: Int] = 
        [ .sheriff: -1,
          .outlaw: 1, 
          .deputy: 1,
          .renegade: 0]
}
