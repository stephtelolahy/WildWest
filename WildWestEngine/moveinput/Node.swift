//
//  Node.swift
//  WildWestEngine
//
//  Created by TELOLAHY Hugues Stéphano on 10/06/2021.
//  Copyright © 2021 creativeGames. All rights reserved.
//

import Foundation

public struct Node<T: Equatable>: Equatable {
    public let title: String
    public var value: T?
    public var children: [Node]?
    
    public init(title: String, value: T? = nil, children: [Node]? = nil) {
        self.title = title
        self.value = value
        self.children = children
    }
}
