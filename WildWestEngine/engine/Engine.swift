//
//  Engine.swift
//  CardGameEngine
//
//  Created by Hugues Stephano Telolahy on 20/10/2020.
//

import RxSwift

public protocol EngineProtocol {
    func execute(_ move: GMove)
    func refresh()
}
