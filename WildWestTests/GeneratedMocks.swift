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
    

    

    

    
    
    
     func run(state: GameStateProtocol)  {
        
    return cuckoo_manager.call("run(state: GameStateProtocol)",
            parameters: (state),
            escapingParameters: (state),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.run(state: state))
        
    }
    
    
    
     func possibleActions(_ game: GameStateProtocol) -> [GameActionProtocol] {
        
    return cuckoo_manager.call("possibleActions(_: GameStateProtocol) -> [GameActionProtocol]",
            parameters: (game),
            escapingParameters: (game),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.possibleActions(game))
        
    }
    

	 struct __StubbingProxy_GameEngineProtocol: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func run<M1: Cuckoo.Matchable>(state: M1) -> Cuckoo.ProtocolStubNoReturnFunction<(GameStateProtocol)> where M1.MatchedType == GameStateProtocol {
	        let matchers: [Cuckoo.ParameterMatcher<(GameStateProtocol)>] = [wrap(matchable: state) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockGameEngineProtocol.self, method: "run(state: GameStateProtocol)", parameterMatchers: matchers))
	    }
	    
	    func possibleActions<M1: Cuckoo.Matchable>(_ game: M1) -> Cuckoo.ProtocolStubFunction<(GameStateProtocol), [GameActionProtocol]> where M1.MatchedType == GameStateProtocol {
	        let matchers: [Cuckoo.ParameterMatcher<(GameStateProtocol)>] = [wrap(matchable: game) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockGameEngineProtocol.self, method: "possibleActions(_: GameStateProtocol) -> [GameActionProtocol]", parameterMatchers: matchers))
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
	    func run<M1: Cuckoo.Matchable>(state: M1) -> Cuckoo.__DoNotUse<(GameStateProtocol), Void> where M1.MatchedType == GameStateProtocol {
	        let matchers: [Cuckoo.ParameterMatcher<(GameStateProtocol)>] = [wrap(matchable: state) { $0 }]
	        return cuckoo_manager.verify("run(state: GameStateProtocol)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func possibleActions<M1: Cuckoo.Matchable>(_ game: M1) -> Cuckoo.__DoNotUse<(GameStateProtocol), [GameActionProtocol]> where M1.MatchedType == GameStateProtocol {
	        let matchers: [Cuckoo.ParameterMatcher<(GameStateProtocol)>] = [wrap(matchable: game) { $0 }]
	        return cuckoo_manager.verify("possibleActions(_: GameStateProtocol) -> [GameActionProtocol]", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class GameEngineProtocolStub: GameEngineProtocol {
    

    

    
     func run(state: GameStateProtocol)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func possibleActions(_ game: GameStateProtocol) -> [GameActionProtocol]  {
        return DefaultValueRegistry.defaultValue(for: ([GameActionProtocol]).self)
    }
    
}


import Cuckoo
@testable import WildWest


 class MockGameActionProtocol: GameActionProtocol, Cuckoo.ProtocolMock {
    
     typealias MocksType = GameActionProtocol
    
     typealias Stubbing = __StubbingProxy_GameActionProtocol
     typealias Verification = __VerificationProxy_GameActionProtocol

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: GameActionProtocol?

     func enableDefaultImplementation(_ stub: GameActionProtocol) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
     func execute() -> [GameUpdateProtocol] {
        
    return cuckoo_manager.call("execute() -> [GameUpdateProtocol]",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.execute())
        
    }
    

	 struct __StubbingProxy_GameActionProtocol: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func execute() -> Cuckoo.ProtocolStubFunction<(), [GameUpdateProtocol]> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockGameActionProtocol.self, method: "execute() -> [GameUpdateProtocol]", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_GameActionProtocol: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func execute() -> Cuckoo.__DoNotUse<(), [GameUpdateProtocol]> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("execute() -> [GameUpdateProtocol]", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class GameActionProtocolStub: GameActionProtocol {
    

    

    
     func execute() -> [GameUpdateProtocol]  {
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
    
    
    
     var type: CardType {
        get {
            return cuckoo_manager.getter("type",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.type)
        }
        
    }
    
    
    
     var suits: CardSuit {
        get {
            return cuckoo_manager.getter("suits",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.suits)
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
	    
	    
	    var type: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockCardProtocol, CardType> {
	        return .init(manager: cuckoo_manager, name: "type")
	    }
	    
	    
	    var suits: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockCardProtocol, CardSuit> {
	        return .init(manager: cuckoo_manager, name: "suits")
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
	    
	    
	    var type: Cuckoo.VerifyReadOnlyProperty<CardType> {
	        return .init(manager: cuckoo_manager, name: "type", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var suits: Cuckoo.VerifyReadOnlyProperty<CardSuit> {
	        return .init(manager: cuckoo_manager, name: "suits", callMatcher: callMatcher, sourceLocation: sourceLocation)
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
    
    
     var type: CardType {
        get {
            return DefaultValueRegistry.defaultValue(for: (CardType).self)
        }
        
    }
    
    
     var suits: CardSuit {
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
    

    

    
    
    
     func addCard(_ card: CardProtocol)  {
        
    return cuckoo_manager.call("addCard(_: CardProtocol)",
            parameters: (card),
            escapingParameters: (card),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.addCard(card))
        
    }
    
    
    
     func removeCard(_ identifier: CardProtocol)  {
        
    return cuckoo_manager.call("removeCard(_: CardProtocol)",
            parameters: (identifier),
            escapingParameters: (identifier),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.removeCard(identifier))
        
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
    

	 struct __StubbingProxy_CardListProtocol: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    var cards: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockCardListProtocol, [CardProtocol]> {
	        return .init(manager: cuckoo_manager, name: "cards")
	    }
	    
	    
	    func addCard<M1: Cuckoo.Matchable>(_ card: M1) -> Cuckoo.ProtocolStubNoReturnFunction<(CardProtocol)> where M1.MatchedType == CardProtocol {
	        let matchers: [Cuckoo.ParameterMatcher<(CardProtocol)>] = [wrap(matchable: card) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockCardListProtocol.self, method: "addCard(_: CardProtocol)", parameterMatchers: matchers))
	    }
	    
	    func removeCard<M1: Cuckoo.Matchable>(_ identifier: M1) -> Cuckoo.ProtocolStubNoReturnFunction<(CardProtocol)> where M1.MatchedType == CardProtocol {
	        let matchers: [Cuckoo.ParameterMatcher<(CardProtocol)>] = [wrap(matchable: identifier) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockCardListProtocol.self, method: "removeCard(_: CardProtocol)", parameterMatchers: matchers))
	    }
	    
	    func pull() -> Cuckoo.ProtocolStubFunction<(), CardProtocol> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockCardListProtocol.self, method: "pull() -> CardProtocol", parameterMatchers: matchers))
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
	    func addCard<M1: Cuckoo.Matchable>(_ card: M1) -> Cuckoo.__DoNotUse<(CardProtocol), Void> where M1.MatchedType == CardProtocol {
	        let matchers: [Cuckoo.ParameterMatcher<(CardProtocol)>] = [wrap(matchable: card) { $0 }]
	        return cuckoo_manager.verify("addCard(_: CardProtocol)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func removeCard<M1: Cuckoo.Matchable>(_ identifier: M1) -> Cuckoo.__DoNotUse<(CardProtocol), Void> where M1.MatchedType == CardProtocol {
	        let matchers: [Cuckoo.ParameterMatcher<(CardProtocol)>] = [wrap(matchable: identifier) { $0 }]
	        return cuckoo_manager.verify("removeCard(_: CardProtocol)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func pull() -> Cuckoo.__DoNotUse<(), CardProtocol> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("pull() -> CardProtocol", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class CardListProtocolStub: CardListProtocol {
    
    
     var cards: [CardProtocol] {
        get {
            return DefaultValueRegistry.defaultValue(for: ([CardProtocol]).self)
        }
        
    }
    

    

    
     func addCard(_ card: CardProtocol)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func removeCard(_ identifier: CardProtocol)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func pull() -> CardProtocol  {
        return DefaultValueRegistry.defaultValue(for: (CardProtocol).self)
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
    

    

    
    
    
     func endTurn()  {
        
    return cuckoo_manager.call("endTurn()",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.endTurn())
        
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
	    
	    
	    func endTurn() -> Cuckoo.ProtocolStubNoReturnFunction<()> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockGameStateProtocol.self, method: "endTurn()", parameterMatchers: matchers))
	    }
	    
	    func addMessage<M1: Cuckoo.Matchable>(_ message: M1) -> Cuckoo.ProtocolStubNoReturnFunction<(String)> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: message) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockGameStateProtocol.self, method: "addMessage(_: String)", parameterMatchers: matchers))
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
	    
	
	    
	    @discardableResult
	    func endTurn() -> Cuckoo.__DoNotUse<(), Void> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("endTurn()", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func addMessage<M1: Cuckoo.Matchable>(_ message: M1) -> Cuckoo.__DoNotUse<(String), Void> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: message) { $0 }]
	        return cuckoo_manager.verify("addMessage(_: String)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
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
    

    

    
     func endTurn()   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func addMessage(_ message: String)   {
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
    

    

    
    
    
     func setHealth(_ health: Int)  {
        
    return cuckoo_manager.call("setHealth(_: Int)",
            parameters: (health),
            escapingParameters: (health),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.setHealth(health))
        
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
	    
	    
	    func setHealth<M1: Cuckoo.Matchable>(_ health: M1) -> Cuckoo.ProtocolStubNoReturnFunction<(Int)> where M1.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(Int)>] = [wrap(matchable: health) { $0 }]
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
	    func setHealth<M1: Cuckoo.Matchable>(_ health: M1) -> Cuckoo.__DoNotUse<(Int), Void> where M1.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(Int)>] = [wrap(matchable: health) { $0 }]
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
    

    

    
     func setHealth(_ health: Int)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
}


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
    

    

    

    
    
    
     func apply(to game: GameStateProtocol)  {
        
    return cuckoo_manager.call("apply(to: GameStateProtocol)",
            parameters: (game),
            escapingParameters: (game),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.apply(to: game))
        
    }
    

	 struct __StubbingProxy_GameUpdateProtocol: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func apply<M1: Cuckoo.Matchable>(to game: M1) -> Cuckoo.ProtocolStubNoReturnFunction<(GameStateProtocol)> where M1.MatchedType == GameStateProtocol {
	        let matchers: [Cuckoo.ParameterMatcher<(GameStateProtocol)>] = [wrap(matchable: game) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockGameUpdateProtocol.self, method: "apply(to: GameStateProtocol)", parameterMatchers: matchers))
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
	    func apply<M1: Cuckoo.Matchable>(to game: M1) -> Cuckoo.__DoNotUse<(GameStateProtocol), Void> where M1.MatchedType == GameStateProtocol {
	        let matchers: [Cuckoo.ParameterMatcher<(GameStateProtocol)>] = [wrap(matchable: game) { $0 }]
	        return cuckoo_manager.verify("apply(to: GameStateProtocol)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class GameUpdateProtocolStub: GameUpdateProtocol {
    

    

    
     func apply(to game: GameStateProtocol)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
}

