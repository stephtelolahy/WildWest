import Cuckoo
@testable import WildWest


 class MockGameAIProtocol: GameAIProtocol, Cuckoo.ProtocolMock {
    
     typealias MocksType = GameAIProtocol
    
     typealias Stubbing = __StubbingProxy_GameAIProtocol
     typealias Verification = __VerificationProxy_GameAIProtocol

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: GameAIProtocol?

     func enableDefaultImplementation(_ stub: GameAIProtocol) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
     func choose(_ actions: [GameAction]) -> GameAction {
        
    return cuckoo_manager.call("choose(_: [GameAction]) -> GameAction",
            parameters: (actions),
            escapingParameters: (actions),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.choose(actions))
        
    }
    

	 struct __StubbingProxy_GameAIProtocol: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func choose<M1: Cuckoo.Matchable>(_ actions: M1) -> Cuckoo.ProtocolStubFunction<([GameAction]), GameAction> where M1.MatchedType == [GameAction] {
	        let matchers: [Cuckoo.ParameterMatcher<([GameAction])>] = [wrap(matchable: actions) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockGameAIProtocol.self, method: "choose(_: [GameAction]) -> GameAction", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_GameAIProtocol: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func choose<M1: Cuckoo.Matchable>(_ actions: M1) -> Cuckoo.__DoNotUse<([GameAction]), GameAction> where M1.MatchedType == [GameAction] {
	        let matchers: [Cuckoo.ParameterMatcher<([GameAction])>] = [wrap(matchable: actions) { $0 }]
	        return cuckoo_manager.verify("choose(_: [GameAction]) -> GameAction", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class GameAIProtocolStub: GameAIProtocol {
    

    

    
     func choose(_ actions: [GameAction]) -> GameAction  {
        return DefaultValueRegistry.defaultValue(for: (GameAction).self)
    }
    
}


import Cuckoo
@testable import WildWest


 class MockGameAction: GameAction, Cuckoo.ProtocolMock {
    
     typealias MocksType = GameAction
    
     typealias Stubbing = __StubbingProxy_GameAction
     typealias Verification = __VerificationProxy_GameAction

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: GameAction?

     func enableDefaultImplementation(_ stub: GameAction) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
     func isAllowed() -> Bool {
        
    return cuckoo_manager.call("isAllowed() -> Bool",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.isAllowed())
        
    }
    
    
    
     func execute(_ game: Game) -> Game {
        
    return cuckoo_manager.call("execute(_: Game) -> Game",
            parameters: (game),
            escapingParameters: (game),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.execute(game))
        
    }
    
    
    
     func undo(_ game: Game) -> Game {
        
    return cuckoo_manager.call("undo(_: Game) -> Game",
            parameters: (game),
            escapingParameters: (game),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.undo(game))
        
    }
    

	 struct __StubbingProxy_GameAction: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func isAllowed() -> Cuckoo.ProtocolStubFunction<(), Bool> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockGameAction.self, method: "isAllowed() -> Bool", parameterMatchers: matchers))
	    }
	    
	    func execute<M1: Cuckoo.Matchable>(_ game: M1) -> Cuckoo.ProtocolStubFunction<(Game), Game> where M1.MatchedType == Game {
	        let matchers: [Cuckoo.ParameterMatcher<(Game)>] = [wrap(matchable: game) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockGameAction.self, method: "execute(_: Game) -> Game", parameterMatchers: matchers))
	    }
	    
	    func undo<M1: Cuckoo.Matchable>(_ game: M1) -> Cuckoo.ProtocolStubFunction<(Game), Game> where M1.MatchedType == Game {
	        let matchers: [Cuckoo.ParameterMatcher<(Game)>] = [wrap(matchable: game) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockGameAction.self, method: "undo(_: Game) -> Game", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_GameAction: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func isAllowed() -> Cuckoo.__DoNotUse<(), Bool> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("isAllowed() -> Bool", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func execute<M1: Cuckoo.Matchable>(_ game: M1) -> Cuckoo.__DoNotUse<(Game), Game> where M1.MatchedType == Game {
	        let matchers: [Cuckoo.ParameterMatcher<(Game)>] = [wrap(matchable: game) { $0 }]
	        return cuckoo_manager.verify("execute(_: Game) -> Game", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func undo<M1: Cuckoo.Matchable>(_ game: M1) -> Cuckoo.__DoNotUse<(Game), Game> where M1.MatchedType == Game {
	        let matchers: [Cuckoo.ParameterMatcher<(Game)>] = [wrap(matchable: game) { $0 }]
	        return cuckoo_manager.verify("undo(_: Game) -> Game", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class GameActionStub: GameAction {
    

    

    
     func isAllowed() -> Bool  {
        return DefaultValueRegistry.defaultValue(for: (Bool).self)
    }
    
     func execute(_ game: Game) -> Game  {
        return DefaultValueRegistry.defaultValue(for: (Game).self)
    }
    
     func undo(_ game: Game) -> Game  {
        return DefaultValueRegistry.defaultValue(for: (Game).self)
    }
    
}


import Cuckoo
@testable import WildWest


 class MockGameEngineProtocol: GameEngineProtocol, Cuckoo.ProtocolMock {
    
     typealias MocksType = GameEngineProtocol
    
     typealias Stubbing = __StubbingProxy_GameEngineProtocol
     typealias Verification = __VerificationProxy_GameEngineProtocol

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: GameEngineProtocol?

     func enableDefaultImplementation(_ stub: GameEngineProtocol) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
     func run()  {
        
    return cuckoo_manager.call("run()",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.run())
        
    }
    

	 struct __StubbingProxy_GameEngineProtocol: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func run() -> Cuckoo.ProtocolStubNoReturnFunction<()> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockGameEngineProtocol.self, method: "run()", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_GameEngineProtocol: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func run() -> Cuckoo.__DoNotUse<(), Void> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("run()", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class GameEngineProtocolStub: GameEngineProtocol {
    

    

    
     func run()   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
}


import Cuckoo
@testable import WildWest


 class MockGameRendererProtocol: GameRendererProtocol, Cuckoo.ProtocolMock {
    
     typealias MocksType = GameRendererProtocol
    
     typealias Stubbing = __StubbingProxy_GameRendererProtocol
     typealias Verification = __VerificationProxy_GameRendererProtocol

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: GameRendererProtocol?

     func enableDefaultImplementation(_ stub: GameRendererProtocol) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
     func render(_ game: Game)  {
        
    return cuckoo_manager.call("render(_: Game)",
            parameters: (game),
            escapingParameters: (game),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.render(game))
        
    }
    

	 struct __StubbingProxy_GameRendererProtocol: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func render<M1: Cuckoo.Matchable>(_ game: M1) -> Cuckoo.ProtocolStubNoReturnFunction<(Game)> where M1.MatchedType == Game {
	        let matchers: [Cuckoo.ParameterMatcher<(Game)>] = [wrap(matchable: game) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockGameRendererProtocol.self, method: "render(_: Game)", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_GameRendererProtocol: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func render<M1: Cuckoo.Matchable>(_ game: M1) -> Cuckoo.__DoNotUse<(Game), Void> where M1.MatchedType == Game {
	        let matchers: [Cuckoo.ParameterMatcher<(Game)>] = [wrap(matchable: game) { $0 }]
	        return cuckoo_manager.verify("render(_: Game)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class GameRendererProtocolStub: GameRendererProtocol {
    

    

    
     func render(_ game: Game)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
}


import Cuckoo
@testable import WildWest


 class MockGameRulesProtocol: GameRulesProtocol, Cuckoo.ProtocolMock {
    
     typealias MocksType = GameRulesProtocol
    
     typealias Stubbing = __StubbingProxy_GameRulesProtocol
     typealias Verification = __VerificationProxy_GameRulesProtocol

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: GameRulesProtocol?

     func enableDefaultImplementation(_ stub: GameRulesProtocol) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
     func isOver(_ game: Game) -> Bool {
        
    return cuckoo_manager.call("isOver(_: Game) -> Bool",
            parameters: (game),
            escapingParameters: (game),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.isOver(game))
        
    }
    
    
    
     func possibleActions(_ game: Game) -> [GameAction] {
        
    return cuckoo_manager.call("possibleActions(_: Game) -> [GameAction]",
            parameters: (game),
            escapingParameters: (game),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.possibleActions(game))
        
    }
    

	 struct __StubbingProxy_GameRulesProtocol: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func isOver<M1: Cuckoo.Matchable>(_ game: M1) -> Cuckoo.ProtocolStubFunction<(Game), Bool> where M1.MatchedType == Game {
	        let matchers: [Cuckoo.ParameterMatcher<(Game)>] = [wrap(matchable: game) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockGameRulesProtocol.self, method: "isOver(_: Game) -> Bool", parameterMatchers: matchers))
	    }
	    
	    func possibleActions<M1: Cuckoo.Matchable>(_ game: M1) -> Cuckoo.ProtocolStubFunction<(Game), [GameAction]> where M1.MatchedType == Game {
	        let matchers: [Cuckoo.ParameterMatcher<(Game)>] = [wrap(matchable: game) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockGameRulesProtocol.self, method: "possibleActions(_: Game) -> [GameAction]", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_GameRulesProtocol: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func isOver<M1: Cuckoo.Matchable>(_ game: M1) -> Cuckoo.__DoNotUse<(Game), Bool> where M1.MatchedType == Game {
	        let matchers: [Cuckoo.ParameterMatcher<(Game)>] = [wrap(matchable: game) { $0 }]
	        return cuckoo_manager.verify("isOver(_: Game) -> Bool", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func possibleActions<M1: Cuckoo.Matchable>(_ game: M1) -> Cuckoo.__DoNotUse<(Game), [GameAction]> where M1.MatchedType == Game {
	        let matchers: [Cuckoo.ParameterMatcher<(Game)>] = [wrap(matchable: game) { $0 }]
	        return cuckoo_manager.verify("possibleActions(_: Game) -> [GameAction]", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class GameRulesProtocolStub: GameRulesProtocol {
    

    

    
     func isOver(_ game: Game) -> Bool  {
        return DefaultValueRegistry.defaultValue(for: (Bool).self)
    }
    
     func possibleActions(_ game: Game) -> [GameAction]  {
        return DefaultValueRegistry.defaultValue(for: ([GameAction]).self)
    }
    
}


import Cuckoo
@testable import WildWest


 class MockGameStateProtocol: GameStateProtocol, Cuckoo.ProtocolMock {
    
     typealias MocksType = GameStateProtocol
    
     typealias Stubbing = __StubbingProxy_GameStateProtocol
     typealias Verification = __VerificationProxy_GameStateProtocol

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: GameStateProtocol?

     func enableDefaultImplementation(_ stub: GameStateProtocol) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
     func state() -> Game {
        
    return cuckoo_manager.call("state() -> Game",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.state())
        
    }
    
    
    
     func update(_ game: Game)  {
        
    return cuckoo_manager.call("update(_: Game)",
            parameters: (game),
            escapingParameters: (game),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.update(game))
        
    }
    

	 struct __StubbingProxy_GameStateProtocol: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func state() -> Cuckoo.ProtocolStubFunction<(), Game> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockGameStateProtocol.self, method: "state() -> Game", parameterMatchers: matchers))
	    }
	    
	    func update<M1: Cuckoo.Matchable>(_ game: M1) -> Cuckoo.ProtocolStubNoReturnFunction<(Game)> where M1.MatchedType == Game {
	        let matchers: [Cuckoo.ParameterMatcher<(Game)>] = [wrap(matchable: game) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockGameStateProtocol.self, method: "update(_: Game)", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_GameStateProtocol: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func state() -> Cuckoo.__DoNotUse<(), Game> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("state() -> Game", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func update<M1: Cuckoo.Matchable>(_ game: M1) -> Cuckoo.__DoNotUse<(Game), Void> where M1.MatchedType == Game {
	        let matchers: [Cuckoo.ParameterMatcher<(Game)>] = [wrap(matchable: game) { $0 }]
	        return cuckoo_manager.verify("update(_: Game)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class GameStateProtocolStub: GameStateProtocol {
    

    

    
     func state() -> Game  {
        return DefaultValueRegistry.defaultValue(for: (Game).self)
    }
    
     func update(_ game: Game)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
}

