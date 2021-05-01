//
//  GEngine.swift
//  CardGameEngine
//
//  Created by Hugues Stephano Telolahy on 28/10/2020.
//

import RxSwift

public class GEngine: EngineProtocol {
    
    // MARK: - Dependencies
    
    private let loop: GLoopProtocol
    
    // MARK: - Private
    
    private var running: Bool = false
    private let disposeBag = DisposeBag()
    
    // MARK: - Init
    
    public init(loop: GLoopProtocol) {
        self.loop = loop
    }
    
    // MARK: - EngineProtocol
    
    public func execute(_ move: GMove) {
        run(move)
    }
    
    public func refresh() {
        run(nil)
    }
}

private extension GEngine {
    
    func run(_ move: GMove?) {
        guard !running else {
            return
        }
        
        running = true
        loop.run(move)
            .delaySubscription(.milliseconds(1), scheduler: MainScheduler.instance)
            .subscribe(onCompleted: { [weak self] in
                self?.running = false
            }, onError: { error in
                fatalError(error.localizedDescription)
            }).disposed(by: disposeBag)
    }
}
