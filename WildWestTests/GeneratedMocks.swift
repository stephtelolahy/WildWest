import Cuckoo
@testable import WildWest


 class MockKeyGeneratorProtocol: KeyGeneratorProtocol, Cuckoo.ProtocolMock {
    
     typealias MocksType = KeyGeneratorProtocol
    
     typealias Stubbing = __StubbingProxy_KeyGeneratorProtocol
     typealias Verification = __VerificationProxy_KeyGeneratorProtocol

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: KeyGeneratorProtocol?

     func enableDefaultImplementation(_ stub: KeyGeneratorProtocol) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
     func autoId() -> String {
        
    return cuckoo_manager.call("autoId() -> String",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.autoId())
        
    }
    

	 struct __StubbingProxy_KeyGeneratorProtocol: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func autoId() -> Cuckoo.ProtocolStubFunction<(), String> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockKeyGeneratorProtocol.self, method: "autoId() -> String", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_KeyGeneratorProtocol: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func autoId() -> Cuckoo.__DoNotUse<(), String> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("autoId() -> String", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class KeyGeneratorProtocolStub: KeyGeneratorProtocol {
    

    

    
     func autoId() -> String  {
        return DefaultValueRegistry.defaultValue(for: (String).self)
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
    

    

    

    
    
    
     func start()  {
        
    return cuckoo_manager.call("start()",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.start())
        
    }
    
    
    
     func execute(_ move: GameMove)  {
        
    return cuckoo_manager.call("execute(_: GameMove)",
            parameters: (move),
            escapingParameters: (move),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.execute(move))
        
    }
    

	 struct __StubbingProxy_GameEngineProtocol: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func start() -> Cuckoo.ProtocolStubNoReturnFunction<()> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockGameEngineProtocol.self, method: "start()", parameterMatchers: matchers))
	    }
	    
	    func execute<M1: Cuckoo.Matchable>(_ move: M1) -> Cuckoo.ProtocolStubNoReturnFunction<(GameMove)> where M1.MatchedType == GameMove {
	        let matchers: [Cuckoo.ParameterMatcher<(GameMove)>] = [wrap(matchable: move) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockGameEngineProtocol.self, method: "execute(_: GameMove)", parameterMatchers: matchers))
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
	    func start() -> Cuckoo.__DoNotUse<(), Void> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("start()", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func execute<M1: Cuckoo.Matchable>(_ move: M1) -> Cuckoo.__DoNotUse<(GameMove), Void> where M1.MatchedType == GameMove {
	        let matchers: [Cuckoo.ParameterMatcher<(GameMove)>] = [wrap(matchable: move) { $0 }]
	        return cuckoo_manager.verify("execute(_: GameMove)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class GameEngineProtocolStub: GameEngineProtocol {
    

    

    
     func start()   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func execute(_ move: GameMove)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
}


import Cuckoo
@testable import WildWest

import RxSwift

import Cuckoo
@testable import WildWest

import RxSwift


 class MockGameSubjectsProtocol: GameSubjectsProtocol, Cuckoo.ProtocolMock {
    
     typealias MocksType = GameSubjectsProtocol
    
     typealias Stubbing = __StubbingProxy_GameSubjectsProtocol
     typealias Verification = __VerificationProxy_GameSubjectsProtocol

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: GameSubjectsProtocol?

     func enableDefaultImplementation(_ stub: GameSubjectsProtocol) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    
    
    
     var sheriffId: String {
        get {
            return cuckoo_manager.getter("sheriffId",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.sheriffId)
        }
        
    }
    

    

    
    
    
     func playerIds(observedBy playerId: String?) -> [String] {
        
    return cuckoo_manager.call("playerIds(observedBy: String?) -> [String]",
            parameters: (playerId),
            escapingParameters: (playerId),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.playerIds(observedBy: playerId))
        
    }
    
    
    
     func state(observedBy playerId: String?) -> Observable<GameStateProtocol> {
        
    return cuckoo_manager.call("state(observedBy: String?) -> Observable<GameStateProtocol>",
            parameters: (playerId),
            escapingParameters: (playerId),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.state(observedBy: playerId))
        
    }
    
    
    
     func executedMove() -> Observable<GameMove> {
        
    return cuckoo_manager.call("executedMove() -> Observable<GameMove>",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.executedMove())
        
    }
    
    
    
     func executedUpdate() -> Observable<GameUpdate> {
        
    return cuckoo_manager.call("executedUpdate() -> Observable<GameUpdate>",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.executedUpdate())
        
    }
    
    
    
     func validMoves(for playerId: String) -> Observable<[GameMove]> {
        
    return cuckoo_manager.call("validMoves(for: String) -> Observable<[GameMove]>",
            parameters: (playerId),
            escapingParameters: (playerId),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.validMoves(for: playerId))
        
    }
    

	 struct __StubbingProxy_GameSubjectsProtocol: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    var sheriffId: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockGameSubjectsProtocol, String> {
	        return .init(manager: cuckoo_manager, name: "sheriffId")
	    }
	    
	    
	    func playerIds<M1: Cuckoo.OptionalMatchable>(observedBy playerId: M1) -> Cuckoo.ProtocolStubFunction<(String?), [String]> where M1.OptionalMatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String?)>] = [wrap(matchable: playerId) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockGameSubjectsProtocol.self, method: "playerIds(observedBy: String?) -> [String]", parameterMatchers: matchers))
	    }
	    
	    func state<M1: Cuckoo.OptionalMatchable>(observedBy playerId: M1) -> Cuckoo.ProtocolStubFunction<(String?), Observable<GameStateProtocol>> where M1.OptionalMatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String?)>] = [wrap(matchable: playerId) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockGameSubjectsProtocol.self, method: "state(observedBy: String?) -> Observable<GameStateProtocol>", parameterMatchers: matchers))
	    }
	    
	    func executedMove() -> Cuckoo.ProtocolStubFunction<(), Observable<GameMove>> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockGameSubjectsProtocol.self, method: "executedMove() -> Observable<GameMove>", parameterMatchers: matchers))
	    }
	    
	    func executedUpdate() -> Cuckoo.ProtocolStubFunction<(), Observable<GameUpdate>> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockGameSubjectsProtocol.self, method: "executedUpdate() -> Observable<GameUpdate>", parameterMatchers: matchers))
	    }
	    
	    func validMoves<M1: Cuckoo.Matchable>(for playerId: M1) -> Cuckoo.ProtocolStubFunction<(String), Observable<[GameMove]>> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: playerId) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockGameSubjectsProtocol.self, method: "validMoves(for: String) -> Observable<[GameMove]>", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_GameSubjectsProtocol: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	    
	    var sheriffId: Cuckoo.VerifyReadOnlyProperty<String> {
	        return .init(manager: cuckoo_manager, name: "sheriffId", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	
	    
	    @discardableResult
	    func playerIds<M1: Cuckoo.OptionalMatchable>(observedBy playerId: M1) -> Cuckoo.__DoNotUse<(String?), [String]> where M1.OptionalMatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String?)>] = [wrap(matchable: playerId) { $0 }]
	        return cuckoo_manager.verify("playerIds(observedBy: String?) -> [String]", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func state<M1: Cuckoo.OptionalMatchable>(observedBy playerId: M1) -> Cuckoo.__DoNotUse<(String?), Observable<GameStateProtocol>> where M1.OptionalMatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String?)>] = [wrap(matchable: playerId) { $0 }]
	        return cuckoo_manager.verify("state(observedBy: String?) -> Observable<GameStateProtocol>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func executedMove() -> Cuckoo.__DoNotUse<(), Observable<GameMove>> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("executedMove() -> Observable<GameMove>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func executedUpdate() -> Cuckoo.__DoNotUse<(), Observable<GameUpdate>> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("executedUpdate() -> Observable<GameUpdate>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func validMoves<M1: Cuckoo.Matchable>(for playerId: M1) -> Cuckoo.__DoNotUse<(String), Observable<[GameMove]>> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: playerId) { $0 }]
	        return cuckoo_manager.verify("validMoves(for: String) -> Observable<[GameMove]>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class GameSubjectsProtocolStub: GameSubjectsProtocol {
    
    
     var sheriffId: String {
        get {
            return DefaultValueRegistry.defaultValue(for: (String).self)
        }
        
    }
    

    

    
     func playerIds(observedBy playerId: String?) -> [String]  {
        return DefaultValueRegistry.defaultValue(for: ([String]).self)
    }
    
     func state(observedBy playerId: String?) -> Observable<GameStateProtocol>  {
        return DefaultValueRegistry.defaultValue(for: (Observable<GameStateProtocol>).self)
    }
    
     func executedMove() -> Observable<GameMove>  {
        return DefaultValueRegistry.defaultValue(for: (Observable<GameMove>).self)
    }
    
     func executedUpdate() -> Observable<GameUpdate>  {
        return DefaultValueRegistry.defaultValue(for: (Observable<GameUpdate>).self)
    }
    
     func validMoves(for playerId: String) -> Observable<[GameMove]>  {
        return DefaultValueRegistry.defaultValue(for: (Observable<[GameMove]>).self)
    }
    
}


import Cuckoo
@testable import WildWest

import RxSwift


 class MockGameDatabaseProtocol: GameDatabaseProtocol, Cuckoo.ProtocolMock {
    
     typealias MocksType = GameDatabaseProtocol
    
     typealias Stubbing = __StubbingProxy_GameDatabaseProtocol
     typealias Verification = __VerificationProxy_GameDatabaseProtocol

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: GameDatabaseProtocol?

     func enableDefaultImplementation(_ stub: GameDatabaseProtocol) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    
    
    
     var state: GameStateProtocol {
        get {
            return cuckoo_manager.getter("state",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.state)
        }
        
    }
    

    

    
    
    
     func setTurn(_ turn: String) -> Completable {
        
    return cuckoo_manager.call("setTurn(_: String) -> Completable",
            parameters: (turn),
            escapingParameters: (turn),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.setTurn(turn))
        
    }
    
    
    
     func setChallenge(_ challenge: Challenge?) -> Completable {
        
    return cuckoo_manager.call("setChallenge(_: Challenge?) -> Completable",
            parameters: (challenge),
            escapingParameters: (challenge),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.setChallenge(challenge))
        
    }
    
    
    
     func setOutcome(_ outcome: GameOutcome) -> Completable {
        
    return cuckoo_manager.call("setOutcome(_: GameOutcome) -> Completable",
            parameters: (outcome),
            escapingParameters: (outcome),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.setOutcome(outcome))
        
    }
    
    
    
     func deckRemoveFirst() -> Single<CardProtocol> {
        
    return cuckoo_manager.call("deckRemoveFirst() -> Single<CardProtocol>",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.deckRemoveFirst())
        
    }
    
    
    
     func discardRemoveFirst() -> Single<CardProtocol> {
        
    return cuckoo_manager.call("discardRemoveFirst() -> Single<CardProtocol>",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.discardRemoveFirst())
        
    }
    
    
    
     func addDeck(_ card: CardProtocol) -> Completable {
        
    return cuckoo_manager.call("addDeck(_: CardProtocol) -> Completable",
            parameters: (card),
            escapingParameters: (card),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.addDeck(card))
        
    }
    
    
    
     func addDiscard(_ card: CardProtocol) -> Completable {
        
    return cuckoo_manager.call("addDiscard(_: CardProtocol) -> Completable",
            parameters: (card),
            escapingParameters: (card),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.addDiscard(card))
        
    }
    
    
    
     func addGeneralStore(_ card: CardProtocol) -> Completable {
        
    return cuckoo_manager.call("addGeneralStore(_: CardProtocol) -> Completable",
            parameters: (card),
            escapingParameters: (card),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.addGeneralStore(card))
        
    }
    
    
    
     func removeGeneralStore(_ cardId: String) -> Single<CardProtocol> {
        
    return cuckoo_manager.call("removeGeneralStore(_: String) -> Single<CardProtocol>",
            parameters: (cardId),
            escapingParameters: (cardId),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.removeGeneralStore(cardId))
        
    }
    
    
    
     func playerSetHealth(_ playerId: String, _ health: Int) -> Completable {
        
    return cuckoo_manager.call("playerSetHealth(_: String, _: Int) -> Completable",
            parameters: (playerId, health),
            escapingParameters: (playerId, health),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.playerSetHealth(playerId, health))
        
    }
    
    
    
     func playerAddHand(_ playerId: String, _ card: CardProtocol) -> Completable {
        
    return cuckoo_manager.call("playerAddHand(_: String, _: CardProtocol) -> Completable",
            parameters: (playerId, card),
            escapingParameters: (playerId, card),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.playerAddHand(playerId, card))
        
    }
    
    
    
     func playerRemoveHand(_ playerId: String, _ cardId: String) -> Single<CardProtocol> {
        
    return cuckoo_manager.call("playerRemoveHand(_: String, _: String) -> Single<CardProtocol>",
            parameters: (playerId, cardId),
            escapingParameters: (playerId, cardId),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.playerRemoveHand(playerId, cardId))
        
    }
    
    
    
     func playerAddInPlay(_ playerId: String, _ card: CardProtocol) -> Completable {
        
    return cuckoo_manager.call("playerAddInPlay(_: String, _: CardProtocol) -> Completable",
            parameters: (playerId, card),
            escapingParameters: (playerId, card),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.playerAddInPlay(playerId, card))
        
    }
    
    
    
     func playerRemoveInPlay(_ playerId: String, _ cardId: String) -> Single<CardProtocol> {
        
    return cuckoo_manager.call("playerRemoveInPlay(_: String, _: String) -> Single<CardProtocol>",
            parameters: (playerId, cardId),
            escapingParameters: (playerId, cardId),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.playerRemoveInPlay(playerId, cardId))
        
    }
    
    
    
     func playerSetBangsPlayed(_ playerId: String, _ bangsPlayed: Int) -> Completable {
        
    return cuckoo_manager.call("playerSetBangsPlayed(_: String, _: Int) -> Completable",
            parameters: (playerId, bangsPlayed),
            escapingParameters: (playerId, bangsPlayed),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.playerSetBangsPlayed(playerId, bangsPlayed))
        
    }
    
    
    
     func playerSetDamageEvent(_ playerId: String, _ event: DamageEvent) -> Completable {
        
    return cuckoo_manager.call("playerSetDamageEvent(_: String, _: DamageEvent) -> Completable",
            parameters: (playerId, event),
            escapingParameters: (playerId, event),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.playerSetDamageEvent(playerId, event))
        
    }
    
    
    
     func setExecutedUpdate(_ update: GameUpdate) -> Completable {
        
    return cuckoo_manager.call("setExecutedUpdate(_: GameUpdate) -> Completable",
            parameters: (update),
            escapingParameters: (update),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.setExecutedUpdate(update))
        
    }
    
    
    
     func setExecutedMove(_ move: GameMove) -> Completable {
        
    return cuckoo_manager.call("setExecutedMove(_: GameMove) -> Completable",
            parameters: (move),
            escapingParameters: (move),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.setExecutedMove(move))
        
    }
    
    
    
     func setValidMoves(_ moves: [GameMove]) -> Completable {
        
    return cuckoo_manager.call("setValidMoves(_: [GameMove]) -> Completable",
            parameters: (moves),
            escapingParameters: (moves),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.setValidMoves(moves))
        
    }
    

	 struct __StubbingProxy_GameDatabaseProtocol: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    var state: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockGameDatabaseProtocol, GameStateProtocol> {
	        return .init(manager: cuckoo_manager, name: "state")
	    }
	    
	    
	    func setTurn<M1: Cuckoo.Matchable>(_ turn: M1) -> Cuckoo.ProtocolStubFunction<(String), Completable> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: turn) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockGameDatabaseProtocol.self, method: "setTurn(_: String) -> Completable", parameterMatchers: matchers))
	    }
	    
	    func setChallenge<M1: Cuckoo.OptionalMatchable>(_ challenge: M1) -> Cuckoo.ProtocolStubFunction<(Challenge?), Completable> where M1.OptionalMatchedType == Challenge {
	        let matchers: [Cuckoo.ParameterMatcher<(Challenge?)>] = [wrap(matchable: challenge) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockGameDatabaseProtocol.self, method: "setChallenge(_: Challenge?) -> Completable", parameterMatchers: matchers))
	    }
	    
	    func setOutcome<M1: Cuckoo.Matchable>(_ outcome: M1) -> Cuckoo.ProtocolStubFunction<(GameOutcome), Completable> where M1.MatchedType == GameOutcome {
	        let matchers: [Cuckoo.ParameterMatcher<(GameOutcome)>] = [wrap(matchable: outcome) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockGameDatabaseProtocol.self, method: "setOutcome(_: GameOutcome) -> Completable", parameterMatchers: matchers))
	    }
	    
	    func deckRemoveFirst() -> Cuckoo.ProtocolStubFunction<(), Single<CardProtocol>> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockGameDatabaseProtocol.self, method: "deckRemoveFirst() -> Single<CardProtocol>", parameterMatchers: matchers))
	    }
	    
	    func discardRemoveFirst() -> Cuckoo.ProtocolStubFunction<(), Single<CardProtocol>> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockGameDatabaseProtocol.self, method: "discardRemoveFirst() -> Single<CardProtocol>", parameterMatchers: matchers))
	    }
	    
	    func addDeck<M1: Cuckoo.Matchable>(_ card: M1) -> Cuckoo.ProtocolStubFunction<(CardProtocol), Completable> where M1.MatchedType == CardProtocol {
	        let matchers: [Cuckoo.ParameterMatcher<(CardProtocol)>] = [wrap(matchable: card) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockGameDatabaseProtocol.self, method: "addDeck(_: CardProtocol) -> Completable", parameterMatchers: matchers))
	    }
	    
	    func addDiscard<M1: Cuckoo.Matchable>(_ card: M1) -> Cuckoo.ProtocolStubFunction<(CardProtocol), Completable> where M1.MatchedType == CardProtocol {
	        let matchers: [Cuckoo.ParameterMatcher<(CardProtocol)>] = [wrap(matchable: card) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockGameDatabaseProtocol.self, method: "addDiscard(_: CardProtocol) -> Completable", parameterMatchers: matchers))
	    }
	    
	    func addGeneralStore<M1: Cuckoo.Matchable>(_ card: M1) -> Cuckoo.ProtocolStubFunction<(CardProtocol), Completable> where M1.MatchedType == CardProtocol {
	        let matchers: [Cuckoo.ParameterMatcher<(CardProtocol)>] = [wrap(matchable: card) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockGameDatabaseProtocol.self, method: "addGeneralStore(_: CardProtocol) -> Completable", parameterMatchers: matchers))
	    }
	    
	    func removeGeneralStore<M1: Cuckoo.Matchable>(_ cardId: M1) -> Cuckoo.ProtocolStubFunction<(String), Single<CardProtocol>> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: cardId) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockGameDatabaseProtocol.self, method: "removeGeneralStore(_: String) -> Single<CardProtocol>", parameterMatchers: matchers))
	    }
	    
	    func playerSetHealth<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(_ playerId: M1, _ health: M2) -> Cuckoo.ProtocolStubFunction<(String, Int), Completable> where M1.MatchedType == String, M2.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(String, Int)>] = [wrap(matchable: playerId) { $0.0 }, wrap(matchable: health) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockGameDatabaseProtocol.self, method: "playerSetHealth(_: String, _: Int) -> Completable", parameterMatchers: matchers))
	    }
	    
	    func playerAddHand<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(_ playerId: M1, _ card: M2) -> Cuckoo.ProtocolStubFunction<(String, CardProtocol), Completable> where M1.MatchedType == String, M2.MatchedType == CardProtocol {
	        let matchers: [Cuckoo.ParameterMatcher<(String, CardProtocol)>] = [wrap(matchable: playerId) { $0.0 }, wrap(matchable: card) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockGameDatabaseProtocol.self, method: "playerAddHand(_: String, _: CardProtocol) -> Completable", parameterMatchers: matchers))
	    }
	    
	    func playerRemoveHand<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(_ playerId: M1, _ cardId: M2) -> Cuckoo.ProtocolStubFunction<(String, String), Single<CardProtocol>> where M1.MatchedType == String, M2.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String, String)>] = [wrap(matchable: playerId) { $0.0 }, wrap(matchable: cardId) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockGameDatabaseProtocol.self, method: "playerRemoveHand(_: String, _: String) -> Single<CardProtocol>", parameterMatchers: matchers))
	    }
	    
	    func playerAddInPlay<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(_ playerId: M1, _ card: M2) -> Cuckoo.ProtocolStubFunction<(String, CardProtocol), Completable> where M1.MatchedType == String, M2.MatchedType == CardProtocol {
	        let matchers: [Cuckoo.ParameterMatcher<(String, CardProtocol)>] = [wrap(matchable: playerId) { $0.0 }, wrap(matchable: card) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockGameDatabaseProtocol.self, method: "playerAddInPlay(_: String, _: CardProtocol) -> Completable", parameterMatchers: matchers))
	    }
	    
	    func playerRemoveInPlay<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(_ playerId: M1, _ cardId: M2) -> Cuckoo.ProtocolStubFunction<(String, String), Single<CardProtocol>> where M1.MatchedType == String, M2.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String, String)>] = [wrap(matchable: playerId) { $0.0 }, wrap(matchable: cardId) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockGameDatabaseProtocol.self, method: "playerRemoveInPlay(_: String, _: String) -> Single<CardProtocol>", parameterMatchers: matchers))
	    }
	    
	    func playerSetBangsPlayed<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(_ playerId: M1, _ bangsPlayed: M2) -> Cuckoo.ProtocolStubFunction<(String, Int), Completable> where M1.MatchedType == String, M2.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(String, Int)>] = [wrap(matchable: playerId) { $0.0 }, wrap(matchable: bangsPlayed) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockGameDatabaseProtocol.self, method: "playerSetBangsPlayed(_: String, _: Int) -> Completable", parameterMatchers: matchers))
	    }
	    
	    func playerSetDamageEvent<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(_ playerId: M1, _ event: M2) -> Cuckoo.ProtocolStubFunction<(String, DamageEvent), Completable> where M1.MatchedType == String, M2.MatchedType == DamageEvent {
	        let matchers: [Cuckoo.ParameterMatcher<(String, DamageEvent)>] = [wrap(matchable: playerId) { $0.0 }, wrap(matchable: event) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockGameDatabaseProtocol.self, method: "playerSetDamageEvent(_: String, _: DamageEvent) -> Completable", parameterMatchers: matchers))
	    }
	    
	    func setExecutedUpdate<M1: Cuckoo.Matchable>(_ update: M1) -> Cuckoo.ProtocolStubFunction<(GameUpdate), Completable> where M1.MatchedType == GameUpdate {
	        let matchers: [Cuckoo.ParameterMatcher<(GameUpdate)>] = [wrap(matchable: update) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockGameDatabaseProtocol.self, method: "setExecutedUpdate(_: GameUpdate) -> Completable", parameterMatchers: matchers))
	    }
	    
	    func setExecutedMove<M1: Cuckoo.Matchable>(_ move: M1) -> Cuckoo.ProtocolStubFunction<(GameMove), Completable> where M1.MatchedType == GameMove {
	        let matchers: [Cuckoo.ParameterMatcher<(GameMove)>] = [wrap(matchable: move) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockGameDatabaseProtocol.self, method: "setExecutedMove(_: GameMove) -> Completable", parameterMatchers: matchers))
	    }
	    
	    func setValidMoves<M1: Cuckoo.Matchable>(_ moves: M1) -> Cuckoo.ProtocolStubFunction<([GameMove]), Completable> where M1.MatchedType == [GameMove] {
	        let matchers: [Cuckoo.ParameterMatcher<([GameMove])>] = [wrap(matchable: moves) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockGameDatabaseProtocol.self, method: "setValidMoves(_: [GameMove]) -> Completable", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_GameDatabaseProtocol: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	    
	    var state: Cuckoo.VerifyReadOnlyProperty<GameStateProtocol> {
	        return .init(manager: cuckoo_manager, name: "state", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	
	    
	    @discardableResult
	    func setTurn<M1: Cuckoo.Matchable>(_ turn: M1) -> Cuckoo.__DoNotUse<(String), Completable> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: turn) { $0 }]
	        return cuckoo_manager.verify("setTurn(_: String) -> Completable", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func setChallenge<M1: Cuckoo.OptionalMatchable>(_ challenge: M1) -> Cuckoo.__DoNotUse<(Challenge?), Completable> where M1.OptionalMatchedType == Challenge {
	        let matchers: [Cuckoo.ParameterMatcher<(Challenge?)>] = [wrap(matchable: challenge) { $0 }]
	        return cuckoo_manager.verify("setChallenge(_: Challenge?) -> Completable", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func setOutcome<M1: Cuckoo.Matchable>(_ outcome: M1) -> Cuckoo.__DoNotUse<(GameOutcome), Completable> where M1.MatchedType == GameOutcome {
	        let matchers: [Cuckoo.ParameterMatcher<(GameOutcome)>] = [wrap(matchable: outcome) { $0 }]
	        return cuckoo_manager.verify("setOutcome(_: GameOutcome) -> Completable", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func deckRemoveFirst() -> Cuckoo.__DoNotUse<(), Single<CardProtocol>> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("deckRemoveFirst() -> Single<CardProtocol>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func discardRemoveFirst() -> Cuckoo.__DoNotUse<(), Single<CardProtocol>> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("discardRemoveFirst() -> Single<CardProtocol>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func addDeck<M1: Cuckoo.Matchable>(_ card: M1) -> Cuckoo.__DoNotUse<(CardProtocol), Completable> where M1.MatchedType == CardProtocol {
	        let matchers: [Cuckoo.ParameterMatcher<(CardProtocol)>] = [wrap(matchable: card) { $0 }]
	        return cuckoo_manager.verify("addDeck(_: CardProtocol) -> Completable", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func addDiscard<M1: Cuckoo.Matchable>(_ card: M1) -> Cuckoo.__DoNotUse<(CardProtocol), Completable> where M1.MatchedType == CardProtocol {
	        let matchers: [Cuckoo.ParameterMatcher<(CardProtocol)>] = [wrap(matchable: card) { $0 }]
	        return cuckoo_manager.verify("addDiscard(_: CardProtocol) -> Completable", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func addGeneralStore<M1: Cuckoo.Matchable>(_ card: M1) -> Cuckoo.__DoNotUse<(CardProtocol), Completable> where M1.MatchedType == CardProtocol {
	        let matchers: [Cuckoo.ParameterMatcher<(CardProtocol)>] = [wrap(matchable: card) { $0 }]
	        return cuckoo_manager.verify("addGeneralStore(_: CardProtocol) -> Completable", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func removeGeneralStore<M1: Cuckoo.Matchable>(_ cardId: M1) -> Cuckoo.__DoNotUse<(String), Single<CardProtocol>> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: cardId) { $0 }]
	        return cuckoo_manager.verify("removeGeneralStore(_: String) -> Single<CardProtocol>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func playerSetHealth<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(_ playerId: M1, _ health: M2) -> Cuckoo.__DoNotUse<(String, Int), Completable> where M1.MatchedType == String, M2.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(String, Int)>] = [wrap(matchable: playerId) { $0.0 }, wrap(matchable: health) { $0.1 }]
	        return cuckoo_manager.verify("playerSetHealth(_: String, _: Int) -> Completable", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func playerAddHand<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(_ playerId: M1, _ card: M2) -> Cuckoo.__DoNotUse<(String, CardProtocol), Completable> where M1.MatchedType == String, M2.MatchedType == CardProtocol {
	        let matchers: [Cuckoo.ParameterMatcher<(String, CardProtocol)>] = [wrap(matchable: playerId) { $0.0 }, wrap(matchable: card) { $0.1 }]
	        return cuckoo_manager.verify("playerAddHand(_: String, _: CardProtocol) -> Completable", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func playerRemoveHand<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(_ playerId: M1, _ cardId: M2) -> Cuckoo.__DoNotUse<(String, String), Single<CardProtocol>> where M1.MatchedType == String, M2.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String, String)>] = [wrap(matchable: playerId) { $0.0 }, wrap(matchable: cardId) { $0.1 }]
	        return cuckoo_manager.verify("playerRemoveHand(_: String, _: String) -> Single<CardProtocol>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func playerAddInPlay<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(_ playerId: M1, _ card: M2) -> Cuckoo.__DoNotUse<(String, CardProtocol), Completable> where M1.MatchedType == String, M2.MatchedType == CardProtocol {
	        let matchers: [Cuckoo.ParameterMatcher<(String, CardProtocol)>] = [wrap(matchable: playerId) { $0.0 }, wrap(matchable: card) { $0.1 }]
	        return cuckoo_manager.verify("playerAddInPlay(_: String, _: CardProtocol) -> Completable", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func playerRemoveInPlay<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(_ playerId: M1, _ cardId: M2) -> Cuckoo.__DoNotUse<(String, String), Single<CardProtocol>> where M1.MatchedType == String, M2.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String, String)>] = [wrap(matchable: playerId) { $0.0 }, wrap(matchable: cardId) { $0.1 }]
	        return cuckoo_manager.verify("playerRemoveInPlay(_: String, _: String) -> Single<CardProtocol>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func playerSetBangsPlayed<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(_ playerId: M1, _ bangsPlayed: M2) -> Cuckoo.__DoNotUse<(String, Int), Completable> where M1.MatchedType == String, M2.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(String, Int)>] = [wrap(matchable: playerId) { $0.0 }, wrap(matchable: bangsPlayed) { $0.1 }]
	        return cuckoo_manager.verify("playerSetBangsPlayed(_: String, _: Int) -> Completable", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func playerSetDamageEvent<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(_ playerId: M1, _ event: M2) -> Cuckoo.__DoNotUse<(String, DamageEvent), Completable> where M1.MatchedType == String, M2.MatchedType == DamageEvent {
	        let matchers: [Cuckoo.ParameterMatcher<(String, DamageEvent)>] = [wrap(matchable: playerId) { $0.0 }, wrap(matchable: event) { $0.1 }]
	        return cuckoo_manager.verify("playerSetDamageEvent(_: String, _: DamageEvent) -> Completable", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func setExecutedUpdate<M1: Cuckoo.Matchable>(_ update: M1) -> Cuckoo.__DoNotUse<(GameUpdate), Completable> where M1.MatchedType == GameUpdate {
	        let matchers: [Cuckoo.ParameterMatcher<(GameUpdate)>] = [wrap(matchable: update) { $0 }]
	        return cuckoo_manager.verify("setExecutedUpdate(_: GameUpdate) -> Completable", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func setExecutedMove<M1: Cuckoo.Matchable>(_ move: M1) -> Cuckoo.__DoNotUse<(GameMove), Completable> where M1.MatchedType == GameMove {
	        let matchers: [Cuckoo.ParameterMatcher<(GameMove)>] = [wrap(matchable: move) { $0 }]
	        return cuckoo_manager.verify("setExecutedMove(_: GameMove) -> Completable", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func setValidMoves<M1: Cuckoo.Matchable>(_ moves: M1) -> Cuckoo.__DoNotUse<([GameMove]), Completable> where M1.MatchedType == [GameMove] {
	        let matchers: [Cuckoo.ParameterMatcher<([GameMove])>] = [wrap(matchable: moves) { $0 }]
	        return cuckoo_manager.verify("setValidMoves(_: [GameMove]) -> Completable", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class GameDatabaseProtocolStub: GameDatabaseProtocol {
    
    
     var state: GameStateProtocol {
        get {
            return DefaultValueRegistry.defaultValue(for: (GameStateProtocol).self)
        }
        
    }
    

    

    
     func setTurn(_ turn: String) -> Completable  {
        return DefaultValueRegistry.defaultValue(for: (Completable).self)
    }
    
     func setChallenge(_ challenge: Challenge?) -> Completable  {
        return DefaultValueRegistry.defaultValue(for: (Completable).self)
    }
    
     func setOutcome(_ outcome: GameOutcome) -> Completable  {
        return DefaultValueRegistry.defaultValue(for: (Completable).self)
    }
    
     func deckRemoveFirst() -> Single<CardProtocol>  {
        return DefaultValueRegistry.defaultValue(for: (Single<CardProtocol>).self)
    }
    
     func discardRemoveFirst() -> Single<CardProtocol>  {
        return DefaultValueRegistry.defaultValue(for: (Single<CardProtocol>).self)
    }
    
     func addDeck(_ card: CardProtocol) -> Completable  {
        return DefaultValueRegistry.defaultValue(for: (Completable).self)
    }
    
     func addDiscard(_ card: CardProtocol) -> Completable  {
        return DefaultValueRegistry.defaultValue(for: (Completable).self)
    }
    
     func addGeneralStore(_ card: CardProtocol) -> Completable  {
        return DefaultValueRegistry.defaultValue(for: (Completable).self)
    }
    
     func removeGeneralStore(_ cardId: String) -> Single<CardProtocol>  {
        return DefaultValueRegistry.defaultValue(for: (Single<CardProtocol>).self)
    }
    
     func playerSetHealth(_ playerId: String, _ health: Int) -> Completable  {
        return DefaultValueRegistry.defaultValue(for: (Completable).self)
    }
    
     func playerAddHand(_ playerId: String, _ card: CardProtocol) -> Completable  {
        return DefaultValueRegistry.defaultValue(for: (Completable).self)
    }
    
     func playerRemoveHand(_ playerId: String, _ cardId: String) -> Single<CardProtocol>  {
        return DefaultValueRegistry.defaultValue(for: (Single<CardProtocol>).self)
    }
    
     func playerAddInPlay(_ playerId: String, _ card: CardProtocol) -> Completable  {
        return DefaultValueRegistry.defaultValue(for: (Completable).self)
    }
    
     func playerRemoveInPlay(_ playerId: String, _ cardId: String) -> Single<CardProtocol>  {
        return DefaultValueRegistry.defaultValue(for: (Single<CardProtocol>).self)
    }
    
     func playerSetBangsPlayed(_ playerId: String, _ bangsPlayed: Int) -> Completable  {
        return DefaultValueRegistry.defaultValue(for: (Completable).self)
    }
    
     func playerSetDamageEvent(_ playerId: String, _ event: DamageEvent) -> Completable  {
        return DefaultValueRegistry.defaultValue(for: (Completable).self)
    }
    
     func setExecutedUpdate(_ update: GameUpdate) -> Completable  {
        return DefaultValueRegistry.defaultValue(for: (Completable).self)
    }
    
     func setExecutedMove(_ move: GameMove) -> Completable  {
        return DefaultValueRegistry.defaultValue(for: (Completable).self)
    }
    
     func setValidMoves(_ moves: [GameMove]) -> Completable  {
        return DefaultValueRegistry.defaultValue(for: (Completable).self)
    }
    
}


import Cuckoo
@testable import WildWest


 class MockMoveMatcherProtocol: MoveMatcherProtocol, Cuckoo.ProtocolMock {
    
     typealias MocksType = MoveMatcherProtocol
    
     typealias Stubbing = __StubbingProxy_MoveMatcherProtocol
     typealias Verification = __VerificationProxy_MoveMatcherProtocol

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: MoveMatcherProtocol?

     func enableDefaultImplementation(_ stub: MoveMatcherProtocol) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
     func moves(matching state: GameStateProtocol) -> [GameMove]? {
        
    return cuckoo_manager.call("moves(matching: GameStateProtocol) -> [GameMove]?",
            parameters: (state),
            escapingParameters: (state),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.moves(matching: state))
        
    }
    
    
    
     func autoPlay(matching state: GameStateProtocol) -> GameMove? {
        
    return cuckoo_manager.call("autoPlay(matching: GameStateProtocol) -> GameMove?",
            parameters: (state),
            escapingParameters: (state),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.autoPlay(matching: state))
        
    }
    
    
    
     func effect(onExecuting move: GameMove, in state: GameStateProtocol) -> GameMove? {
        
    return cuckoo_manager.call("effect(onExecuting: GameMove, in: GameStateProtocol) -> GameMove?",
            parameters: (move, state),
            escapingParameters: (move, state),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.effect(onExecuting: move, in: state))
        
    }
    
    
    
     func updates(onExecuting move: GameMove, in state: GameStateProtocol) -> [GameUpdate]? {
        
    return cuckoo_manager.call("updates(onExecuting: GameMove, in: GameStateProtocol) -> [GameUpdate]?",
            parameters: (move, state),
            escapingParameters: (move, state),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.updates(onExecuting: move, in: state))
        
    }
    

	 struct __StubbingProxy_MoveMatcherProtocol: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func moves<M1: Cuckoo.Matchable>(matching state: M1) -> Cuckoo.ProtocolStubFunction<(GameStateProtocol), [GameMove]?> where M1.MatchedType == GameStateProtocol {
	        let matchers: [Cuckoo.ParameterMatcher<(GameStateProtocol)>] = [wrap(matchable: state) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockMoveMatcherProtocol.self, method: "moves(matching: GameStateProtocol) -> [GameMove]?", parameterMatchers: matchers))
	    }
	    
	    func autoPlay<M1: Cuckoo.Matchable>(matching state: M1) -> Cuckoo.ProtocolStubFunction<(GameStateProtocol), GameMove?> where M1.MatchedType == GameStateProtocol {
	        let matchers: [Cuckoo.ParameterMatcher<(GameStateProtocol)>] = [wrap(matchable: state) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockMoveMatcherProtocol.self, method: "autoPlay(matching: GameStateProtocol) -> GameMove?", parameterMatchers: matchers))
	    }
	    
	    func effect<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(onExecuting move: M1, in state: M2) -> Cuckoo.ProtocolStubFunction<(GameMove, GameStateProtocol), GameMove?> where M1.MatchedType == GameMove, M2.MatchedType == GameStateProtocol {
	        let matchers: [Cuckoo.ParameterMatcher<(GameMove, GameStateProtocol)>] = [wrap(matchable: move) { $0.0 }, wrap(matchable: state) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockMoveMatcherProtocol.self, method: "effect(onExecuting: GameMove, in: GameStateProtocol) -> GameMove?", parameterMatchers: matchers))
	    }
	    
	    func updates<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(onExecuting move: M1, in state: M2) -> Cuckoo.ProtocolStubFunction<(GameMove, GameStateProtocol), [GameUpdate]?> where M1.MatchedType == GameMove, M2.MatchedType == GameStateProtocol {
	        let matchers: [Cuckoo.ParameterMatcher<(GameMove, GameStateProtocol)>] = [wrap(matchable: move) { $0.0 }, wrap(matchable: state) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockMoveMatcherProtocol.self, method: "updates(onExecuting: GameMove, in: GameStateProtocol) -> [GameUpdate]?", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_MoveMatcherProtocol: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func moves<M1: Cuckoo.Matchable>(matching state: M1) -> Cuckoo.__DoNotUse<(GameStateProtocol), [GameMove]?> where M1.MatchedType == GameStateProtocol {
	        let matchers: [Cuckoo.ParameterMatcher<(GameStateProtocol)>] = [wrap(matchable: state) { $0 }]
	        return cuckoo_manager.verify("moves(matching: GameStateProtocol) -> [GameMove]?", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func autoPlay<M1: Cuckoo.Matchable>(matching state: M1) -> Cuckoo.__DoNotUse<(GameStateProtocol), GameMove?> where M1.MatchedType == GameStateProtocol {
	        let matchers: [Cuckoo.ParameterMatcher<(GameStateProtocol)>] = [wrap(matchable: state) { $0 }]
	        return cuckoo_manager.verify("autoPlay(matching: GameStateProtocol) -> GameMove?", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func effect<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(onExecuting move: M1, in state: M2) -> Cuckoo.__DoNotUse<(GameMove, GameStateProtocol), GameMove?> where M1.MatchedType == GameMove, M2.MatchedType == GameStateProtocol {
	        let matchers: [Cuckoo.ParameterMatcher<(GameMove, GameStateProtocol)>] = [wrap(matchable: move) { $0.0 }, wrap(matchable: state) { $0.1 }]
	        return cuckoo_manager.verify("effect(onExecuting: GameMove, in: GameStateProtocol) -> GameMove?", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func updates<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(onExecuting move: M1, in state: M2) -> Cuckoo.__DoNotUse<(GameMove, GameStateProtocol), [GameUpdate]?> where M1.MatchedType == GameMove, M2.MatchedType == GameStateProtocol {
	        let matchers: [Cuckoo.ParameterMatcher<(GameMove, GameStateProtocol)>] = [wrap(matchable: move) { $0.0 }, wrap(matchable: state) { $0.1 }]
	        return cuckoo_manager.verify("updates(onExecuting: GameMove, in: GameStateProtocol) -> [GameUpdate]?", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class MoveMatcherProtocolStub: MoveMatcherProtocol {
    

    

    
     func moves(matching state: GameStateProtocol) -> [GameMove]?  {
        return DefaultValueRegistry.defaultValue(for: ([GameMove]?).self)
    }
    
     func autoPlay(matching state: GameStateProtocol) -> GameMove?  {
        return DefaultValueRegistry.defaultValue(for: (GameMove?).self)
    }
    
     func effect(onExecuting move: GameMove, in state: GameStateProtocol) -> GameMove?  {
        return DefaultValueRegistry.defaultValue(for: (GameMove?).self)
    }
    
     func updates(onExecuting move: GameMove, in state: GameStateProtocol) -> [GameUpdate]?  {
        return DefaultValueRegistry.defaultValue(for: ([GameUpdate]?).self)
    }
    
}


import Cuckoo
@testable import WildWest


 class MockGameSetupProtocol: GameSetupProtocol, Cuckoo.ProtocolMock {
    
     typealias MocksType = GameSetupProtocol
    
     typealias Stubbing = __StubbingProxy_GameSetupProtocol
     typealias Verification = __VerificationProxy_GameSetupProtocol

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: GameSetupProtocol?

     func enableDefaultImplementation(_ stub: GameSetupProtocol) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
     func roles(for playersCount: Int) -> [Role] {
        
    return cuckoo_manager.call("roles(for: Int) -> [Role]",
            parameters: (playersCount),
            escapingParameters: (playersCount),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.roles(for: playersCount))
        
    }
    
    
    
     func setupGame(roles: [Role], figures: [FigureProtocol], cards: [CardProtocol]) -> GameStateProtocol {
        
    return cuckoo_manager.call("setupGame(roles: [Role], figures: [FigureProtocol], cards: [CardProtocol]) -> GameStateProtocol",
            parameters: (roles, figures, cards),
            escapingParameters: (roles, figures, cards),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.setupGame(roles: roles, figures: figures, cards: cards))
        
    }
    

	 struct __StubbingProxy_GameSetupProtocol: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func roles<M1: Cuckoo.Matchable>(for playersCount: M1) -> Cuckoo.ProtocolStubFunction<(Int), [Role]> where M1.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(Int)>] = [wrap(matchable: playersCount) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockGameSetupProtocol.self, method: "roles(for: Int) -> [Role]", parameterMatchers: matchers))
	    }
	    
	    func setupGame<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable>(roles: M1, figures: M2, cards: M3) -> Cuckoo.ProtocolStubFunction<([Role], [FigureProtocol], [CardProtocol]), GameStateProtocol> where M1.MatchedType == [Role], M2.MatchedType == [FigureProtocol], M3.MatchedType == [CardProtocol] {
	        let matchers: [Cuckoo.ParameterMatcher<([Role], [FigureProtocol], [CardProtocol])>] = [wrap(matchable: roles) { $0.0 }, wrap(matchable: figures) { $0.1 }, wrap(matchable: cards) { $0.2 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockGameSetupProtocol.self, method: "setupGame(roles: [Role], figures: [FigureProtocol], cards: [CardProtocol]) -> GameStateProtocol", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_GameSetupProtocol: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func roles<M1: Cuckoo.Matchable>(for playersCount: M1) -> Cuckoo.__DoNotUse<(Int), [Role]> where M1.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(Int)>] = [wrap(matchable: playersCount) { $0 }]
	        return cuckoo_manager.verify("roles(for: Int) -> [Role]", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func setupGame<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable>(roles: M1, figures: M2, cards: M3) -> Cuckoo.__DoNotUse<([Role], [FigureProtocol], [CardProtocol]), GameStateProtocol> where M1.MatchedType == [Role], M2.MatchedType == [FigureProtocol], M3.MatchedType == [CardProtocol] {
	        let matchers: [Cuckoo.ParameterMatcher<([Role], [FigureProtocol], [CardProtocol])>] = [wrap(matchable: roles) { $0.0 }, wrap(matchable: figures) { $0.1 }, wrap(matchable: cards) { $0.2 }]
	        return cuckoo_manager.verify("setupGame(roles: [Role], figures: [FigureProtocol], cards: [CardProtocol]) -> GameStateProtocol", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class GameSetupProtocolStub: GameSetupProtocol {
    

    

    
     func roles(for playersCount: Int) -> [Role]  {
        return DefaultValueRegistry.defaultValue(for: ([Role]).self)
    }
    
     func setupGame(roles: [Role], figures: [FigureProtocol], cards: [CardProtocol]) -> GameStateProtocol  {
        return DefaultValueRegistry.defaultValue(for: (GameStateProtocol).self)
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
    

    
    
    
     var name: FigureName {
        get {
            return cuckoo_manager.getter("name",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.name)
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
    
    
    
     var description: String {
        get {
            return cuckoo_manager.getter("description",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.description)
        }
        
    }
    
    
    
     var abilities: [AbilityName: Bool] {
        get {
            return cuckoo_manager.getter("abilities",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.abilities)
        }
        
    }
    

    

    

	 struct __StubbingProxy_FigureProtocol: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    var name: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockFigureProtocol, FigureName> {
	        return .init(manager: cuckoo_manager, name: "name")
	    }
	    
	    
	    var bullets: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockFigureProtocol, Int> {
	        return .init(manager: cuckoo_manager, name: "bullets")
	    }
	    
	    
	    var imageName: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockFigureProtocol, String> {
	        return .init(manager: cuckoo_manager, name: "imageName")
	    }
	    
	    
	    var description: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockFigureProtocol, String> {
	        return .init(manager: cuckoo_manager, name: "description")
	    }
	    
	    
	    var abilities: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockFigureProtocol, [AbilityName: Bool]> {
	        return .init(manager: cuckoo_manager, name: "abilities")
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
	
	    
	    
	    var name: Cuckoo.VerifyReadOnlyProperty<FigureName> {
	        return .init(manager: cuckoo_manager, name: "name", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var bullets: Cuckoo.VerifyReadOnlyProperty<Int> {
	        return .init(manager: cuckoo_manager, name: "bullets", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var imageName: Cuckoo.VerifyReadOnlyProperty<String> {
	        return .init(manager: cuckoo_manager, name: "imageName", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var description: Cuckoo.VerifyReadOnlyProperty<String> {
	        return .init(manager: cuckoo_manager, name: "description", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var abilities: Cuckoo.VerifyReadOnlyProperty<[AbilityName: Bool]> {
	        return .init(manager: cuckoo_manager, name: "abilities", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	
	    
	}
}

 class FigureProtocolStub: FigureProtocol {
    
    
     var name: FigureName {
        get {
            return DefaultValueRegistry.defaultValue(for: (FigureName).self)
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
    
    
     var description: String {
        get {
            return DefaultValueRegistry.defaultValue(for: (String).self)
        }
        
    }
    
    
     var abilities: [AbilityName: Bool] {
        get {
            return DefaultValueRegistry.defaultValue(for: ([AbilityName: Bool]).self)
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
    

    
    
    
     var allPlayers: [PlayerProtocol] {
        get {
            return cuckoo_manager.getter("allPlayers",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.allPlayers)
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
    
    
    
     var discardPile: [CardProtocol] {
        get {
            return cuckoo_manager.getter("discardPile",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.discardPile)
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
    
    
    
     var generalStore: [CardProtocol] {
        get {
            return cuckoo_manager.getter("generalStore",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.generalStore)
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
    

    

    

	 struct __StubbingProxy_GameStateProtocol: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    var allPlayers: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockGameStateProtocol, [PlayerProtocol]> {
	        return .init(manager: cuckoo_manager, name: "allPlayers")
	    }
	    
	    
	    var deck: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockGameStateProtocol, [CardProtocol]> {
	        return .init(manager: cuckoo_manager, name: "deck")
	    }
	    
	    
	    var discardPile: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockGameStateProtocol, [CardProtocol]> {
	        return .init(manager: cuckoo_manager, name: "discardPile")
	    }
	    
	    
	    var turn: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockGameStateProtocol, String> {
	        return .init(manager: cuckoo_manager, name: "turn")
	    }
	    
	    
	    var challenge: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockGameStateProtocol, Challenge?> {
	        return .init(manager: cuckoo_manager, name: "challenge")
	    }
	    
	    
	    var generalStore: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockGameStateProtocol, [CardProtocol]> {
	        return .init(manager: cuckoo_manager, name: "generalStore")
	    }
	    
	    
	    var outcome: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockGameStateProtocol, GameOutcome?> {
	        return .init(manager: cuckoo_manager, name: "outcome")
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
	
	    
	    
	    var allPlayers: Cuckoo.VerifyReadOnlyProperty<[PlayerProtocol]> {
	        return .init(manager: cuckoo_manager, name: "allPlayers", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var deck: Cuckoo.VerifyReadOnlyProperty<[CardProtocol]> {
	        return .init(manager: cuckoo_manager, name: "deck", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var discardPile: Cuckoo.VerifyReadOnlyProperty<[CardProtocol]> {
	        return .init(manager: cuckoo_manager, name: "discardPile", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var turn: Cuckoo.VerifyReadOnlyProperty<String> {
	        return .init(manager: cuckoo_manager, name: "turn", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var challenge: Cuckoo.VerifyReadOnlyProperty<Challenge?> {
	        return .init(manager: cuckoo_manager, name: "challenge", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var generalStore: Cuckoo.VerifyReadOnlyProperty<[CardProtocol]> {
	        return .init(manager: cuckoo_manager, name: "generalStore", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var outcome: Cuckoo.VerifyReadOnlyProperty<GameOutcome?> {
	        return .init(manager: cuckoo_manager, name: "outcome", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	
	    
	}
}

 class GameStateProtocolStub: GameStateProtocol {
    
    
     var allPlayers: [PlayerProtocol] {
        get {
            return DefaultValueRegistry.defaultValue(for: ([PlayerProtocol]).self)
        }
        
    }
    
    
     var deck: [CardProtocol] {
        get {
            return DefaultValueRegistry.defaultValue(for: ([CardProtocol]).self)
        }
        
    }
    
    
     var discardPile: [CardProtocol] {
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
    
    
     var generalStore: [CardProtocol] {
        get {
            return DefaultValueRegistry.defaultValue(for: ([CardProtocol]).self)
        }
        
    }
    
    
     var outcome: GameOutcome? {
        get {
            return DefaultValueRegistry.defaultValue(for: (GameOutcome?).self)
        }
        
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
    
    
    
     var role: Role? {
        get {
            return cuckoo_manager.getter("role",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.role)
        }
        
    }
    
    
    
     var figureName: FigureName {
        get {
            return cuckoo_manager.getter("figureName",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.figureName)
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
    
    
    
     var description: String {
        get {
            return cuckoo_manager.getter("description",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.description)
        }
        
    }
    
    
    
     var abilities: [AbilityName: Bool] {
        get {
            return cuckoo_manager.getter("abilities",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.abilities)
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
    
    
    
     var bangsPlayed: Int {
        get {
            return cuckoo_manager.getter("bangsPlayed",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.bangsPlayed)
        }
        
    }
    
    
    
     var lastDamage: DamageEvent? {
        get {
            return cuckoo_manager.getter("lastDamage",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.lastDamage)
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
	    
	    
	    var role: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockPlayerProtocol, Role?> {
	        return .init(manager: cuckoo_manager, name: "role")
	    }
	    
	    
	    var figureName: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockPlayerProtocol, FigureName> {
	        return .init(manager: cuckoo_manager, name: "figureName")
	    }
	    
	    
	    var imageName: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockPlayerProtocol, String> {
	        return .init(manager: cuckoo_manager, name: "imageName")
	    }
	    
	    
	    var description: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockPlayerProtocol, String> {
	        return .init(manager: cuckoo_manager, name: "description")
	    }
	    
	    
	    var abilities: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockPlayerProtocol, [AbilityName: Bool]> {
	        return .init(manager: cuckoo_manager, name: "abilities")
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
	    
	    
	    var bangsPlayed: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockPlayerProtocol, Int> {
	        return .init(manager: cuckoo_manager, name: "bangsPlayed")
	    }
	    
	    
	    var lastDamage: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockPlayerProtocol, DamageEvent?> {
	        return .init(manager: cuckoo_manager, name: "lastDamage")
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
	    
	    
	    var role: Cuckoo.VerifyReadOnlyProperty<Role?> {
	        return .init(manager: cuckoo_manager, name: "role", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var figureName: Cuckoo.VerifyReadOnlyProperty<FigureName> {
	        return .init(manager: cuckoo_manager, name: "figureName", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var imageName: Cuckoo.VerifyReadOnlyProperty<String> {
	        return .init(manager: cuckoo_manager, name: "imageName", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var description: Cuckoo.VerifyReadOnlyProperty<String> {
	        return .init(manager: cuckoo_manager, name: "description", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var abilities: Cuckoo.VerifyReadOnlyProperty<[AbilityName: Bool]> {
	        return .init(manager: cuckoo_manager, name: "abilities", callMatcher: callMatcher, sourceLocation: sourceLocation)
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
	    
	    
	    var bangsPlayed: Cuckoo.VerifyReadOnlyProperty<Int> {
	        return .init(manager: cuckoo_manager, name: "bangsPlayed", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var lastDamage: Cuckoo.VerifyReadOnlyProperty<DamageEvent?> {
	        return .init(manager: cuckoo_manager, name: "lastDamage", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	
	    
	}
}

 class PlayerProtocolStub: PlayerProtocol {
    
    
     var identifier: String {
        get {
            return DefaultValueRegistry.defaultValue(for: (String).self)
        }
        
    }
    
    
     var role: Role? {
        get {
            return DefaultValueRegistry.defaultValue(for: (Role?).self)
        }
        
    }
    
    
     var figureName: FigureName {
        get {
            return DefaultValueRegistry.defaultValue(for: (FigureName).self)
        }
        
    }
    
    
     var imageName: String {
        get {
            return DefaultValueRegistry.defaultValue(for: (String).self)
        }
        
    }
    
    
     var description: String {
        get {
            return DefaultValueRegistry.defaultValue(for: (String).self)
        }
        
    }
    
    
     var abilities: [AbilityName: Bool] {
        get {
            return DefaultValueRegistry.defaultValue(for: ([AbilityName: Bool]).self)
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
    
    
     var bangsPlayed: Int {
        get {
            return DefaultValueRegistry.defaultValue(for: (Int).self)
        }
        
    }
    
    
     var lastDamage: DamageEvent? {
        get {
            return DefaultValueRegistry.defaultValue(for: (DamageEvent?).self)
        }
        
    }
    

    

    
}

