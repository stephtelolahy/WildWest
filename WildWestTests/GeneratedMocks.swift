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
    

    

    

    
    
    
     func matchingActions(for state: GameStateProtocol) -> [ActionProtocol] {
        
    return cuckoo_manager.call("matchingActions(for: GameStateProtocol) -> [ActionProtocol]",
            parameters: (state),
            escapingParameters: (state),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.matchingActions(for: state))
        
    }
    

	 struct __StubbingProxy_GameRulesProtocol: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func matchingActions<M1: Cuckoo.Matchable>(for state: M1) -> Cuckoo.ProtocolStubFunction<(GameStateProtocol), [ActionProtocol]> where M1.MatchedType == GameStateProtocol {
	        let matchers: [Cuckoo.ParameterMatcher<(GameStateProtocol)>] = [wrap(matchable: state) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockGameRulesProtocol.self, method: "matchingActions(for: GameStateProtocol) -> [ActionProtocol]", parameterMatchers: matchers))
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
	    func matchingActions<M1: Cuckoo.Matchable>(for state: M1) -> Cuckoo.__DoNotUse<(GameStateProtocol), [ActionProtocol]> where M1.MatchedType == GameStateProtocol {
	        let matchers: [Cuckoo.ParameterMatcher<(GameStateProtocol)>] = [wrap(matchable: state) { $0 }]
	        return cuckoo_manager.verify("matchingActions(for: GameStateProtocol) -> [ActionProtocol]", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class GameRulesProtocolStub: GameRulesProtocol {
    

    

    
     func matchingActions(for state: GameStateProtocol) -> [ActionProtocol]  {
        return DefaultValueRegistry.defaultValue(for: ([ActionProtocol]).self)
    }
    
}


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
    

    

    
    
    
     func execute(state: GameStateProtocol)  {
        
    return cuckoo_manager.call("execute(state: GameStateProtocol)",
            parameters: (state),
            escapingParameters: (state),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.execute(state: state))
        
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
	    
	    
	    func execute<M1: Cuckoo.Matchable>(state: M1) -> Cuckoo.ProtocolStubNoReturnFunction<(GameStateProtocol)> where M1.MatchedType == GameStateProtocol {
	        let matchers: [Cuckoo.ParameterMatcher<(GameStateProtocol)>] = [wrap(matchable: state) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockActionProtocol.self, method: "execute(state: GameStateProtocol)", parameterMatchers: matchers))
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
	    func execute<M1: Cuckoo.Matchable>(state: M1) -> Cuckoo.__DoNotUse<(GameStateProtocol), Void> where M1.MatchedType == GameStateProtocol {
	        let matchers: [Cuckoo.ParameterMatcher<(GameStateProtocol)>] = [wrap(matchable: state) { $0 }]
	        return cuckoo_manager.verify("execute(state: GameStateProtocol)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
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
    

    

    
     func execute(state: GameStateProtocol)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
}


import Cuckoo
@testable import WildWest


 class MockCardListProtocol: CardListProtocol, Cuckoo.ProtocolMock {
    
     typealias MocksType = CardListProtocol
    
     typealias Stubbing = __StubbingProxy_CardListProtocol
     typealias Verification = __VerificationProxy_CardListProtocol

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: CardListProtocol?

     func enableDefaultImplementation(_ stub: CardListProtocol) {
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
    

    

    
    
    
     func add(_ card: CardProtocol)  {
        
    return cuckoo_manager.call("add(_: CardProtocol)",
            parameters: (card),
            escapingParameters: (card),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.add(card))
        
    }
    
    
    
     func addAll(_ cards: [CardProtocol])  {
        
    return cuckoo_manager.call("addAll(_: [CardProtocol])",
            parameters: (cards),
            escapingParameters: (cards),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.addAll(cards))
        
    }
    
    
    
     func removeFirst() -> CardProtocol? {
        
    return cuckoo_manager.call("removeFirst() -> CardProtocol?",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.removeFirst())
        
    }
    
    
    
     func removeById(_ identifier: String) -> CardProtocol? {
        
    return cuckoo_manager.call("removeById(_: String) -> CardProtocol?",
            parameters: (identifier),
            escapingParameters: (identifier),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.removeById(identifier))
        
    }
    
    
    
     func removeAll() -> [CardProtocol] {
        
    return cuckoo_manager.call("removeAll() -> [CardProtocol]",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.removeAll())
        
    }
    

	 struct __StubbingProxy_CardListProtocol: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    var cards: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockCardListProtocol, [CardProtocol]> {
	        return .init(manager: cuckoo_manager, name: "cards")
	    }
	    
	    
	    func add<M1: Cuckoo.Matchable>(_ card: M1) -> Cuckoo.ProtocolStubNoReturnFunction<(CardProtocol)> where M1.MatchedType == CardProtocol {
	        let matchers: [Cuckoo.ParameterMatcher<(CardProtocol)>] = [wrap(matchable: card) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockCardListProtocol.self, method: "add(_: CardProtocol)", parameterMatchers: matchers))
	    }
	    
	    func addAll<M1: Cuckoo.Matchable>(_ cards: M1) -> Cuckoo.ProtocolStubNoReturnFunction<([CardProtocol])> where M1.MatchedType == [CardProtocol] {
	        let matchers: [Cuckoo.ParameterMatcher<([CardProtocol])>] = [wrap(matchable: cards) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockCardListProtocol.self, method: "addAll(_: [CardProtocol])", parameterMatchers: matchers))
	    }
	    
	    func removeFirst() -> Cuckoo.ProtocolStubFunction<(), CardProtocol?> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockCardListProtocol.self, method: "removeFirst() -> CardProtocol?", parameterMatchers: matchers))
	    }
	    
	    func removeById<M1: Cuckoo.Matchable>(_ identifier: M1) -> Cuckoo.ProtocolStubFunction<(String), CardProtocol?> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: identifier) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockCardListProtocol.self, method: "removeById(_: String) -> CardProtocol?", parameterMatchers: matchers))
	    }
	    
	    func removeAll() -> Cuckoo.ProtocolStubFunction<(), [CardProtocol]> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockCardListProtocol.self, method: "removeAll() -> [CardProtocol]", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_CardListProtocol: Cuckoo.VerificationProxy {
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
	    
	
	    
	    @discardableResult
	    func add<M1: Cuckoo.Matchable>(_ card: M1) -> Cuckoo.__DoNotUse<(CardProtocol), Void> where M1.MatchedType == CardProtocol {
	        let matchers: [Cuckoo.ParameterMatcher<(CardProtocol)>] = [wrap(matchable: card) { $0 }]
	        return cuckoo_manager.verify("add(_: CardProtocol)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func addAll<M1: Cuckoo.Matchable>(_ cards: M1) -> Cuckoo.__DoNotUse<([CardProtocol]), Void> where M1.MatchedType == [CardProtocol] {
	        let matchers: [Cuckoo.ParameterMatcher<([CardProtocol])>] = [wrap(matchable: cards) { $0 }]
	        return cuckoo_manager.verify("addAll(_: [CardProtocol])", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func removeFirst() -> Cuckoo.__DoNotUse<(), CardProtocol?> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("removeFirst() -> CardProtocol?", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func removeById<M1: Cuckoo.Matchable>(_ identifier: M1) -> Cuckoo.__DoNotUse<(String), CardProtocol?> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: identifier) { $0 }]
	        return cuckoo_manager.verify("removeById(_: String) -> CardProtocol?", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func removeAll() -> Cuckoo.__DoNotUse<(), [CardProtocol]> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("removeAll() -> [CardProtocol]", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class CardListProtocolStub: CardListProtocol {
    
    
     var cards: [CardProtocol] {
        get {
            return DefaultValueRegistry.defaultValue(for: ([CardProtocol]).self)
        }
        
    }
    

    

    
     func add(_ card: CardProtocol)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func addAll(_ cards: [CardProtocol])   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func removeFirst() -> CardProtocol?  {
        return DefaultValueRegistry.defaultValue(for: (CardProtocol?).self)
    }
    
     func removeById(_ identifier: String) -> CardProtocol?  {
        return DefaultValueRegistry.defaultValue(for: (CardProtocol?).self)
    }
    
     func removeAll() -> [CardProtocol]  {
        return DefaultValueRegistry.defaultValue(for: ([CardProtocol]).self)
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
    
    
    
     var deck: CardListProtocol {
        get {
            return cuckoo_manager.getter("deck",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.deck)
        }
        
    }
    
    
    
     var discard: CardListProtocol {
        get {
            return cuckoo_manager.getter("discard",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.discard)
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
    
    
    
     var outcome: GameOutcome? {
        get {
            return cuckoo_manager.getter("outcome",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.outcome)
        }
        
    }
    
    
    
     var history: [ActionProtocol] {
        get {
            return cuckoo_manager.getter("history",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.history)
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
    
    
    
     var challenge: Challenge? {
        get {
            return cuckoo_manager.getter("challenge",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.challenge)
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
    
    
    
     func addHistory(_ action: ActionProtocol)  {
        
    return cuckoo_manager.call("addHistory(_: ActionProtocol)",
            parameters: (action),
            escapingParameters: (action),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.addHistory(action))
        
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
    
    
    
     func setChallenge(_ challenge: Challenge?)  {
        
    return cuckoo_manager.call("setChallenge(_: Challenge?)",
            parameters: (challenge),
            escapingParameters: (challenge),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.setChallenge(challenge))
        
    }
    

	 struct __StubbingProxy_GameStateProtocol: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    var players: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockGameStateProtocol, [PlayerProtocol]> {
	        return .init(manager: cuckoo_manager, name: "players")
	    }
	    
	    
	    var deck: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockGameStateProtocol, CardListProtocol> {
	        return .init(manager: cuckoo_manager, name: "deck")
	    }
	    
	    
	    var discard: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockGameStateProtocol, CardListProtocol> {
	        return .init(manager: cuckoo_manager, name: "discard")
	    }
	    
	    
	    var turn: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockGameStateProtocol, Int> {
	        return .init(manager: cuckoo_manager, name: "turn")
	    }
	    
	    
	    var outcome: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockGameStateProtocol, GameOutcome?> {
	        return .init(manager: cuckoo_manager, name: "outcome")
	    }
	    
	    
	    var history: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockGameStateProtocol, [ActionProtocol]> {
	        return .init(manager: cuckoo_manager, name: "history")
	    }
	    
	    
	    var actions: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockGameStateProtocol, [ActionProtocol]> {
	        return .init(manager: cuckoo_manager, name: "actions")
	    }
	    
	    
	    var challenge: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockGameStateProtocol, Challenge?> {
	        return .init(manager: cuckoo_manager, name: "challenge")
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
	    
	    func addHistory<M1: Cuckoo.Matchable>(_ action: M1) -> Cuckoo.ProtocolStubNoReturnFunction<(ActionProtocol)> where M1.MatchedType == ActionProtocol {
	        let matchers: [Cuckoo.ParameterMatcher<(ActionProtocol)>] = [wrap(matchable: action) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockGameStateProtocol.self, method: "addHistory(_: ActionProtocol)", parameterMatchers: matchers))
	    }
	    
	    func setActions<M1: Cuckoo.Matchable>(_ actions: M1) -> Cuckoo.ProtocolStubNoReturnFunction<([ActionProtocol])> where M1.MatchedType == [ActionProtocol] {
	        let matchers: [Cuckoo.ParameterMatcher<([ActionProtocol])>] = [wrap(matchable: actions) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockGameStateProtocol.self, method: "setActions(_: [ActionProtocol])", parameterMatchers: matchers))
	    }
	    
	    func setChallenge<M1: Cuckoo.OptionalMatchable>(_ challenge: M1) -> Cuckoo.ProtocolStubNoReturnFunction<(Challenge?)> where M1.OptionalMatchedType == Challenge {
	        let matchers: [Cuckoo.ParameterMatcher<(Challenge?)>] = [wrap(matchable: challenge) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockGameStateProtocol.self, method: "setChallenge(_: Challenge?)", parameterMatchers: matchers))
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
	    
	    
	    var deck: Cuckoo.VerifyReadOnlyProperty<CardListProtocol> {
	        return .init(manager: cuckoo_manager, name: "deck", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var discard: Cuckoo.VerifyReadOnlyProperty<CardListProtocol> {
	        return .init(manager: cuckoo_manager, name: "discard", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var turn: Cuckoo.VerifyReadOnlyProperty<Int> {
	        return .init(manager: cuckoo_manager, name: "turn", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var outcome: Cuckoo.VerifyReadOnlyProperty<GameOutcome?> {
	        return .init(manager: cuckoo_manager, name: "outcome", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var history: Cuckoo.VerifyReadOnlyProperty<[ActionProtocol]> {
	        return .init(manager: cuckoo_manager, name: "history", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var actions: Cuckoo.VerifyReadOnlyProperty<[ActionProtocol]> {
	        return .init(manager: cuckoo_manager, name: "actions", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var challenge: Cuckoo.VerifyReadOnlyProperty<Challenge?> {
	        return .init(manager: cuckoo_manager, name: "challenge", callMatcher: callMatcher, sourceLocation: sourceLocation)
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
	    func addHistory<M1: Cuckoo.Matchable>(_ action: M1) -> Cuckoo.__DoNotUse<(ActionProtocol), Void> where M1.MatchedType == ActionProtocol {
	        let matchers: [Cuckoo.ParameterMatcher<(ActionProtocol)>] = [wrap(matchable: action) { $0 }]
	        return cuckoo_manager.verify("addHistory(_: ActionProtocol)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func setActions<M1: Cuckoo.Matchable>(_ actions: M1) -> Cuckoo.__DoNotUse<([ActionProtocol]), Void> where M1.MatchedType == [ActionProtocol] {
	        let matchers: [Cuckoo.ParameterMatcher<([ActionProtocol])>] = [wrap(matchable: actions) { $0 }]
	        return cuckoo_manager.verify("setActions(_: [ActionProtocol])", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func setChallenge<M1: Cuckoo.OptionalMatchable>(_ challenge: M1) -> Cuckoo.__DoNotUse<(Challenge?), Void> where M1.OptionalMatchedType == Challenge {
	        let matchers: [Cuckoo.ParameterMatcher<(Challenge?)>] = [wrap(matchable: challenge) { $0 }]
	        return cuckoo_manager.verify("setChallenge(_: Challenge?)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class GameStateProtocolStub: GameStateProtocol {
    
    
     var players: [PlayerProtocol] {
        get {
            return DefaultValueRegistry.defaultValue(for: ([PlayerProtocol]).self)
        }
        
    }
    
    
     var deck: CardListProtocol {
        get {
            return DefaultValueRegistry.defaultValue(for: (CardListProtocol).self)
        }
        
    }
    
    
     var discard: CardListProtocol {
        get {
            return DefaultValueRegistry.defaultValue(for: (CardListProtocol).self)
        }
        
    }
    
    
     var turn: Int {
        get {
            return DefaultValueRegistry.defaultValue(for: (Int).self)
        }
        
    }
    
    
     var outcome: GameOutcome? {
        get {
            return DefaultValueRegistry.defaultValue(for: (GameOutcome?).self)
        }
        
    }
    
    
     var history: [ActionProtocol] {
        get {
            return DefaultValueRegistry.defaultValue(for: ([ActionProtocol]).self)
        }
        
    }
    
    
     var actions: [ActionProtocol] {
        get {
            return DefaultValueRegistry.defaultValue(for: ([ActionProtocol]).self)
        }
        
    }
    
    
     var challenge: Challenge? {
        get {
            return DefaultValueRegistry.defaultValue(for: (Challenge?).self)
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
    
     func addHistory(_ action: ActionProtocol)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func setActions(_ actions: [ActionProtocol])   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func setChallenge(_ challenge: Challenge?)   {
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
    
    
    
     var hand: CardListProtocol {
        get {
            return cuckoo_manager.getter("hand",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.hand)
        }
        
    }
    
    
    
     var inPlay: CardListProtocol {
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
    

    

    
    
    
     func setHealth(_ value: Int)  {
        
    return cuckoo_manager.call("setHealth(_: Int)",
            parameters: (value),
            escapingParameters: (value),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.setHealth(value))
        
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
	    
	    
	    var hand: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockPlayerProtocol, CardListProtocol> {
	        return .init(manager: cuckoo_manager, name: "hand")
	    }
	    
	    
	    var inPlay: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockPlayerProtocol, CardListProtocol> {
	        return .init(manager: cuckoo_manager, name: "inPlay")
	    }
	    
	    
	    var imageName: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockPlayerProtocol, String> {
	        return .init(manager: cuckoo_manager, name: "imageName")
	    }
	    
	    
	    func setHealth<M1: Cuckoo.Matchable>(_ value: M1) -> Cuckoo.ProtocolStubNoReturnFunction<(Int)> where M1.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(Int)>] = [wrap(matchable: value) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockPlayerProtocol.self, method: "setHealth(_: Int)", parameterMatchers: matchers))
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
	    
	    
	    var hand: Cuckoo.VerifyReadOnlyProperty<CardListProtocol> {
	        return .init(manager: cuckoo_manager, name: "hand", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var inPlay: Cuckoo.VerifyReadOnlyProperty<CardListProtocol> {
	        return .init(manager: cuckoo_manager, name: "inPlay", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var imageName: Cuckoo.VerifyReadOnlyProperty<String> {
	        return .init(manager: cuckoo_manager, name: "imageName", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	
	    
	    @discardableResult
	    func setHealth<M1: Cuckoo.Matchable>(_ value: M1) -> Cuckoo.__DoNotUse<(Int), Void> where M1.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(Int)>] = [wrap(matchable: value) { $0 }]
	        return cuckoo_manager.verify("setHealth(_: Int)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
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
    
    
     var hand: CardListProtocol {
        get {
            return DefaultValueRegistry.defaultValue(for: (CardListProtocol).self)
        }
        
    }
    
    
     var inPlay: CardListProtocol {
        get {
            return DefaultValueRegistry.defaultValue(for: (CardListProtocol).self)
        }
        
    }
    
    
     var imageName: String {
        get {
            return DefaultValueRegistry.defaultValue(for: (String).self)
        }
        
    }
    

    

    
     func setHealth(_ value: Int)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
}

