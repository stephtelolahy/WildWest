import Cuckoo
@testable import WildWest


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
    
    
    
     var description: String {
        get {
            return cuckoo_manager.getter("description",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.description)
        }
        
    }
    

    

    
    
    
     func execute(in state: GameStateProtocol)  {
        
    return cuckoo_manager.call("execute(in: GameStateProtocol)",
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
	    
	    
	    var description: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockActionProtocol, String> {
	        return .init(manager: cuckoo_manager, name: "description")
	    }
	    
	    
	    func execute<M1: Cuckoo.Matchable>(in state: M1) -> Cuckoo.ProtocolStubNoReturnFunction<(GameStateProtocol)> where M1.MatchedType == GameStateProtocol {
	        let matchers: [Cuckoo.ParameterMatcher<(GameStateProtocol)>] = [wrap(matchable: state) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockActionProtocol.self, method: "execute(in: GameStateProtocol)", parameterMatchers: matchers))
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
	    
	    
	    var description: Cuckoo.VerifyReadOnlyProperty<String> {
	        return .init(manager: cuckoo_manager, name: "description", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	
	    
	    @discardableResult
	    func execute<M1: Cuckoo.Matchable>(in state: M1) -> Cuckoo.__DoNotUse<(GameStateProtocol), Void> where M1.MatchedType == GameStateProtocol {
	        let matchers: [Cuckoo.ParameterMatcher<(GameStateProtocol)>] = [wrap(matchable: state) { $0 }]
	        return cuckoo_manager.verify("execute(in: GameStateProtocol)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class ActionProtocolStub: ActionProtocol {
    
    
     var actorId: String {
        get {
            return DefaultValueRegistry.defaultValue(for: (String).self)
        }
        
    }
    
    
     var description: String {
        get {
            return DefaultValueRegistry.defaultValue(for: (String).self)
        }
        
    }
    

    

    
     func execute(in state: GameStateProtocol)   {
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
    

	 struct __StubbingProxy_RangeCalculatorProtocol: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func distance<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable>(from playerId: M1, to otherId: M2, in state: M3) -> Cuckoo.ProtocolStubFunction<(String, String, GameStateProtocol), Int> where M1.MatchedType == String, M2.MatchedType == String, M3.MatchedType == GameStateProtocol {
	        let matchers: [Cuckoo.ParameterMatcher<(String, String, GameStateProtocol)>] = [wrap(matchable: playerId) { $0.0 }, wrap(matchable: otherId) { $0.1 }, wrap(matchable: state) { $0.2 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockRangeCalculatorProtocol.self, method: "distance(from: String, to: String, in: GameStateProtocol) -> Int", parameterMatchers: matchers))
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
	    
	}
}

 class RangeCalculatorProtocolStub: RangeCalculatorProtocol {
    

    

    
     func distance(from playerId: String, to otherId: String, in state: GameStateProtocol) -> Int  {
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
    

    
    
    
     var actionName: String {
        get {
            return cuckoo_manager.getter("actionName",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.actionName)
        }
        
    }
    

    

    
    
    
     func match(with state: GameStateProtocol) -> [ActionProtocol] {
        
    return cuckoo_manager.call("match(with: GameStateProtocol) -> [ActionProtocol]",
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
	    
	    
	    var actionName: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockRuleProtocol, String> {
	        return .init(manager: cuckoo_manager, name: "actionName")
	    }
	    
	    
	    func match<M1: Cuckoo.Matchable>(with state: M1) -> Cuckoo.ProtocolStubFunction<(GameStateProtocol), [ActionProtocol]> where M1.MatchedType == GameStateProtocol {
	        let matchers: [Cuckoo.ParameterMatcher<(GameStateProtocol)>] = [wrap(matchable: state) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockRuleProtocol.self, method: "match(with: GameStateProtocol) -> [ActionProtocol]", parameterMatchers: matchers))
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
	
	    
	    
	    var actionName: Cuckoo.VerifyReadOnlyProperty<String> {
	        return .init(manager: cuckoo_manager, name: "actionName", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	
	    
	    @discardableResult
	    func match<M1: Cuckoo.Matchable>(with state: M1) -> Cuckoo.__DoNotUse<(GameStateProtocol), [ActionProtocol]> where M1.MatchedType == GameStateProtocol {
	        let matchers: [Cuckoo.ParameterMatcher<(GameStateProtocol)>] = [wrap(matchable: state) { $0 }]
	        return cuckoo_manager.verify("match(with: GameStateProtocol) -> [ActionProtocol]", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class RuleProtocolStub: RuleProtocol {
    
    
     var actionName: String {
        get {
            return DefaultValueRegistry.defaultValue(for: (String).self)
        }
        
    }
    

    

    
     func match(with state: GameStateProtocol) -> [ActionProtocol]  {
        return DefaultValueRegistry.defaultValue(for: ([ActionProtocol]).self)
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


 class MockDeckProtocol: DeckProtocol, Cuckoo.ProtocolMock {
    
     typealias MocksType = DeckProtocol
    
     typealias Stubbing = __StubbingProxy_DeckProtocol
     typealias Verification = __VerificationProxy_DeckProtocol

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: DeckProtocol?

     func enableDefaultImplementation(_ stub: DeckProtocol) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    
    
    
     var cards: [CardProtocol] {
        get {
            return cuckoo_manager.getter("cards",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.cards)
        }
        
    }
    
    
    
     var discardPile: [CardProtocol] {
        get {
            return cuckoo_manager.getter("discardPile",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.discardPile)
        }
        
    }
    

    

    
    
    
     func pull() -> CardProtocol {
        
    return cuckoo_manager.call("pull() -> CardProtocol",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.pull())
        
    }
    
    
    
     func addToDiscard(_ card: CardProtocol)  {
        
    return cuckoo_manager.call("addToDiscard(_: CardProtocol)",
            parameters: (card),
            escapingParameters: (card),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.addToDiscard(card))
        
    }
    

	 struct __StubbingProxy_DeckProtocol: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    var cards: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockDeckProtocol, [CardProtocol]> {
	        return .init(manager: cuckoo_manager, name: "cards")
	    }
	    
	    
	    var discardPile: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockDeckProtocol, [CardProtocol]> {
	        return .init(manager: cuckoo_manager, name: "discardPile")
	    }
	    
	    
	    func pull() -> Cuckoo.ProtocolStubFunction<(), CardProtocol> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockDeckProtocol.self, method: "pull() -> CardProtocol", parameterMatchers: matchers))
	    }
	    
	    func addToDiscard<M1: Cuckoo.Matchable>(_ card: M1) -> Cuckoo.ProtocolStubNoReturnFunction<(CardProtocol)> where M1.MatchedType == CardProtocol {
	        let matchers: [Cuckoo.ParameterMatcher<(CardProtocol)>] = [wrap(matchable: card) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockDeckProtocol.self, method: "addToDiscard(_: CardProtocol)", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_DeckProtocol: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	    
	    var cards: Cuckoo.VerifyReadOnlyProperty<[CardProtocol]> {
	        return .init(manager: cuckoo_manager, name: "cards", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var discardPile: Cuckoo.VerifyReadOnlyProperty<[CardProtocol]> {
	        return .init(manager: cuckoo_manager, name: "discardPile", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	
	    
	    @discardableResult
	    func pull() -> Cuckoo.__DoNotUse<(), CardProtocol> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("pull() -> CardProtocol", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func addToDiscard<M1: Cuckoo.Matchable>(_ card: M1) -> Cuckoo.__DoNotUse<(CardProtocol), Void> where M1.MatchedType == CardProtocol {
	        let matchers: [Cuckoo.ParameterMatcher<(CardProtocol)>] = [wrap(matchable: card) { $0 }]
	        return cuckoo_manager.verify("addToDiscard(_: CardProtocol)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class DeckProtocolStub: DeckProtocol {
    
    
     var cards: [CardProtocol] {
        get {
            return DefaultValueRegistry.defaultValue(for: ([CardProtocol]).self)
        }
        
    }
    
    
     var discardPile: [CardProtocol] {
        get {
            return DefaultValueRegistry.defaultValue(for: ([CardProtocol]).self)
        }
        
    }
    

    

    
     func pull() -> CardProtocol  {
        return DefaultValueRegistry.defaultValue(for: (CardProtocol).self)
    }
    
     func addToDiscard(_ card: CardProtocol)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
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
    
    
    
     var deck: DeckProtocol {
        get {
            return cuckoo_manager.getter("deck",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.deck)
        }
        
    }
    
    
    
     var turn: Int {
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
    
    
    
     var outcome: GameOutcome? {
        get {
            return cuckoo_manager.getter("outcome",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.outcome)
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
    

    

    
    
    
     func discardHand(playerId: String, cardId: String)  {
        
    return cuckoo_manager.call("discardHand(playerId: String, cardId: String)",
            parameters: (playerId, cardId),
            escapingParameters: (playerId, cardId),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.discardHand(playerId: playerId, cardId: cardId))
        
    }
    
    
    
     func discardInPlay(playerId: String, cardId: String)  {
        
    return cuckoo_manager.call("discardInPlay(playerId: String, cardId: String)",
            parameters: (playerId, cardId),
            escapingParameters: (playerId, cardId),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.discardInPlay(playerId: playerId, cardId: cardId))
        
    }
    
    
    
     func gainLifePoint(playerId: String)  {
        
    return cuckoo_manager.call("gainLifePoint(playerId: String)",
            parameters: (playerId),
            escapingParameters: (playerId),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.gainLifePoint(playerId: playerId))
        
    }
    
    
    
     func pullFromDeck(playerId: String)  {
        
    return cuckoo_manager.call("pullFromDeck(playerId: String)",
            parameters: (playerId),
            escapingParameters: (playerId),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.pullFromDeck(playerId: playerId))
        
    }
    
    
    
     func putInPlay(playerId: String, cardId: String)  {
        
    return cuckoo_manager.call("putInPlay(playerId: String, cardId: String)",
            parameters: (playerId, cardId),
            escapingParameters: (playerId, cardId),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.putInPlay(playerId: playerId, cardId: cardId))
        
    }
    
    
    
     func addCommand(_ action: ActionProtocol)  {
        
    return cuckoo_manager.call("addCommand(_: ActionProtocol)",
            parameters: (action),
            escapingParameters: (action),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.addCommand(action))
        
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
    
    
    
     func setTurn(_ turn: Int)  {
        
    return cuckoo_manager.call("setTurn(_: Int)",
            parameters: (turn),
            escapingParameters: (turn),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.setTurn(turn))
        
    }
    
    
    
     func pullHand(playerId: String, otherId: String, cardId: String)  {
        
    return cuckoo_manager.call("pullHand(playerId: String, otherId: String, cardId: String)",
            parameters: (playerId, otherId, cardId),
            escapingParameters: (playerId, otherId, cardId),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.pullHand(playerId: playerId, otherId: otherId, cardId: cardId))
        
    }
    
    
    
     func pullInPlay(playerId: String, otherId: String, cardId: String)  {
        
    return cuckoo_manager.call("pullInPlay(playerId: String, otherId: String, cardId: String)",
            parameters: (playerId, otherId, cardId),
            escapingParameters: (playerId, otherId, cardId),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.pullInPlay(playerId: playerId, otherId: otherId, cardId: cardId))
        
    }
    

	 struct __StubbingProxy_GameStateProtocol: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    var players: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockGameStateProtocol, [PlayerProtocol]> {
	        return .init(manager: cuckoo_manager, name: "players")
	    }
	    
	    
	    var deck: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockGameStateProtocol, DeckProtocol> {
	        return .init(manager: cuckoo_manager, name: "deck")
	    }
	    
	    
	    var turn: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockGameStateProtocol, Int> {
	        return .init(manager: cuckoo_manager, name: "turn")
	    }
	    
	    
	    var challenge: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockGameStateProtocol, Challenge?> {
	        return .init(manager: cuckoo_manager, name: "challenge")
	    }
	    
	    
	    var outcome: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockGameStateProtocol, GameOutcome?> {
	        return .init(manager: cuckoo_manager, name: "outcome")
	    }
	    
	    
	    var commands: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockGameStateProtocol, [ActionProtocol]> {
	        return .init(manager: cuckoo_manager, name: "commands")
	    }
	    
	    
	    func discardHand<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(playerId: M1, cardId: M2) -> Cuckoo.ProtocolStubNoReturnFunction<(String, String)> where M1.MatchedType == String, M2.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String, String)>] = [wrap(matchable: playerId) { $0.0 }, wrap(matchable: cardId) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockGameStateProtocol.self, method: "discardHand(playerId: String, cardId: String)", parameterMatchers: matchers))
	    }
	    
	    func discardInPlay<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(playerId: M1, cardId: M2) -> Cuckoo.ProtocolStubNoReturnFunction<(String, String)> where M1.MatchedType == String, M2.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String, String)>] = [wrap(matchable: playerId) { $0.0 }, wrap(matchable: cardId) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockGameStateProtocol.self, method: "discardInPlay(playerId: String, cardId: String)", parameterMatchers: matchers))
	    }
	    
	    func gainLifePoint<M1: Cuckoo.Matchable>(playerId: M1) -> Cuckoo.ProtocolStubNoReturnFunction<(String)> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: playerId) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockGameStateProtocol.self, method: "gainLifePoint(playerId: String)", parameterMatchers: matchers))
	    }
	    
	    func pullFromDeck<M1: Cuckoo.Matchable>(playerId: M1) -> Cuckoo.ProtocolStubNoReturnFunction<(String)> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: playerId) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockGameStateProtocol.self, method: "pullFromDeck(playerId: String)", parameterMatchers: matchers))
	    }
	    
	    func putInPlay<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(playerId: M1, cardId: M2) -> Cuckoo.ProtocolStubNoReturnFunction<(String, String)> where M1.MatchedType == String, M2.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String, String)>] = [wrap(matchable: playerId) { $0.0 }, wrap(matchable: cardId) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockGameStateProtocol.self, method: "putInPlay(playerId: String, cardId: String)", parameterMatchers: matchers))
	    }
	    
	    func addCommand<M1: Cuckoo.Matchable>(_ action: M1) -> Cuckoo.ProtocolStubNoReturnFunction<(ActionProtocol)> where M1.MatchedType == ActionProtocol {
	        let matchers: [Cuckoo.ParameterMatcher<(ActionProtocol)>] = [wrap(matchable: action) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockGameStateProtocol.self, method: "addCommand(_: ActionProtocol)", parameterMatchers: matchers))
	    }
	    
	    func setChallenge<M1: Cuckoo.OptionalMatchable>(_ challenge: M1) -> Cuckoo.ProtocolStubNoReturnFunction<(Challenge?)> where M1.OptionalMatchedType == Challenge {
	        let matchers: [Cuckoo.ParameterMatcher<(Challenge?)>] = [wrap(matchable: challenge) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockGameStateProtocol.self, method: "setChallenge(_: Challenge?)", parameterMatchers: matchers))
	    }
	    
	    func setTurn<M1: Cuckoo.Matchable>(_ turn: M1) -> Cuckoo.ProtocolStubNoReturnFunction<(Int)> where M1.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(Int)>] = [wrap(matchable: turn) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockGameStateProtocol.self, method: "setTurn(_: Int)", parameterMatchers: matchers))
	    }
	    
	    func pullHand<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable>(playerId: M1, otherId: M2, cardId: M3) -> Cuckoo.ProtocolStubNoReturnFunction<(String, String, String)> where M1.MatchedType == String, M2.MatchedType == String, M3.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String, String, String)>] = [wrap(matchable: playerId) { $0.0 }, wrap(matchable: otherId) { $0.1 }, wrap(matchable: cardId) { $0.2 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockGameStateProtocol.self, method: "pullHand(playerId: String, otherId: String, cardId: String)", parameterMatchers: matchers))
	    }
	    
	    func pullInPlay<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable>(playerId: M1, otherId: M2, cardId: M3) -> Cuckoo.ProtocolStubNoReturnFunction<(String, String, String)> where M1.MatchedType == String, M2.MatchedType == String, M3.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String, String, String)>] = [wrap(matchable: playerId) { $0.0 }, wrap(matchable: otherId) { $0.1 }, wrap(matchable: cardId) { $0.2 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockGameStateProtocol.self, method: "pullInPlay(playerId: String, otherId: String, cardId: String)", parameterMatchers: matchers))
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
	    
	    
	    var deck: Cuckoo.VerifyReadOnlyProperty<DeckProtocol> {
	        return .init(manager: cuckoo_manager, name: "deck", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var turn: Cuckoo.VerifyReadOnlyProperty<Int> {
	        return .init(manager: cuckoo_manager, name: "turn", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var challenge: Cuckoo.VerifyReadOnlyProperty<Challenge?> {
	        return .init(manager: cuckoo_manager, name: "challenge", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var outcome: Cuckoo.VerifyReadOnlyProperty<GameOutcome?> {
	        return .init(manager: cuckoo_manager, name: "outcome", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var commands: Cuckoo.VerifyReadOnlyProperty<[ActionProtocol]> {
	        return .init(manager: cuckoo_manager, name: "commands", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	
	    
	    @discardableResult
	    func discardHand<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(playerId: M1, cardId: M2) -> Cuckoo.__DoNotUse<(String, String), Void> where M1.MatchedType == String, M2.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String, String)>] = [wrap(matchable: playerId) { $0.0 }, wrap(matchable: cardId) { $0.1 }]
	        return cuckoo_manager.verify("discardHand(playerId: String, cardId: String)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func discardInPlay<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(playerId: M1, cardId: M2) -> Cuckoo.__DoNotUse<(String, String), Void> where M1.MatchedType == String, M2.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String, String)>] = [wrap(matchable: playerId) { $0.0 }, wrap(matchable: cardId) { $0.1 }]
	        return cuckoo_manager.verify("discardInPlay(playerId: String, cardId: String)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func gainLifePoint<M1: Cuckoo.Matchable>(playerId: M1) -> Cuckoo.__DoNotUse<(String), Void> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: playerId) { $0 }]
	        return cuckoo_manager.verify("gainLifePoint(playerId: String)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func pullFromDeck<M1: Cuckoo.Matchable>(playerId: M1) -> Cuckoo.__DoNotUse<(String), Void> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: playerId) { $0 }]
	        return cuckoo_manager.verify("pullFromDeck(playerId: String)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func putInPlay<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(playerId: M1, cardId: M2) -> Cuckoo.__DoNotUse<(String, String), Void> where M1.MatchedType == String, M2.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String, String)>] = [wrap(matchable: playerId) { $0.0 }, wrap(matchable: cardId) { $0.1 }]
	        return cuckoo_manager.verify("putInPlay(playerId: String, cardId: String)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func addCommand<M1: Cuckoo.Matchable>(_ action: M1) -> Cuckoo.__DoNotUse<(ActionProtocol), Void> where M1.MatchedType == ActionProtocol {
	        let matchers: [Cuckoo.ParameterMatcher<(ActionProtocol)>] = [wrap(matchable: action) { $0 }]
	        return cuckoo_manager.verify("addCommand(_: ActionProtocol)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func setChallenge<M1: Cuckoo.OptionalMatchable>(_ challenge: M1) -> Cuckoo.__DoNotUse<(Challenge?), Void> where M1.OptionalMatchedType == Challenge {
	        let matchers: [Cuckoo.ParameterMatcher<(Challenge?)>] = [wrap(matchable: challenge) { $0 }]
	        return cuckoo_manager.verify("setChallenge(_: Challenge?)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func setTurn<M1: Cuckoo.Matchable>(_ turn: M1) -> Cuckoo.__DoNotUse<(Int), Void> where M1.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(Int)>] = [wrap(matchable: turn) { $0 }]
	        return cuckoo_manager.verify("setTurn(_: Int)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func pullHand<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable>(playerId: M1, otherId: M2, cardId: M3) -> Cuckoo.__DoNotUse<(String, String, String), Void> where M1.MatchedType == String, M2.MatchedType == String, M3.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String, String, String)>] = [wrap(matchable: playerId) { $0.0 }, wrap(matchable: otherId) { $0.1 }, wrap(matchable: cardId) { $0.2 }]
	        return cuckoo_manager.verify("pullHand(playerId: String, otherId: String, cardId: String)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func pullInPlay<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable>(playerId: M1, otherId: M2, cardId: M3) -> Cuckoo.__DoNotUse<(String, String, String), Void> where M1.MatchedType == String, M2.MatchedType == String, M3.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String, String, String)>] = [wrap(matchable: playerId) { $0.0 }, wrap(matchable: otherId) { $0.1 }, wrap(matchable: cardId) { $0.2 }]
	        return cuckoo_manager.verify("pullInPlay(playerId: String, otherId: String, cardId: String)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class GameStateProtocolStub: GameStateProtocol {
    
    
     var players: [PlayerProtocol] {
        get {
            return DefaultValueRegistry.defaultValue(for: ([PlayerProtocol]).self)
        }
        
    }
    
    
     var deck: DeckProtocol {
        get {
            return DefaultValueRegistry.defaultValue(for: (DeckProtocol).self)
        }
        
    }
    
    
     var turn: Int {
        get {
            return DefaultValueRegistry.defaultValue(for: (Int).self)
        }
        
    }
    
    
     var challenge: Challenge? {
        get {
            return DefaultValueRegistry.defaultValue(for: (Challenge?).self)
        }
        
    }
    
    
     var outcome: GameOutcome? {
        get {
            return DefaultValueRegistry.defaultValue(for: (GameOutcome?).self)
        }
        
    }
    
    
     var commands: [ActionProtocol] {
        get {
            return DefaultValueRegistry.defaultValue(for: ([ActionProtocol]).self)
        }
        
    }
    

    

    
     func discardHand(playerId: String, cardId: String)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func discardInPlay(playerId: String, cardId: String)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func gainLifePoint(playerId: String)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func pullFromDeck(playerId: String)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func putInPlay(playerId: String, cardId: String)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func addCommand(_ action: ActionProtocol)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func setChallenge(_ challenge: Challenge?)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func setTurn(_ turn: Int)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func pullHand(playerId: String, otherId: String, cardId: String)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func pullInPlay(playerId: String, otherId: String, cardId: String)   {
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
    
    
    
     var actions: [GenericAction] {
        get {
            return cuckoo_manager.getter("actions",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.actions)
        }
        
    }
    

    

    
    
    
     func setHealth(_ value: Int)  {
        
    return cuckoo_manager.call("setHealth(_: Int)",
            parameters: (value),
            escapingParameters: (value),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.setHealth(value))
        
    }
    
    
    
     func setActions(_ actions: [GenericAction])  {
        
    return cuckoo_manager.call("setActions(_: [GenericAction])",
            parameters: (actions),
            escapingParameters: (actions),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.setActions(actions))
        
    }
    
    
    
     func addHand(_ card: CardProtocol)  {
        
    return cuckoo_manager.call("addHand(_: CardProtocol)",
            parameters: (card),
            escapingParameters: (card),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.addHand(card))
        
    }
    
    
    
     func removeHandById(_ cardId: String) -> CardProtocol? {
        
    return cuckoo_manager.call("removeHandById(_: String) -> CardProtocol?",
            parameters: (cardId),
            escapingParameters: (cardId),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.removeHandById(cardId))
        
    }
    
    
    
     func addInPlay(_ card: CardProtocol)  {
        
    return cuckoo_manager.call("addInPlay(_: CardProtocol)",
            parameters: (card),
            escapingParameters: (card),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.addInPlay(card))
        
    }
    
    
    
     func removeInPlayById(_ cardId: String) -> CardProtocol? {
        
    return cuckoo_manager.call("removeInPlayById(_: String) -> CardProtocol?",
            parameters: (cardId),
            escapingParameters: (cardId),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.removeInPlayById(cardId))
        
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
	    
	    
	    var actions: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockPlayerProtocol, [GenericAction]> {
	        return .init(manager: cuckoo_manager, name: "actions")
	    }
	    
	    
	    func setHealth<M1: Cuckoo.Matchable>(_ value: M1) -> Cuckoo.ProtocolStubNoReturnFunction<(Int)> where M1.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(Int)>] = [wrap(matchable: value) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockPlayerProtocol.self, method: "setHealth(_: Int)", parameterMatchers: matchers))
	    }
	    
	    func setActions<M1: Cuckoo.Matchable>(_ actions: M1) -> Cuckoo.ProtocolStubNoReturnFunction<([GenericAction])> where M1.MatchedType == [GenericAction] {
	        let matchers: [Cuckoo.ParameterMatcher<([GenericAction])>] = [wrap(matchable: actions) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockPlayerProtocol.self, method: "setActions(_: [GenericAction])", parameterMatchers: matchers))
	    }
	    
	    func addHand<M1: Cuckoo.Matchable>(_ card: M1) -> Cuckoo.ProtocolStubNoReturnFunction<(CardProtocol)> where M1.MatchedType == CardProtocol {
	        let matchers: [Cuckoo.ParameterMatcher<(CardProtocol)>] = [wrap(matchable: card) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockPlayerProtocol.self, method: "addHand(_: CardProtocol)", parameterMatchers: matchers))
	    }
	    
	    func removeHandById<M1: Cuckoo.Matchable>(_ cardId: M1) -> Cuckoo.ProtocolStubFunction<(String), CardProtocol?> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: cardId) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockPlayerProtocol.self, method: "removeHandById(_: String) -> CardProtocol?", parameterMatchers: matchers))
	    }
	    
	    func addInPlay<M1: Cuckoo.Matchable>(_ card: M1) -> Cuckoo.ProtocolStubNoReturnFunction<(CardProtocol)> where M1.MatchedType == CardProtocol {
	        let matchers: [Cuckoo.ParameterMatcher<(CardProtocol)>] = [wrap(matchable: card) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockPlayerProtocol.self, method: "addInPlay(_: CardProtocol)", parameterMatchers: matchers))
	    }
	    
	    func removeInPlayById<M1: Cuckoo.Matchable>(_ cardId: M1) -> Cuckoo.ProtocolStubFunction<(String), CardProtocol?> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: cardId) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockPlayerProtocol.self, method: "removeInPlayById(_: String) -> CardProtocol?", parameterMatchers: matchers))
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
	    
	    
	    var actions: Cuckoo.VerifyReadOnlyProperty<[GenericAction]> {
	        return .init(manager: cuckoo_manager, name: "actions", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	
	    
	    @discardableResult
	    func setHealth<M1: Cuckoo.Matchable>(_ value: M1) -> Cuckoo.__DoNotUse<(Int), Void> where M1.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(Int)>] = [wrap(matchable: value) { $0 }]
	        return cuckoo_manager.verify("setHealth(_: Int)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func setActions<M1: Cuckoo.Matchable>(_ actions: M1) -> Cuckoo.__DoNotUse<([GenericAction]), Void> where M1.MatchedType == [GenericAction] {
	        let matchers: [Cuckoo.ParameterMatcher<([GenericAction])>] = [wrap(matchable: actions) { $0 }]
	        return cuckoo_manager.verify("setActions(_: [GenericAction])", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func addHand<M1: Cuckoo.Matchable>(_ card: M1) -> Cuckoo.__DoNotUse<(CardProtocol), Void> where M1.MatchedType == CardProtocol {
	        let matchers: [Cuckoo.ParameterMatcher<(CardProtocol)>] = [wrap(matchable: card) { $0 }]
	        return cuckoo_manager.verify("addHand(_: CardProtocol)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func removeHandById<M1: Cuckoo.Matchable>(_ cardId: M1) -> Cuckoo.__DoNotUse<(String), CardProtocol?> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: cardId) { $0 }]
	        return cuckoo_manager.verify("removeHandById(_: String) -> CardProtocol?", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func addInPlay<M1: Cuckoo.Matchable>(_ card: M1) -> Cuckoo.__DoNotUse<(CardProtocol), Void> where M1.MatchedType == CardProtocol {
	        let matchers: [Cuckoo.ParameterMatcher<(CardProtocol)>] = [wrap(matchable: card) { $0 }]
	        return cuckoo_manager.verify("addInPlay(_: CardProtocol)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func removeInPlayById<M1: Cuckoo.Matchable>(_ cardId: M1) -> Cuckoo.__DoNotUse<(String), CardProtocol?> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: cardId) { $0 }]
	        return cuckoo_manager.verify("removeInPlayById(_: String) -> CardProtocol?", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
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
    
    
     var actions: [GenericAction] {
        get {
            return DefaultValueRegistry.defaultValue(for: ([GenericAction]).self)
        }
        
    }
    

    

    
     func setHealth(_ value: Int)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func setActions(_ actions: [GenericAction])   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func addHand(_ card: CardProtocol)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func removeHandById(_ cardId: String) -> CardProtocol?  {
        return DefaultValueRegistry.defaultValue(for: (CardProtocol?).self)
    }
    
     func addInPlay(_ card: CardProtocol)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func removeInPlayById(_ cardId: String) -> CardProtocol?  {
        return DefaultValueRegistry.defaultValue(for: (CardProtocol?).self)
    }
    
}

