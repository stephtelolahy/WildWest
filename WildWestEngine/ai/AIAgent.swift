//
//  AIAgent.swift
//  CardGameEngine
//
//  Created by Hugues Stephano Telolahy on 05/11/2020.
//
import RxSwift

public protocol AIAgentProtocol {
    func observe(_ database: RestrictedDatabaseProtocol)
}

public class AIAgent: AIAgentProtocol {
    
    private let player: String
    private let engine: EngineProtocol
    private let ai: AIProtocol
    private let roleEstimator: RoleEstimatorProtocol
    private let disposeBag = DisposeBag()
    private var state: StateProtocol?
    
    public init(player: String,
                engine: EngineProtocol,
                ai: AIProtocol,
                roleEstimator: RoleEstimatorProtocol) {
        self.player = player
        self.engine = engine
        self.ai = ai
        self.roleEstimator = roleEstimator
    }
    
    public func observe(_ database: RestrictedDatabaseProtocol) {
        database.state(observedBy: player).subscribe(onNext: { [weak self] state in
            self?.state = state
        })
        .disposed(by: disposeBag)
        
        database.event.subscribe(onNext: { [weak self] event in
            self?.handleEvent(event)
        })
        .disposed(by: disposeBag)
    }
}

private extension AIAgent {
    
    func handleEvent(_ event: GEvent) {
        switch event {
        case let .run(move):
            roleEstimator.update(on: move)
            
        case let .activate(moves):
            let attributedMoves = moves.filter { $0.actor == player }
            guard !attributedMoves.isEmpty, 
                  let state = self.state else {
                return
            }
            
            let bestMove = ai.bestMove(among: attributedMoves, in: state)
            engine.execute(bestMove)
            
        default:
            break
        }
    }
}
