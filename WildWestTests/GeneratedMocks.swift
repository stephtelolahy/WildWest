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
    

    

    
    
    
     func execute(state: MutableGameStateProtocol)  {
        
    return cuckoo_manager.call("execute(state: MutableGameStateProtocol)",
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
	    
	    
	    func execute<M1: Cuckoo.Matchable>(state: M1) -> Cuckoo.ProtocolStubNoReturnFunction<(MutableGameStateProtocol)> where M1.MatchedType == MutableGameStateProtocol {
	        let matchers: [Cuckoo.ParameterMatcher<(MutableGameStateProtocol)>] = [wrap(matchable: state) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockActionProtocol.self, method: "execute(state: MutableGameStateProtocol)", parameterMatchers: matchers))
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
	    
	
	    
	    @discardableResult
	    func execute<M1: Cuckoo.Matchable>(state: M1) -> Cuckoo.__DoNotUse<(MutableGameStateProtocol), Void> where M1.MatchedType == MutableGameStateProtocol {
	        let matchers: [Cuckoo.ParameterMatcher<(MutableGameStateProtocol)>] = [wrap(matchable: state) { $0 }]
	        return cuckoo_manager.verify("execute(state: MutableGameStateProtocol)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class ActionProtocolStub: ActionProtocol {
    
    
     var actorId: String {
        get {
            return DefaultValueRegistry.defaultValue(for: (String).self)
        }
        
    }
    

    

    
     func execute(state: MutableGameStateProtocol)   {
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
    
    
    
     func removeFirst() -> CardProtocol {
        
    return cuckoo_manager.call("removeFirst() -> CardProtocol",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.removeFirst())
        
    }
    
    
    
     func remove(_ card: CardProtocol)  {
        
    return cuckoo_manager.call("remove(_: CardProtocol)",
            parameters: (card),
            escapingParameters: (card),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.remove(card))
        
    }
    
    
    
     func removeAll()  {
        
    return cuckoo_manager.call("removeAll()",
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
	    
	    func removeFirst() -> Cuckoo.ProtocolStubFunction<(), CardProtocol> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockCardListProtocol.self, method: "removeFirst() -> CardProtocol", parameterMatchers: matchers))
	    }
	    
	    func remove<M1: Cuckoo.Matchable>(_ card: M1) -> Cuckoo.ProtocolStubNoReturnFunction<(CardProtocol)> where M1.MatchedType == CardProtocol {
	        let matchers: [Cuckoo.ParameterMatcher<(CardProtocol)>] = [wrap(matchable: card) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockCardListProtocol.self, method: "remove(_: CardProtocol)", parameterMatchers: matchers))
	    }
	    
	    func removeAll() -> Cuckoo.ProtocolStubNoReturnFunction<()> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockCardListProtocol.self, method: "removeAll()", parameterMatchers: matchers))
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
	    func removeFirst() -> Cuckoo.__DoNotUse<(), CardProtocol> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("removeFirst() -> CardProtocol", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func remove<M1: Cuckoo.Matchable>(_ card: M1) -> Cuckoo.__DoNotUse<(CardProtocol), Void> where M1.MatchedType == CardProtocol {
	        let matchers: [Cuckoo.ParameterMatcher<(CardProtocol)>] = [wrap(matchable: card) { $0 }]
	        return cuckoo_manager.verify("remove(_: CardProtocol)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func removeAll() -> Cuckoo.__DoNotUse<(), Void> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("removeAll()", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
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
    
     func removeFirst() -> CardProtocol  {
        return DefaultValueRegistry.defaultValue(for: (CardProtocol).self)
    }
    
     func remove(_ card: CardProtocol)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func removeAll()   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
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
    
    
    
     var suit: CardSuit {
        get {
            return cuckoo_manager.getter("suit",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.suit)
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
	    
	    
	    var suit: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockCardProtocol, CardSuit> {
	        return .init(manager: cuckoo_manager, name: "suit")
	    }
	    
	    
	    var value: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockCardProtocol, String> {
	        return .init(manager: cuckoo_manager, name: "value")
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
	    
	    
	    var suit: Cuckoo.VerifyReadOnlyProperty<CardSuit> {
	        return .init(manager: cuckoo_manager, name: "suit", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var value: Cuckoo.VerifyReadOnlyProperty<String> {
	        return .init(manager: cuckoo_manager, name: "value", callMatcher: callMatcher, sourceLocation: sourceLocation)
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
    
    
     var suit: CardSuit {
        get {
            return DefaultValueRegistry.defaultValue(for: (CardSuit).self)
        }
        
    }
    
    
     var value: String {
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
    
    
    
     var outcome: GameOutcome? {
        get {
            return cuckoo_manager.getter("outcome",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.outcome)
        }
        
    }
    
    
    
     var messages: [String] {
        get {
            return cuckoo_manager.getter("messages",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.messages)
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
	    
	    
	    var outcome: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockGameStateProtocol, GameOutcome?> {
	        return .init(manager: cuckoo_manager, name: "outcome")
	    }
	    
	    
	    var messages: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockGameStateProtocol, [String]> {
	        return .init(manager: cuckoo_manager, name: "messages")
	    }
	    
	    
	    var turn: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockGameStateProtocol, Int> {
	        return .init(manager: cuckoo_manager, name: "turn")
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
	    
	    
	    var outcome: Cuckoo.VerifyReadOnlyProperty<GameOutcome?> {
	        return .init(manager: cuckoo_manager, name: "outcome", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var messages: Cuckoo.VerifyReadOnlyProperty<[String]> {
	        return .init(manager: cuckoo_manager, name: "messages", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var turn: Cuckoo.VerifyReadOnlyProperty<Int> {
	        return .init(manager: cuckoo_manager, name: "turn", callMatcher: callMatcher, sourceLocation: sourceLocation)
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
    
    
     var outcome: GameOutcome? {
        get {
            return DefaultValueRegistry.defaultValue(for: (GameOutcome?).self)
        }
        
    }
    
    
     var messages: [String] {
        get {
            return DefaultValueRegistry.defaultValue(for: ([String]).self)
        }
        
    }
    
    
     var turn: Int {
        get {
            return DefaultValueRegistry.defaultValue(for: (Int).self)
        }
        
    }
    

    

    
}



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
    

    

    

    
    
    
     func addMessage(_ message: String)  {
        
    return cuckoo_manager.call("addMessage(_: String)",
            parameters: (message),
            escapingParameters: (message),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.addMessage(message))
        
    }
    
    
    
     func discard(playerId: String, cardId: String)  {
        
    return cuckoo_manager.call("discard(playerId: String, cardId: String)",
            parameters: (playerId, cardId),
            escapingParameters: (playerId, cardId),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.discard(playerId: playerId, cardId: cardId))
        
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
    
    
    
     func pull(playerId: String)  {
        
    return cuckoo_manager.call("pull(playerId: String)",
            parameters: (playerId),
            escapingParameters: (playerId),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.pull(playerId: playerId))
        
    }
    
    
    
     func equip(playerId: String, cardId: String)  {
        
    return cuckoo_manager.call("equip(playerId: String, cardId: String)",
            parameters: (playerId, cardId),
            escapingParameters: (playerId, cardId),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.equip(playerId: playerId, cardId: cardId))
        
    }
    

	 struct __StubbingProxy_GameUpdateProtocol: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func addMessage<M1: Cuckoo.Matchable>(_ message: M1) -> Cuckoo.ProtocolStubNoReturnFunction<(String)> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: message) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockGameUpdateProtocol.self, method: "addMessage(_: String)", parameterMatchers: matchers))
	    }
	    
	    func discard<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(playerId: M1, cardId: M2) -> Cuckoo.ProtocolStubNoReturnFunction<(String, String)> where M1.MatchedType == String, M2.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String, String)>] = [wrap(matchable: playerId) { $0.0 }, wrap(matchable: cardId) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockGameUpdateProtocol.self, method: "discard(playerId: String, cardId: String)", parameterMatchers: matchers))
	    }
	    
	    func gainLifePoint<M1: Cuckoo.Matchable>(playerId: M1) -> Cuckoo.ProtocolStubNoReturnFunction<(String)> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: playerId) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockGameUpdateProtocol.self, method: "gainLifePoint(playerId: String)", parameterMatchers: matchers))
	    }
	    
	    func pull<M1: Cuckoo.Matchable>(playerId: M1) -> Cuckoo.ProtocolStubNoReturnFunction<(String)> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: playerId) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockGameUpdateProtocol.self, method: "pull(playerId: String)", parameterMatchers: matchers))
	    }
	    
	    func equip<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(playerId: M1, cardId: M2) -> Cuckoo.ProtocolStubNoReturnFunction<(String, String)> where M1.MatchedType == String, M2.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String, String)>] = [wrap(matchable: playerId) { $0.0 }, wrap(matchable: cardId) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockGameUpdateProtocol.self, method: "equip(playerId: String, cardId: String)", parameterMatchers: matchers))
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
	    func addMessage<M1: Cuckoo.Matchable>(_ message: M1) -> Cuckoo.__DoNotUse<(String), Void> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: message) { $0 }]
	        return cuckoo_manager.verify("addMessage(_: String)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func discard<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(playerId: M1, cardId: M2) -> Cuckoo.__DoNotUse<(String, String), Void> where M1.MatchedType == String, M2.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String, String)>] = [wrap(matchable: playerId) { $0.0 }, wrap(matchable: cardId) { $0.1 }]
	        return cuckoo_manager.verify("discard(playerId: String, cardId: String)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func gainLifePoint<M1: Cuckoo.Matchable>(playerId: M1) -> Cuckoo.__DoNotUse<(String), Void> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: playerId) { $0 }]
	        return cuckoo_manager.verify("gainLifePoint(playerId: String)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func pull<M1: Cuckoo.Matchable>(playerId: M1) -> Cuckoo.__DoNotUse<(String), Void> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: playerId) { $0 }]
	        return cuckoo_manager.verify("pull(playerId: String)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func equip<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(playerId: M1, cardId: M2) -> Cuckoo.__DoNotUse<(String, String), Void> where M1.MatchedType == String, M2.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String, String)>] = [wrap(matchable: playerId) { $0.0 }, wrap(matchable: cardId) { $0.1 }]
	        return cuckoo_manager.verify("equip(playerId: String, cardId: String)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class GameUpdateProtocolStub: GameUpdateProtocol {
    

    

    
     func addMessage(_ message: String)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func discard(playerId: String, cardId: String)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func gainLifePoint(playerId: String)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func pull(playerId: String)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func equip(playerId: String, cardId: String)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
}



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
    
    
    
     var outcome: GameOutcome? {
        get {
            return cuckoo_manager.getter("outcome",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.outcome)
        }
        
    }
    
    
    
     var messages: [String] {
        get {
            return cuckoo_manager.getter("messages",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.messages)
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
    

    

    
    
    
     func addMessage(_ message: String)  {
        
    return cuckoo_manager.call("addMessage(_: String)",
            parameters: (message),
            escapingParameters: (message),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.addMessage(message))
        
    }
    
    
    
     func discard(playerId: String, cardId: String)  {
        
    return cuckoo_manager.call("discard(playerId: String, cardId: String)",
            parameters: (playerId, cardId),
            escapingParameters: (playerId, cardId),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.discard(playerId: playerId, cardId: cardId))
        
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
    
    
    
     func pull(playerId: String)  {
        
    return cuckoo_manager.call("pull(playerId: String)",
            parameters: (playerId),
            escapingParameters: (playerId),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.pull(playerId: playerId))
        
    }
    
    
    
     func equip(playerId: String, cardId: String)  {
        
    return cuckoo_manager.call("equip(playerId: String, cardId: String)",
            parameters: (playerId, cardId),
            escapingParameters: (playerId, cardId),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.equip(playerId: playerId, cardId: cardId))
        
    }
    

	 struct __StubbingProxy_MutableGameStateProtocol: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    var players: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockMutableGameStateProtocol, [PlayerProtocol]> {
	        return .init(manager: cuckoo_manager, name: "players")
	    }
	    
	    
	    var deck: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockMutableGameStateProtocol, CardListProtocol> {
	        return .init(manager: cuckoo_manager, name: "deck")
	    }
	    
	    
	    var discard: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockMutableGameStateProtocol, CardListProtocol> {
	        return .init(manager: cuckoo_manager, name: "discard")
	    }
	    
	    
	    var outcome: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockMutableGameStateProtocol, GameOutcome?> {
	        return .init(manager: cuckoo_manager, name: "outcome")
	    }
	    
	    
	    var messages: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockMutableGameStateProtocol, [String]> {
	        return .init(manager: cuckoo_manager, name: "messages")
	    }
	    
	    
	    var turn: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockMutableGameStateProtocol, Int> {
	        return .init(manager: cuckoo_manager, name: "turn")
	    }
	    
	    
	    func addMessage<M1: Cuckoo.Matchable>(_ message: M1) -> Cuckoo.ProtocolStubNoReturnFunction<(String)> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: message) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockMutableGameStateProtocol.self, method: "addMessage(_: String)", parameterMatchers: matchers))
	    }
	    
	    func discard<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(playerId: M1, cardId: M2) -> Cuckoo.ProtocolStubNoReturnFunction<(String, String)> where M1.MatchedType == String, M2.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String, String)>] = [wrap(matchable: playerId) { $0.0 }, wrap(matchable: cardId) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockMutableGameStateProtocol.self, method: "discard(playerId: String, cardId: String)", parameterMatchers: matchers))
	    }
	    
	    func gainLifePoint<M1: Cuckoo.Matchable>(playerId: M1) -> Cuckoo.ProtocolStubNoReturnFunction<(String)> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: playerId) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockMutableGameStateProtocol.self, method: "gainLifePoint(playerId: String)", parameterMatchers: matchers))
	    }
	    
	    func pull<M1: Cuckoo.Matchable>(playerId: M1) -> Cuckoo.ProtocolStubNoReturnFunction<(String)> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: playerId) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockMutableGameStateProtocol.self, method: "pull(playerId: String)", parameterMatchers: matchers))
	    }
	    
	    func equip<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(playerId: M1, cardId: M2) -> Cuckoo.ProtocolStubNoReturnFunction<(String, String)> where M1.MatchedType == String, M2.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String, String)>] = [wrap(matchable: playerId) { $0.0 }, wrap(matchable: cardId) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockMutableGameStateProtocol.self, method: "equip(playerId: String, cardId: String)", parameterMatchers: matchers))
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
	
	    
	    
	    var players: Cuckoo.VerifyReadOnlyProperty<[PlayerProtocol]> {
	        return .init(manager: cuckoo_manager, name: "players", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var deck: Cuckoo.VerifyReadOnlyProperty<CardListProtocol> {
	        return .init(manager: cuckoo_manager, name: "deck", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var discard: Cuckoo.VerifyReadOnlyProperty<CardListProtocol> {
	        return .init(manager: cuckoo_manager, name: "discard", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var outcome: Cuckoo.VerifyReadOnlyProperty<GameOutcome?> {
	        return .init(manager: cuckoo_manager, name: "outcome", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var messages: Cuckoo.VerifyReadOnlyProperty<[String]> {
	        return .init(manager: cuckoo_manager, name: "messages", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var turn: Cuckoo.VerifyReadOnlyProperty<Int> {
	        return .init(manager: cuckoo_manager, name: "turn", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	
	    
	    @discardableResult
	    func addMessage<M1: Cuckoo.Matchable>(_ message: M1) -> Cuckoo.__DoNotUse<(String), Void> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: message) { $0 }]
	        return cuckoo_manager.verify("addMessage(_: String)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func discard<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(playerId: M1, cardId: M2) -> Cuckoo.__DoNotUse<(String, String), Void> where M1.MatchedType == String, M2.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String, String)>] = [wrap(matchable: playerId) { $0.0 }, wrap(matchable: cardId) { $0.1 }]
	        return cuckoo_manager.verify("discard(playerId: String, cardId: String)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func gainLifePoint<M1: Cuckoo.Matchable>(playerId: M1) -> Cuckoo.__DoNotUse<(String), Void> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: playerId) { $0 }]
	        return cuckoo_manager.verify("gainLifePoint(playerId: String)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func pull<M1: Cuckoo.Matchable>(playerId: M1) -> Cuckoo.__DoNotUse<(String), Void> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: playerId) { $0 }]
	        return cuckoo_manager.verify("pull(playerId: String)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func equip<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(playerId: M1, cardId: M2) -> Cuckoo.__DoNotUse<(String, String), Void> where M1.MatchedType == String, M2.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String, String)>] = [wrap(matchable: playerId) { $0.0 }, wrap(matchable: cardId) { $0.1 }]
	        return cuckoo_manager.verify("equip(playerId: String, cardId: String)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class MutableGameStateProtocolStub: MutableGameStateProtocol {
    
    
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
    
    
     var outcome: GameOutcome? {
        get {
            return DefaultValueRegistry.defaultValue(for: (GameOutcome?).self)
        }
        
    }
    
    
     var messages: [String] {
        get {
            return DefaultValueRegistry.defaultValue(for: ([String]).self)
        }
        
    }
    
    
     var turn: Int {
        get {
            return DefaultValueRegistry.defaultValue(for: (Int).self)
        }
        
    }
    

    

    
     func addMessage(_ message: String)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func discard(playerId: String, cardId: String)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func gainLifePoint(playerId: String)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func pull(playerId: String)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func equip(playerId: String, cardId: String)   {
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
    

    

    
     func setHealth(_ value: Int)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
}

