import Cuckoo
@testable import WildWest


 class MockGameUpdateProtocol: GameUpdateProtocol, Cuckoo.ProtocolMock {
    
     typealias MocksType = GameUpdateProtocol
    
     typealias Stubbing = __StubbingProxy_GameUpdateProtocol
     typealias Verification = __VerificationProxy_GameUpdateProtocol

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: GameUpdateProtocol?

     func enableDefaultImplementation(_ stub: GameUpdateProtocol) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
     func execute(in state: MutableGameStateProtocol)  {
        
    return cuckoo_manager.call("execute(in: MutableGameStateProtocol)",
            parameters: (state),
            escapingParameters: (state),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.execute(in: state))
        
    }
    

	 struct __StubbingProxy_GameUpdateProtocol: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func execute<M1: Cuckoo.Matchable>(in state: M1) -> Cuckoo.ProtocolStubNoReturnFunction<(MutableGameStateProtocol)> where M1.MatchedType == MutableGameStateProtocol {
	        let matchers: [Cuckoo.ParameterMatcher<(MutableGameStateProtocol)>] = [wrap(matchable: state) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockGameUpdateProtocol.self, method: "execute(in: MutableGameStateProtocol)", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_GameUpdateProtocol: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func execute<M1: Cuckoo.Matchable>(in state: M1) -> Cuckoo.__DoNotUse<(MutableGameStateProtocol), Void> where M1.MatchedType == MutableGameStateProtocol {
	        let matchers: [Cuckoo.ParameterMatcher<(MutableGameStateProtocol)>] = [wrap(matchable: state) { $0 }]
	        return cuckoo_manager.verify("execute(in: MutableGameStateProtocol)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class GameUpdateProtocolStub: GameUpdateProtocol {
    

    

    
     func execute(in state: MutableGameStateProtocol)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
}


import Cuckoo
@testable import WildWest


 class MockRangeCalculatorProtocol: RangeCalculatorProtocol, Cuckoo.ProtocolMock {
    
     typealias MocksType = RangeCalculatorProtocol
    
     typealias Stubbing = __StubbingProxy_RangeCalculatorProtocol
     typealias Verification = __VerificationProxy_RangeCalculatorProtocol

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: RangeCalculatorProtocol?

     func enableDefaultImplementation(_ stub: RangeCalculatorProtocol) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
     func distance(from playerId: String, to otherId: String, in state: GameStateProtocol) -> Int {
        
    return cuckoo_manager.call("distance(from: String, to: String, in: GameStateProtocol) -> Int",
            parameters: (playerId, otherId, state),
            escapingParameters: (playerId, otherId, state),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.distance(from: playerId, to: otherId, in: state))
        
    }
    
    
    
     func reachableDistance(of player: PlayerProtocol) -> Int {
        
    return cuckoo_manager.call("reachableDistance(of: PlayerProtocol) -> Int",
            parameters: (player),
            escapingParameters: (player),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.reachableDistance(of: player))
        
    }
    
    
    
     func maximumNumberOfShoots(of player: PlayerProtocol) -> Int {
        
    return cuckoo_manager.call("maximumNumberOfShoots(of: PlayerProtocol) -> Int",
            parameters: (player),
            escapingParameters: (player),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.maximumNumberOfShoots(of: player))
        
    }
    

	 struct __StubbingProxy_RangeCalculatorProtocol: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func distance<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable>(from playerId: M1, to otherId: M2, in state: M3) -> Cuckoo.ProtocolStubFunction<(String, String, GameStateProtocol), Int> where M1.MatchedType == String, M2.MatchedType == String, M3.MatchedType == GameStateProtocol {
	        let matchers: [Cuckoo.ParameterMatcher<(String, String, GameStateProtocol)>] = [wrap(matchable: playerId) { $0.0 }, wrap(matchable: otherId) { $0.1 }, wrap(matchable: state) { $0.2 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockRangeCalculatorProtocol.self, method: "distance(from: String, to: String, in: GameStateProtocol) -> Int", parameterMatchers: matchers))
	    }
	    
	    func reachableDistance<M1: Cuckoo.Matchable>(of player: M1) -> Cuckoo.ProtocolStubFunction<(PlayerProtocol), Int> where M1.MatchedType == PlayerProtocol {
	        let matchers: [Cuckoo.ParameterMatcher<(PlayerProtocol)>] = [wrap(matchable: player) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockRangeCalculatorProtocol.self, method: "reachableDistance(of: PlayerProtocol) -> Int", parameterMatchers: matchers))
	    }
	    
	    func maximumNumberOfShoots<M1: Cuckoo.Matchable>(of player: M1) -> Cuckoo.ProtocolStubFunction<(PlayerProtocol), Int> where M1.MatchedType == PlayerProtocol {
	        let matchers: [Cuckoo.ParameterMatcher<(PlayerProtocol)>] = [wrap(matchable: player) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockRangeCalculatorProtocol.self, method: "maximumNumberOfShoots(of: PlayerProtocol) -> Int", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_RangeCalculatorProtocol: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func distance<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable>(from playerId: M1, to otherId: M2, in state: M3) -> Cuckoo.__DoNotUse<(String, String, GameStateProtocol), Int> where M1.MatchedType == String, M2.MatchedType == String, M3.MatchedType == GameStateProtocol {
	        let matchers: [Cuckoo.ParameterMatcher<(String, String, GameStateProtocol)>] = [wrap(matchable: playerId) { $0.0 }, wrap(matchable: otherId) { $0.1 }, wrap(matchable: state) { $0.2 }]
	        return cuckoo_manager.verify("distance(from: String, to: String, in: GameStateProtocol) -> Int", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func reachableDistance<M1: Cuckoo.Matchable>(of player: M1) -> Cuckoo.__DoNotUse<(PlayerProtocol), Int> where M1.MatchedType == PlayerProtocol {
	        let matchers: [Cuckoo.ParameterMatcher<(PlayerProtocol)>] = [wrap(matchable: player) { $0 }]
	        return cuckoo_manager.verify("reachableDistance(of: PlayerProtocol) -> Int", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func maximumNumberOfShoots<M1: Cuckoo.Matchable>(of player: M1) -> Cuckoo.__DoNotUse<(PlayerProtocol), Int> where M1.MatchedType == PlayerProtocol {
	        let matchers: [Cuckoo.ParameterMatcher<(PlayerProtocol)>] = [wrap(matchable: player) { $0 }]
	        return cuckoo_manager.verify("maximumNumberOfShoots(of: PlayerProtocol) -> Int", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class RangeCalculatorProtocolStub: RangeCalculatorProtocol {
    

    

    
     func distance(from playerId: String, to otherId: String, in state: GameStateProtocol) -> Int  {
        return DefaultValueRegistry.defaultValue(for: (Int).self)
    }
    
     func reachableDistance(of player: PlayerProtocol) -> Int  {
        return DefaultValueRegistry.defaultValue(for: (Int).self)
    }
    
     func maximumNumberOfShoots(of player: PlayerProtocol) -> Int  {
        return DefaultValueRegistry.defaultValue(for: (Int).self)
    }
    
}


import Cuckoo
@testable import WildWest


 class MockRuleProtocol: RuleProtocol, Cuckoo.ProtocolMock {
    
     typealias MocksType = RuleProtocol
    
     typealias Stubbing = __StubbingProxy_RuleProtocol
     typealias Verification = __VerificationProxy_RuleProtocol

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: RuleProtocol?

     func enableDefaultImplementation(_ stub: RuleProtocol) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
     func match(with state: GameStateProtocol) -> [ActionProtocol]? {
        
    return cuckoo_manager.call("match(with: GameStateProtocol) -> [ActionProtocol]?",
            parameters: (state),
            escapingParameters: (state),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.match(with: state))
        
    }
    

	 struct __StubbingProxy_RuleProtocol: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func match<M1: Cuckoo.Matchable>(with state: M1) -> Cuckoo.ProtocolStubFunction<(GameStateProtocol), [ActionProtocol]?> where M1.MatchedType == GameStateProtocol {
	        let matchers: [Cuckoo.ParameterMatcher<(GameStateProtocol)>] = [wrap(matchable: state) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockRuleProtocol.self, method: "match(with: GameStateProtocol) -> [ActionProtocol]?", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_RuleProtocol: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func match<M1: Cuckoo.Matchable>(with state: M1) -> Cuckoo.__DoNotUse<(GameStateProtocol), [ActionProtocol]?> where M1.MatchedType == GameStateProtocol {
	        let matchers: [Cuckoo.ParameterMatcher<(GameStateProtocol)>] = [wrap(matchable: state) { $0 }]
	        return cuckoo_manager.verify("match(with: GameStateProtocol) -> [ActionProtocol]?", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class RuleProtocolStub: RuleProtocol {
    

    

    
     func match(with state: GameStateProtocol) -> [ActionProtocol]?  {
        return DefaultValueRegistry.defaultValue(for: ([ActionProtocol]?).self)
    }
    
}



 class MockActionProtocol: ActionProtocol, Cuckoo.ProtocolMock {
    
     typealias MocksType = ActionProtocol
    
     typealias Stubbing = __StubbingProxy_ActionProtocol
     typealias Verification = __VerificationProxy_ActionProtocol

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: ActionProtocol?

     func enableDefaultImplementation(_ stub: ActionProtocol) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    
    
    
     var actorId: String {
        get {
            return cuckoo_manager.getter("actorId",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.actorId)
        }
        
    }
    
    
    
     var cardId: String {
        get {
            return cuckoo_manager.getter("cardId",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.cardId)
        }
        
    }
    
    
    
     var description: String {
        get {
            return cuckoo_manager.getter("description",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.description)
        }
        
    }
    

    

    
    
    
     func execute(in state: GameStateProtocol) -> [GameUpdateProtocol] {
        
    return cuckoo_manager.call("execute(in: GameStateProtocol) -> [GameUpdateProtocol]",
            parameters: (state),
            escapingParameters: (state),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.execute(in: state))
        
    }
    

	 struct __StubbingProxy_ActionProtocol: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    var actorId: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockActionProtocol, String> {
	        return .init(manager: cuckoo_manager, name: "actorId")
	    }
	    
	    
	    var cardId: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockActionProtocol, String> {
	        return .init(manager: cuckoo_manager, name: "cardId")
	    }
	    
	    
	    var description: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockActionProtocol, String> {
	        return .init(manager: cuckoo_manager, name: "description")
	    }
	    
	    
	    func execute<M1: Cuckoo.Matchable>(in state: M1) -> Cuckoo.ProtocolStubFunction<(GameStateProtocol), [GameUpdateProtocol]> where M1.MatchedType == GameStateProtocol {
	        let matchers: [Cuckoo.ParameterMatcher<(GameStateProtocol)>] = [wrap(matchable: state) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockActionProtocol.self, method: "execute(in: GameStateProtocol) -> [GameUpdateProtocol]", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_ActionProtocol: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	    
	    var actorId: Cuckoo.VerifyReadOnlyProperty<String> {
	        return .init(manager: cuckoo_manager, name: "actorId", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var cardId: Cuckoo.VerifyReadOnlyProperty<String> {
	        return .init(manager: cuckoo_manager, name: "cardId", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var description: Cuckoo.VerifyReadOnlyProperty<String> {
	        return .init(manager: cuckoo_manager, name: "description", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	
	    
	    @discardableResult
	    func execute<M1: Cuckoo.Matchable>(in state: M1) -> Cuckoo.__DoNotUse<(GameStateProtocol), [GameUpdateProtocol]> where M1.MatchedType == GameStateProtocol {
	        let matchers: [Cuckoo.ParameterMatcher<(GameStateProtocol)>] = [wrap(matchable: state) { $0 }]
	        return cuckoo_manager.verify("execute(in: GameStateProtocol) -> [GameUpdateProtocol]", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class ActionProtocolStub: ActionProtocol {
    
    
     var actorId: String {
        get {
            return DefaultValueRegistry.defaultValue(for: (String).self)
        }
        
    }
    
    
     var cardId: String {
        get {
            return DefaultValueRegistry.defaultValue(for: (String).self)
        }
        
    }
    
    
     var description: String {
        get {
            return DefaultValueRegistry.defaultValue(for: (String).self)
        }
        
    }
    

    

    
     func execute(in state: GameStateProtocol) -> [GameUpdateProtocol]  {
        return DefaultValueRegistry.defaultValue(for: ([GameUpdateProtocol]).self)
    }
    
}


import Cuckoo
@testable import WildWest


 class MockCardProtocol: CardProtocol, Cuckoo.ProtocolMock {
    
     typealias MocksType = CardProtocol
    
     typealias Stubbing = __StubbingProxy_CardProtocol
     typealias Verification = __VerificationProxy_CardProtocol

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: CardProtocol?

     func enableDefaultImplementation(_ stub: CardProtocol) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    
    
    
     var identifier: String {
        get {
            return cuckoo_manager.getter("identifier",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.identifier)
        }
        
    }
    
    
    
     var name: CardName {
        get {
            return cuckoo_manager.getter("name",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.name)
        }
        
    }
    
    
    
     var value: String {
        get {
            return cuckoo_manager.getter("value",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.value)
        }
        
    }
    
    
    
     var suit: CardSuit {
        get {
            return cuckoo_manager.getter("suit",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.suit)
        }
        
    }
    
    
    
     var imageName: String {
        get {
            return cuckoo_manager.getter("imageName",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.imageName)
        }
        
    }
    

    

    

	 struct __StubbingProxy_CardProtocol: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    var identifier: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockCardProtocol, String> {
	        return .init(manager: cuckoo_manager, name: "identifier")
	    }
	    
	    
	    var name: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockCardProtocol, CardName> {
	        return .init(manager: cuckoo_manager, name: "name")
	    }
	    
	    
	    var value: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockCardProtocol, String> {
	        return .init(manager: cuckoo_manager, name: "value")
	    }
	    
	    
	    var suit: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockCardProtocol, CardSuit> {
	        return .init(manager: cuckoo_manager, name: "suit")
	    }
	    
	    
	    var imageName: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockCardProtocol, String> {
	        return .init(manager: cuckoo_manager, name: "imageName")
	    }
	    
	    
	}

	 struct __VerificationProxy_CardProtocol: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	    
	    var identifier: Cuckoo.VerifyReadOnlyProperty<String> {
	        return .init(manager: cuckoo_manager, name: "identifier", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var name: Cuckoo.VerifyReadOnlyProperty<CardName> {
	        return .init(manager: cuckoo_manager, name: "name", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var value: Cuckoo.VerifyReadOnlyProperty<String> {
	        return .init(manager: cuckoo_manager, name: "value", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var suit: Cuckoo.VerifyReadOnlyProperty<CardSuit> {
	        return .init(manager: cuckoo_manager, name: "suit", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var imageName: Cuckoo.VerifyReadOnlyProperty<String> {
	        return .init(manager: cuckoo_manager, name: "imageName", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	
	    
	}
}

 class CardProtocolStub: CardProtocol {
    
    
     var identifier: String {
        get {
            return DefaultValueRegistry.defaultValue(for: (String).self)
        }
        
    }
    
    
     var name: CardName {
        get {
            return DefaultValueRegistry.defaultValue(for: (CardName).self)
        }
        
    }
    
    
     var value: String {
        get {
            return DefaultValueRegistry.defaultValue(for: (String).self)
        }
        
    }
    
    
     var suit: CardSuit {
        get {
            return DefaultValueRegistry.defaultValue(for: (CardSuit).self)
        }
        
    }
    
    
     var imageName: String {
        get {
            return DefaultValueRegistry.defaultValue(for: (String).self)
        }
        
    }
    

    

    
}


import Cuckoo
@testable import WildWest


 class MockFigureProtocol: FigureProtocol, Cuckoo.ProtocolMock {
    
     typealias MocksType = FigureProtocol
    
     typealias Stubbing = __StubbingProxy_FigureProtocol
     typealias Verification = __VerificationProxy_FigureProtocol

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: FigureProtocol?

     func enableDefaultImplementation(_ stub: FigureProtocol) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    
    
    
     var ability: Ability {
        get {
            return cuckoo_manager.getter("ability",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.ability)
        }
        
    }
    
    
    
     var bullets: Int {
        get {
            return cuckoo_manager.getter("bullets",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.bullets)
        }
        
    }
    
    
    
     var imageName: String {
        get {
            return cuckoo_manager.getter("imageName",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.imageName)
        }
        
    }
    

    

    

	 struct __StubbingProxy_FigureProtocol: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    var ability: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockFigureProtocol, Ability> {
	        return .init(manager: cuckoo_manager, name: "ability")
	    }
	    
	    
	    var bullets: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockFigureProtocol, Int> {
	        return .init(manager: cuckoo_manager, name: "bullets")
	    }
	    
	    
	    var imageName: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockFigureProtocol, String> {
	        return .init(manager: cuckoo_manager, name: "imageName")
	    }
	    
	    
	}

	 struct __VerificationProxy_FigureProtocol: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	    
	    var ability: Cuckoo.VerifyReadOnlyProperty<Ability> {
	        return .init(manager: cuckoo_manager, name: "ability", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var bullets: Cuckoo.VerifyReadOnlyProperty<Int> {
	        return .init(manager: cuckoo_manager, name: "bullets", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var imageName: Cuckoo.VerifyReadOnlyProperty<String> {
	        return .init(manager: cuckoo_manager, name: "imageName", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	
	    
	}
}

 class FigureProtocolStub: FigureProtocol {
    
    
     var ability: Ability {
        get {
            return DefaultValueRegistry.defaultValue(for: (Ability).self)
        }
        
    }
    
    
     var bullets: Int {
        get {
            return DefaultValueRegistry.defaultValue(for: (Int).self)
        }
        
    }
    
    
     var imageName: String {
        get {
            return DefaultValueRegistry.defaultValue(for: (String).self)
        }
        
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
    

    
    
    
     var players: [PlayerProtocol] {
        get {
            return cuckoo_manager.getter("players",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.players)
        }
        
    }
    
    
    
     var deck: [CardProtocol] {
        get {
            return cuckoo_manager.getter("deck",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.deck)
        }
        
    }
    
    
    
     var turn: String {
        get {
            return cuckoo_manager.getter("turn",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.turn)
        }
        
    }
    
    
    
     var challenge: Challenge? {
        get {
            return cuckoo_manager.getter("challenge",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.challenge)
        }
        
    }
    
    
    
     var bangsPlayed: Int {
        get {
            return cuckoo_manager.getter("bangsPlayed",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.bangsPlayed)
        }
        
    }
    
    
    
     var generalStoreCards: [CardProtocol] {
        get {
            return cuckoo_manager.getter("generalStoreCards",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.generalStoreCards)
        }
        
    }
    
    
    
     var outcome: GameOutcome? {
        get {
            return cuckoo_manager.getter("outcome",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.outcome)
        }
        
    }
    
    
    
     var actions: [ActionProtocol] {
        get {
            return cuckoo_manager.getter("actions",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.actions)
        }
        
    }
    
    
    
     var commands: [ActionProtocol] {
        get {
            return cuckoo_manager.getter("commands",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.commands)
        }
        
    }
    
    
    
     var eliminated: [PlayerProtocol] {
        get {
            return cuckoo_manager.getter("eliminated",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.eliminated)
        }
        
    }
    

    

    

	 struct __StubbingProxy_GameStateProtocol: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    var players: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockGameStateProtocol, [PlayerProtocol]> {
	        return .init(manager: cuckoo_manager, name: "players")
	    }
	    
	    
	    var deck: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockGameStateProtocol, [CardProtocol]> {
	        return .init(manager: cuckoo_manager, name: "deck")
	    }
	    
	    
	    var turn: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockGameStateProtocol, String> {
	        return .init(manager: cuckoo_manager, name: "turn")
	    }
	    
	    
	    var challenge: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockGameStateProtocol, Challenge?> {
	        return .init(manager: cuckoo_manager, name: "challenge")
	    }
	    
	    
	    var bangsPlayed: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockGameStateProtocol, Int> {
	        return .init(manager: cuckoo_manager, name: "bangsPlayed")
	    }
	    
	    
	    var generalStoreCards: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockGameStateProtocol, [CardProtocol]> {
	        return .init(manager: cuckoo_manager, name: "generalStoreCards")
	    }
	    
	    
	    var outcome: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockGameStateProtocol, GameOutcome?> {
	        return .init(manager: cuckoo_manager, name: "outcome")
	    }
	    
	    
	    var actions: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockGameStateProtocol, [ActionProtocol]> {
	        return .init(manager: cuckoo_manager, name: "actions")
	    }
	    
	    
	    var commands: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockGameStateProtocol, [ActionProtocol]> {
	        return .init(manager: cuckoo_manager, name: "commands")
	    }
	    
	    
	    var eliminated: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockGameStateProtocol, [PlayerProtocol]> {
	        return .init(manager: cuckoo_manager, name: "eliminated")
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
	
	    
	    
	    var players: Cuckoo.VerifyReadOnlyProperty<[PlayerProtocol]> {
	        return .init(manager: cuckoo_manager, name: "players", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var deck: Cuckoo.VerifyReadOnlyProperty<[CardProtocol]> {
	        return .init(manager: cuckoo_manager, name: "deck", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var turn: Cuckoo.VerifyReadOnlyProperty<String> {
	        return .init(manager: cuckoo_manager, name: "turn", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var challenge: Cuckoo.VerifyReadOnlyProperty<Challenge?> {
	        return .init(manager: cuckoo_manager, name: "challenge", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var bangsPlayed: Cuckoo.VerifyReadOnlyProperty<Int> {
	        return .init(manager: cuckoo_manager, name: "bangsPlayed", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var generalStoreCards: Cuckoo.VerifyReadOnlyProperty<[CardProtocol]> {
	        return .init(manager: cuckoo_manager, name: "generalStoreCards", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var outcome: Cuckoo.VerifyReadOnlyProperty<GameOutcome?> {
	        return .init(manager: cuckoo_manager, name: "outcome", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var actions: Cuckoo.VerifyReadOnlyProperty<[ActionProtocol]> {
	        return .init(manager: cuckoo_manager, name: "actions", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var commands: Cuckoo.VerifyReadOnlyProperty<[ActionProtocol]> {
	        return .init(manager: cuckoo_manager, name: "commands", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var eliminated: Cuckoo.VerifyReadOnlyProperty<[PlayerProtocol]> {
	        return .init(manager: cuckoo_manager, name: "eliminated", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	
	    
	}
}

 class GameStateProtocolStub: GameStateProtocol {
    
    
     var players: [PlayerProtocol] {
        get {
            return DefaultValueRegistry.defaultValue(for: ([PlayerProtocol]).self)
        }
        
    }
    
    
     var deck: [CardProtocol] {
        get {
            return DefaultValueRegistry.defaultValue(for: ([CardProtocol]).self)
        }
        
    }
    
    
     var turn: String {
        get {
            return DefaultValueRegistry.defaultValue(for: (String).self)
        }
        
    }
    
    
     var challenge: Challenge? {
        get {
            return DefaultValueRegistry.defaultValue(for: (Challenge?).self)
        }
        
    }
    
    
     var bangsPlayed: Int {
        get {
            return DefaultValueRegistry.defaultValue(for: (Int).self)
        }
        
    }
    
    
     var generalStoreCards: [CardProtocol] {
        get {
            return DefaultValueRegistry.defaultValue(for: ([CardProtocol]).self)
        }
        
    }
    
    
     var outcome: GameOutcome? {
        get {
            return DefaultValueRegistry.defaultValue(for: (GameOutcome?).self)
        }
        
    }
    
    
     var actions: [ActionProtocol] {
        get {
            return DefaultValueRegistry.defaultValue(for: ([ActionProtocol]).self)
        }
        
    }
    
    
     var commands: [ActionProtocol] {
        get {
            return DefaultValueRegistry.defaultValue(for: ([ActionProtocol]).self)
        }
        
    }
    
    
     var eliminated: [PlayerProtocol] {
        get {
            return DefaultValueRegistry.defaultValue(for: ([PlayerProtocol]).self)
        }
        
    }
    

    

    
}


import Cuckoo
@testable import WildWest


 class MockMutableGameStateProtocol: MutableGameStateProtocol, Cuckoo.ProtocolMock {
    
     typealias MocksType = MutableGameStateProtocol
    
     typealias Stubbing = __StubbingProxy_MutableGameStateProtocol
     typealias Verification = __VerificationProxy_MutableGameStateProtocol

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: MutableGameStateProtocol?

     func enableDefaultImplementation(_ stub: MutableGameStateProtocol) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
     func setTurn(_ turn: String)  {
        
    return cuckoo_manager.call("setTurn(_: String)",
            parameters: (turn),
            escapingParameters: (turn),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.setTurn(turn))
        
    }
    
    
    
     func setChallenge(_ challenge: Challenge?)  {
        
    return cuckoo_manager.call("setChallenge(_: Challenge?)",
            parameters: (challenge),
            escapingParameters: (challenge),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.setChallenge(challenge))
        
    }
    
    
    
     func setBangsPlayed(_ bangsPlayed: Int)  {
        
    return cuckoo_manager.call("setBangsPlayed(_: Int)",
            parameters: (bangsPlayed),
            escapingParameters: (bangsPlayed),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.setBangsPlayed(bangsPlayed))
        
    }
    
    
    
     func addCommand(_ command: ActionProtocol)  {
        
    return cuckoo_manager.call("addCommand(_: ActionProtocol)",
            parameters: (command),
            escapingParameters: (command),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.addCommand(command))
        
    }
    
    
    
     func setActions(_ actions: [ActionProtocol])  {
        
    return cuckoo_manager.call("setActions(_: [ActionProtocol])",
            parameters: (actions),
            escapingParameters: (actions),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.setActions(actions))
        
    }
    
    
    
     func deckRemoveFirst() -> CardProtocol {
        
    return cuckoo_manager.call("deckRemoveFirst() -> CardProtocol",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.deckRemoveFirst())
        
    }
    
    
    
     func addDiscard(_ card: CardProtocol)  {
        
    return cuckoo_manager.call("addDiscard(_: CardProtocol)",
            parameters: (card),
            escapingParameters: (card),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.addDiscard(card))
        
    }
    
    
    
     func playerAddHandCard(_ playerId: String, _ card: CardProtocol)  {
        
    return cuckoo_manager.call("playerAddHandCard(_: String, _: CardProtocol)",
            parameters: (playerId, card),
            escapingParameters: (playerId, card),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.playerAddHandCard(playerId, card))
        
    }
    
    
    
     func playerRemoveHandCard(_ playerId: String, _ cardId: String) -> CardProtocol? {
        
    return cuckoo_manager.call("playerRemoveHandCard(_: String, _: String) -> CardProtocol?",
            parameters: (playerId, cardId),
            escapingParameters: (playerId, cardId),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.playerRemoveHandCard(playerId, cardId))
        
    }
    
    
    
     func playerSetHealth(_ playerId: String, _ health: Int)  {
        
    return cuckoo_manager.call("playerSetHealth(_: String, _: Int)",
            parameters: (playerId, health),
            escapingParameters: (playerId, health),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.playerSetHealth(playerId, health))
        
    }
    

	 struct __StubbingProxy_MutableGameStateProtocol: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func setTurn<M1: Cuckoo.Matchable>(_ turn: M1) -> Cuckoo.ProtocolStubNoReturnFunction<(String)> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: turn) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockMutableGameStateProtocol.self, method: "setTurn(_: String)", parameterMatchers: matchers))
	    }
	    
	    func setChallenge<M1: Cuckoo.OptionalMatchable>(_ challenge: M1) -> Cuckoo.ProtocolStubNoReturnFunction<(Challenge?)> where M1.OptionalMatchedType == Challenge {
	        let matchers: [Cuckoo.ParameterMatcher<(Challenge?)>] = [wrap(matchable: challenge) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockMutableGameStateProtocol.self, method: "setChallenge(_: Challenge?)", parameterMatchers: matchers))
	    }
	    
	    func setBangsPlayed<M1: Cuckoo.Matchable>(_ bangsPlayed: M1) -> Cuckoo.ProtocolStubNoReturnFunction<(Int)> where M1.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(Int)>] = [wrap(matchable: bangsPlayed) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockMutableGameStateProtocol.self, method: "setBangsPlayed(_: Int)", parameterMatchers: matchers))
	    }
	    
	    func addCommand<M1: Cuckoo.Matchable>(_ command: M1) -> Cuckoo.ProtocolStubNoReturnFunction<(ActionProtocol)> where M1.MatchedType == ActionProtocol {
	        let matchers: [Cuckoo.ParameterMatcher<(ActionProtocol)>] = [wrap(matchable: command) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockMutableGameStateProtocol.self, method: "addCommand(_: ActionProtocol)", parameterMatchers: matchers))
	    }
	    
	    func setActions<M1: Cuckoo.Matchable>(_ actions: M1) -> Cuckoo.ProtocolStubNoReturnFunction<([ActionProtocol])> where M1.MatchedType == [ActionProtocol] {
	        let matchers: [Cuckoo.ParameterMatcher<([ActionProtocol])>] = [wrap(matchable: actions) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockMutableGameStateProtocol.self, method: "setActions(_: [ActionProtocol])", parameterMatchers: matchers))
	    }
	    
	    func deckRemoveFirst() -> Cuckoo.ProtocolStubFunction<(), CardProtocol> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockMutableGameStateProtocol.self, method: "deckRemoveFirst() -> CardProtocol", parameterMatchers: matchers))
	    }
	    
	    func addDiscard<M1: Cuckoo.Matchable>(_ card: M1) -> Cuckoo.ProtocolStubNoReturnFunction<(CardProtocol)> where M1.MatchedType == CardProtocol {
	        let matchers: [Cuckoo.ParameterMatcher<(CardProtocol)>] = [wrap(matchable: card) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockMutableGameStateProtocol.self, method: "addDiscard(_: CardProtocol)", parameterMatchers: matchers))
	    }
	    
	    func playerAddHandCard<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(_ playerId: M1, _ card: M2) -> Cuckoo.ProtocolStubNoReturnFunction<(String, CardProtocol)> where M1.MatchedType == String, M2.MatchedType == CardProtocol {
	        let matchers: [Cuckoo.ParameterMatcher<(String, CardProtocol)>] = [wrap(matchable: playerId) { $0.0 }, wrap(matchable: card) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockMutableGameStateProtocol.self, method: "playerAddHandCard(_: String, _: CardProtocol)", parameterMatchers: matchers))
	    }
	    
	    func playerRemoveHandCard<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(_ playerId: M1, _ cardId: M2) -> Cuckoo.ProtocolStubFunction<(String, String), CardProtocol?> where M1.MatchedType == String, M2.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String, String)>] = [wrap(matchable: playerId) { $0.0 }, wrap(matchable: cardId) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockMutableGameStateProtocol.self, method: "playerRemoveHandCard(_: String, _: String) -> CardProtocol?", parameterMatchers: matchers))
	    }
	    
	    func playerSetHealth<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(_ playerId: M1, _ health: M2) -> Cuckoo.ProtocolStubNoReturnFunction<(String, Int)> where M1.MatchedType == String, M2.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(String, Int)>] = [wrap(matchable: playerId) { $0.0 }, wrap(matchable: health) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockMutableGameStateProtocol.self, method: "playerSetHealth(_: String, _: Int)", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_MutableGameStateProtocol: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func setTurn<M1: Cuckoo.Matchable>(_ turn: M1) -> Cuckoo.__DoNotUse<(String), Void> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: turn) { $0 }]
	        return cuckoo_manager.verify("setTurn(_: String)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func setChallenge<M1: Cuckoo.OptionalMatchable>(_ challenge: M1) -> Cuckoo.__DoNotUse<(Challenge?), Void> where M1.OptionalMatchedType == Challenge {
	        let matchers: [Cuckoo.ParameterMatcher<(Challenge?)>] = [wrap(matchable: challenge) { $0 }]
	        return cuckoo_manager.verify("setChallenge(_: Challenge?)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func setBangsPlayed<M1: Cuckoo.Matchable>(_ bangsPlayed: M1) -> Cuckoo.__DoNotUse<(Int), Void> where M1.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(Int)>] = [wrap(matchable: bangsPlayed) { $0 }]
	        return cuckoo_manager.verify("setBangsPlayed(_: Int)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func addCommand<M1: Cuckoo.Matchable>(_ command: M1) -> Cuckoo.__DoNotUse<(ActionProtocol), Void> where M1.MatchedType == ActionProtocol {
	        let matchers: [Cuckoo.ParameterMatcher<(ActionProtocol)>] = [wrap(matchable: command) { $0 }]
	        return cuckoo_manager.verify("addCommand(_: ActionProtocol)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func setActions<M1: Cuckoo.Matchable>(_ actions: M1) -> Cuckoo.__DoNotUse<([ActionProtocol]), Void> where M1.MatchedType == [ActionProtocol] {
	        let matchers: [Cuckoo.ParameterMatcher<([ActionProtocol])>] = [wrap(matchable: actions) { $0 }]
	        return cuckoo_manager.verify("setActions(_: [ActionProtocol])", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func deckRemoveFirst() -> Cuckoo.__DoNotUse<(), CardProtocol> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("deckRemoveFirst() -> CardProtocol", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func addDiscard<M1: Cuckoo.Matchable>(_ card: M1) -> Cuckoo.__DoNotUse<(CardProtocol), Void> where M1.MatchedType == CardProtocol {
	        let matchers: [Cuckoo.ParameterMatcher<(CardProtocol)>] = [wrap(matchable: card) { $0 }]
	        return cuckoo_manager.verify("addDiscard(_: CardProtocol)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func playerAddHandCard<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(_ playerId: M1, _ card: M2) -> Cuckoo.__DoNotUse<(String, CardProtocol), Void> where M1.MatchedType == String, M2.MatchedType == CardProtocol {
	        let matchers: [Cuckoo.ParameterMatcher<(String, CardProtocol)>] = [wrap(matchable: playerId) { $0.0 }, wrap(matchable: card) { $0.1 }]
	        return cuckoo_manager.verify("playerAddHandCard(_: String, _: CardProtocol)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func playerRemoveHandCard<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(_ playerId: M1, _ cardId: M2) -> Cuckoo.__DoNotUse<(String, String), CardProtocol?> where M1.MatchedType == String, M2.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String, String)>] = [wrap(matchable: playerId) { $0.0 }, wrap(matchable: cardId) { $0.1 }]
	        return cuckoo_manager.verify("playerRemoveHandCard(_: String, _: String) -> CardProtocol?", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func playerSetHealth<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(_ playerId: M1, _ health: M2) -> Cuckoo.__DoNotUse<(String, Int), Void> where M1.MatchedType == String, M2.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(String, Int)>] = [wrap(matchable: playerId) { $0.0 }, wrap(matchable: health) { $0.1 }]
	        return cuckoo_manager.verify("playerSetHealth(_: String, _: Int)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class MutableGameStateProtocolStub: MutableGameStateProtocol {
    

    

    
     func setTurn(_ turn: String)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func setChallenge(_ challenge: Challenge?)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func setBangsPlayed(_ bangsPlayed: Int)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func addCommand(_ command: ActionProtocol)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func setActions(_ actions: [ActionProtocol])   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func deckRemoveFirst() -> CardProtocol  {
        return DefaultValueRegistry.defaultValue(for: (CardProtocol).self)
    }
    
     func addDiscard(_ card: CardProtocol)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func playerAddHandCard(_ playerId: String, _ card: CardProtocol)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func playerRemoveHandCard(_ playerId: String, _ cardId: String) -> CardProtocol?  {
        return DefaultValueRegistry.defaultValue(for: (CardProtocol?).self)
    }
    
     func playerSetHealth(_ playerId: String, _ health: Int)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
}


import Cuckoo
@testable import WildWest


 class MockPlayerProtocol: PlayerProtocol, Cuckoo.ProtocolMock {
    
     typealias MocksType = PlayerProtocol
    
     typealias Stubbing = __StubbingProxy_PlayerProtocol
     typealias Verification = __VerificationProxy_PlayerProtocol

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: PlayerProtocol?

     func enableDefaultImplementation(_ stub: PlayerProtocol) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    
    
    
     var identifier: String {
        get {
            return cuckoo_manager.getter("identifier",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.identifier)
        }
        
    }
    
    
    
     var role: Role {
        get {
            return cuckoo_manager.getter("role",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.role)
        }
        
    }
    
    
    
     var ability: Ability {
        get {
            return cuckoo_manager.getter("ability",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.ability)
        }
        
    }
    
    
    
     var maxHealth: Int {
        get {
            return cuckoo_manager.getter("maxHealth",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.maxHealth)
        }
        
    }
    
    
    
     var health: Int {
        get {
            return cuckoo_manager.getter("health",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.health)
        }
        
    }
    
    
    
     var hand: [CardProtocol] {
        get {
            return cuckoo_manager.getter("hand",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.hand)
        }
        
    }
    
    
    
     var inPlay: [CardProtocol] {
        get {
            return cuckoo_manager.getter("inPlay",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.inPlay)
        }
        
    }
    
    
    
     var imageName: String {
        get {
            return cuckoo_manager.getter("imageName",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.imageName)
        }
        
    }
    

    

    

	 struct __StubbingProxy_PlayerProtocol: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    var identifier: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockPlayerProtocol, String> {
	        return .init(manager: cuckoo_manager, name: "identifier")
	    }
	    
	    
	    var role: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockPlayerProtocol, Role> {
	        return .init(manager: cuckoo_manager, name: "role")
	    }
	    
	    
	    var ability: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockPlayerProtocol, Ability> {
	        return .init(manager: cuckoo_manager, name: "ability")
	    }
	    
	    
	    var maxHealth: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockPlayerProtocol, Int> {
	        return .init(manager: cuckoo_manager, name: "maxHealth")
	    }
	    
	    
	    var health: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockPlayerProtocol, Int> {
	        return .init(manager: cuckoo_manager, name: "health")
	    }
	    
	    
	    var hand: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockPlayerProtocol, [CardProtocol]> {
	        return .init(manager: cuckoo_manager, name: "hand")
	    }
	    
	    
	    var inPlay: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockPlayerProtocol, [CardProtocol]> {
	        return .init(manager: cuckoo_manager, name: "inPlay")
	    }
	    
	    
	    var imageName: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockPlayerProtocol, String> {
	        return .init(manager: cuckoo_manager, name: "imageName")
	    }
	    
	    
	}

	 struct __VerificationProxy_PlayerProtocol: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	    
	    var identifier: Cuckoo.VerifyReadOnlyProperty<String> {
	        return .init(manager: cuckoo_manager, name: "identifier", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var role: Cuckoo.VerifyReadOnlyProperty<Role> {
	        return .init(manager: cuckoo_manager, name: "role", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var ability: Cuckoo.VerifyReadOnlyProperty<Ability> {
	        return .init(manager: cuckoo_manager, name: "ability", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var maxHealth: Cuckoo.VerifyReadOnlyProperty<Int> {
	        return .init(manager: cuckoo_manager, name: "maxHealth", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var health: Cuckoo.VerifyReadOnlyProperty<Int> {
	        return .init(manager: cuckoo_manager, name: "health", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var hand: Cuckoo.VerifyReadOnlyProperty<[CardProtocol]> {
	        return .init(manager: cuckoo_manager, name: "hand", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var inPlay: Cuckoo.VerifyReadOnlyProperty<[CardProtocol]> {
	        return .init(manager: cuckoo_manager, name: "inPlay", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var imageName: Cuckoo.VerifyReadOnlyProperty<String> {
	        return .init(manager: cuckoo_manager, name: "imageName", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	
	    
	}
}

 class PlayerProtocolStub: PlayerProtocol {
    
    
     var identifier: String {
        get {
            return DefaultValueRegistry.defaultValue(for: (String).self)
        }
        
    }
    
    
     var role: Role {
        get {
            return DefaultValueRegistry.defaultValue(for: (Role).self)
        }
        
    }
    
    
     var ability: Ability {
        get {
            return DefaultValueRegistry.defaultValue(for: (Ability).self)
        }
        
    }
    
    
     var maxHealth: Int {
        get {
            return DefaultValueRegistry.defaultValue(for: (Int).self)
        }
        
    }
    
    
     var health: Int {
        get {
            return DefaultValueRegistry.defaultValue(for: (Int).self)
        }
        
    }
    
    
     var hand: [CardProtocol] {
        get {
            return DefaultValueRegistry.defaultValue(for: ([CardProtocol]).self)
        }
        
    }
    
    
     var inPlay: [CardProtocol] {
        get {
            return DefaultValueRegistry.defaultValue(for: ([CardProtocol]).self)
        }
        
    }
    
    
     var imageName: String {
        get {
            return DefaultValueRegistry.defaultValue(for: (String).self)
        }
        
    }
    

    

    
}

