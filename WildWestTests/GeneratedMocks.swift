import Cuckoo
@testable import WildWest


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
    
    
    
     func setBarrelsResolved(_ barrelsResolved: Int)  {
        
    return cuckoo_manager.call("setBarrelsResolved(_: Int)",
            parameters: (barrelsResolved),
            escapingParameters: (barrelsResolved),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.setBarrelsResolved(barrelsResolved))
        
    }
    
    
    
     func addExecutedMove(_ move: GameMove)  {
        
    return cuckoo_manager.call("addExecutedMove(_: GameMove)",
            parameters: (move),
            escapingParameters: (move),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.addExecutedMove(move))
        
    }
    
    
    
     func setValidMoves(_ moves: [String: [GameMove]])  {
        
    return cuckoo_manager.call("setValidMoves(_: [String: [GameMove]])",
            parameters: (moves),
            escapingParameters: (moves),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.setValidMoves(moves))
        
    }
    
    
    
     func setOutcome(_ outcome: GameOutcome)  {
        
    return cuckoo_manager.call("setOutcome(_: GameOutcome)",
            parameters: (outcome),
            escapingParameters: (outcome),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.setOutcome(outcome))
        
    }
    
    
    
     func removePlayer(_ playerId: String) -> PlayerProtocol? {
        
    return cuckoo_manager.call("removePlayer(_: String) -> PlayerProtocol?",
            parameters: (playerId),
            escapingParameters: (playerId),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.removePlayer(playerId))
        
    }
    
    
    
     func addEliminated(_ player: PlayerProtocol)  {
        
    return cuckoo_manager.call("addEliminated(_: PlayerProtocol)",
            parameters: (player),
            escapingParameters: (player),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.addEliminated(player))
        
    }
    
    
    
     func addDamageEvent(_ event: DamageEvent)  {
        
    return cuckoo_manager.call("addDamageEvent(_: DamageEvent)",
            parameters: (event),
            escapingParameters: (event),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.addDamageEvent(event))
        
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
    
    
    
     func addGeneralStore(_ card: CardProtocol)  {
        
    return cuckoo_manager.call("addGeneralStore(_: CardProtocol)",
            parameters: (card),
            escapingParameters: (card),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.addGeneralStore(card))
        
    }
    
    
    
     func removeGeneralStore(_ cardId: String) -> CardProtocol? {
        
    return cuckoo_manager.call("removeGeneralStore(_: String) -> CardProtocol?",
            parameters: (cardId),
            escapingParameters: (cardId),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.removeGeneralStore(cardId))
        
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
    
    
    
     func playerAddHand(_ playerId: String, _ card: CardProtocol)  {
        
    return cuckoo_manager.call("playerAddHand(_: String, _: CardProtocol)",
            parameters: (playerId, card),
            escapingParameters: (playerId, card),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.playerAddHand(playerId, card))
        
    }
    
    
    
     func playerRemoveHand(_ playerId: String, _ cardId: String) -> CardProtocol? {
        
    return cuckoo_manager.call("playerRemoveHand(_: String, _: String) -> CardProtocol?",
            parameters: (playerId, cardId),
            escapingParameters: (playerId, cardId),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.playerRemoveHand(playerId, cardId))
        
    }
    
    
    
     func playerAddInPlay(_ playerId: String, _ card: CardProtocol)  {
        
    return cuckoo_manager.call("playerAddInPlay(_: String, _: CardProtocol)",
            parameters: (playerId, card),
            escapingParameters: (playerId, card),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.playerAddInPlay(playerId, card))
        
    }
    
    
    
     func playerRemoveInPlay(_ playerId: String, _ cardId: String) -> CardProtocol? {
        
    return cuckoo_manager.call("playerRemoveInPlay(_: String, _: String) -> CardProtocol?",
            parameters: (playerId, cardId),
            escapingParameters: (playerId, cardId),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.playerRemoveInPlay(playerId, cardId))
        
    }
    

	 struct __StubbingProxy_GameDatabaseProtocol: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    var state: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockGameDatabaseProtocol, GameStateProtocol> {
	        return .init(manager: cuckoo_manager, name: "state")
	    }
	    
	    
	    func setTurn<M1: Cuckoo.Matchable>(_ turn: M1) -> Cuckoo.ProtocolStubNoReturnFunction<(String)> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: turn) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockGameDatabaseProtocol.self, method: "setTurn(_: String)", parameterMatchers: matchers))
	    }
	    
	    func setChallenge<M1: Cuckoo.OptionalMatchable>(_ challenge: M1) -> Cuckoo.ProtocolStubNoReturnFunction<(Challenge?)> where M1.OptionalMatchedType == Challenge {
	        let matchers: [Cuckoo.ParameterMatcher<(Challenge?)>] = [wrap(matchable: challenge) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockGameDatabaseProtocol.self, method: "setChallenge(_: Challenge?)", parameterMatchers: matchers))
	    }
	    
	    func setBangsPlayed<M1: Cuckoo.Matchable>(_ bangsPlayed: M1) -> Cuckoo.ProtocolStubNoReturnFunction<(Int)> where M1.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(Int)>] = [wrap(matchable: bangsPlayed) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockGameDatabaseProtocol.self, method: "setBangsPlayed(_: Int)", parameterMatchers: matchers))
	    }
	    
	    func setBarrelsResolved<M1: Cuckoo.Matchable>(_ barrelsResolved: M1) -> Cuckoo.ProtocolStubNoReturnFunction<(Int)> where M1.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(Int)>] = [wrap(matchable: barrelsResolved) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockGameDatabaseProtocol.self, method: "setBarrelsResolved(_: Int)", parameterMatchers: matchers))
	    }
	    
	    func addExecutedMove<M1: Cuckoo.Matchable>(_ move: M1) -> Cuckoo.ProtocolStubNoReturnFunction<(GameMove)> where M1.MatchedType == GameMove {
	        let matchers: [Cuckoo.ParameterMatcher<(GameMove)>] = [wrap(matchable: move) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockGameDatabaseProtocol.self, method: "addExecutedMove(_: GameMove)", parameterMatchers: matchers))
	    }
	    
	    func setValidMoves<M1: Cuckoo.Matchable>(_ moves: M1) -> Cuckoo.ProtocolStubNoReturnFunction<([String: [GameMove]])> where M1.MatchedType == [String: [GameMove]] {
	        let matchers: [Cuckoo.ParameterMatcher<([String: [GameMove]])>] = [wrap(matchable: moves) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockGameDatabaseProtocol.self, method: "setValidMoves(_: [String: [GameMove]])", parameterMatchers: matchers))
	    }
	    
	    func setOutcome<M1: Cuckoo.Matchable>(_ outcome: M1) -> Cuckoo.ProtocolStubNoReturnFunction<(GameOutcome)> where M1.MatchedType == GameOutcome {
	        let matchers: [Cuckoo.ParameterMatcher<(GameOutcome)>] = [wrap(matchable: outcome) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockGameDatabaseProtocol.self, method: "setOutcome(_: GameOutcome)", parameterMatchers: matchers))
	    }
	    
	    func removePlayer<M1: Cuckoo.Matchable>(_ playerId: M1) -> Cuckoo.ProtocolStubFunction<(String), PlayerProtocol?> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: playerId) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockGameDatabaseProtocol.self, method: "removePlayer(_: String) -> PlayerProtocol?", parameterMatchers: matchers))
	    }
	    
	    func addEliminated<M1: Cuckoo.Matchable>(_ player: M1) -> Cuckoo.ProtocolStubNoReturnFunction<(PlayerProtocol)> where M1.MatchedType == PlayerProtocol {
	        let matchers: [Cuckoo.ParameterMatcher<(PlayerProtocol)>] = [wrap(matchable: player) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockGameDatabaseProtocol.self, method: "addEliminated(_: PlayerProtocol)", parameterMatchers: matchers))
	    }
	    
	    func addDamageEvent<M1: Cuckoo.Matchable>(_ event: M1) -> Cuckoo.ProtocolStubNoReturnFunction<(DamageEvent)> where M1.MatchedType == DamageEvent {
	        let matchers: [Cuckoo.ParameterMatcher<(DamageEvent)>] = [wrap(matchable: event) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockGameDatabaseProtocol.self, method: "addDamageEvent(_: DamageEvent)", parameterMatchers: matchers))
	    }
	    
	    func deckRemoveFirst() -> Cuckoo.ProtocolStubFunction<(), CardProtocol> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockGameDatabaseProtocol.self, method: "deckRemoveFirst() -> CardProtocol", parameterMatchers: matchers))
	    }
	    
	    func addDiscard<M1: Cuckoo.Matchable>(_ card: M1) -> Cuckoo.ProtocolStubNoReturnFunction<(CardProtocol)> where M1.MatchedType == CardProtocol {
	        let matchers: [Cuckoo.ParameterMatcher<(CardProtocol)>] = [wrap(matchable: card) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockGameDatabaseProtocol.self, method: "addDiscard(_: CardProtocol)", parameterMatchers: matchers))
	    }
	    
	    func addGeneralStore<M1: Cuckoo.Matchable>(_ card: M1) -> Cuckoo.ProtocolStubNoReturnFunction<(CardProtocol)> where M1.MatchedType == CardProtocol {
	        let matchers: [Cuckoo.ParameterMatcher<(CardProtocol)>] = [wrap(matchable: card) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockGameDatabaseProtocol.self, method: "addGeneralStore(_: CardProtocol)", parameterMatchers: matchers))
	    }
	    
	    func removeGeneralStore<M1: Cuckoo.Matchable>(_ cardId: M1) -> Cuckoo.ProtocolStubFunction<(String), CardProtocol?> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: cardId) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockGameDatabaseProtocol.self, method: "removeGeneralStore(_: String) -> CardProtocol?", parameterMatchers: matchers))
	    }
	    
	    func playerSetHealth<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(_ playerId: M1, _ health: M2) -> Cuckoo.ProtocolStubNoReturnFunction<(String, Int)> where M1.MatchedType == String, M2.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(String, Int)>] = [wrap(matchable: playerId) { $0.0 }, wrap(matchable: health) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockGameDatabaseProtocol.self, method: "playerSetHealth(_: String, _: Int)", parameterMatchers: matchers))
	    }
	    
	    func playerAddHand<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(_ playerId: M1, _ card: M2) -> Cuckoo.ProtocolStubNoReturnFunction<(String, CardProtocol)> where M1.MatchedType == String, M2.MatchedType == CardProtocol {
	        let matchers: [Cuckoo.ParameterMatcher<(String, CardProtocol)>] = [wrap(matchable: playerId) { $0.0 }, wrap(matchable: card) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockGameDatabaseProtocol.self, method: "playerAddHand(_: String, _: CardProtocol)", parameterMatchers: matchers))
	    }
	    
	    func playerRemoveHand<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(_ playerId: M1, _ cardId: M2) -> Cuckoo.ProtocolStubFunction<(String, String), CardProtocol?> where M1.MatchedType == String, M2.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String, String)>] = [wrap(matchable: playerId) { $0.0 }, wrap(matchable: cardId) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockGameDatabaseProtocol.self, method: "playerRemoveHand(_: String, _: String) -> CardProtocol?", parameterMatchers: matchers))
	    }
	    
	    func playerAddInPlay<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(_ playerId: M1, _ card: M2) -> Cuckoo.ProtocolStubNoReturnFunction<(String, CardProtocol)> where M1.MatchedType == String, M2.MatchedType == CardProtocol {
	        let matchers: [Cuckoo.ParameterMatcher<(String, CardProtocol)>] = [wrap(matchable: playerId) { $0.0 }, wrap(matchable: card) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockGameDatabaseProtocol.self, method: "playerAddInPlay(_: String, _: CardProtocol)", parameterMatchers: matchers))
	    }
	    
	    func playerRemoveInPlay<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(_ playerId: M1, _ cardId: M2) -> Cuckoo.ProtocolStubFunction<(String, String), CardProtocol?> where M1.MatchedType == String, M2.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String, String)>] = [wrap(matchable: playerId) { $0.0 }, wrap(matchable: cardId) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockGameDatabaseProtocol.self, method: "playerRemoveInPlay(_: String, _: String) -> CardProtocol?", parameterMatchers: matchers))
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
	    func setBarrelsResolved<M1: Cuckoo.Matchable>(_ barrelsResolved: M1) -> Cuckoo.__DoNotUse<(Int), Void> where M1.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(Int)>] = [wrap(matchable: barrelsResolved) { $0 }]
	        return cuckoo_manager.verify("setBarrelsResolved(_: Int)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func addExecutedMove<M1: Cuckoo.Matchable>(_ move: M1) -> Cuckoo.__DoNotUse<(GameMove), Void> where M1.MatchedType == GameMove {
	        let matchers: [Cuckoo.ParameterMatcher<(GameMove)>] = [wrap(matchable: move) { $0 }]
	        return cuckoo_manager.verify("addExecutedMove(_: GameMove)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func setValidMoves<M1: Cuckoo.Matchable>(_ moves: M1) -> Cuckoo.__DoNotUse<([String: [GameMove]]), Void> where M1.MatchedType == [String: [GameMove]] {
	        let matchers: [Cuckoo.ParameterMatcher<([String: [GameMove]])>] = [wrap(matchable: moves) { $0 }]
	        return cuckoo_manager.verify("setValidMoves(_: [String: [GameMove]])", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func setOutcome<M1: Cuckoo.Matchable>(_ outcome: M1) -> Cuckoo.__DoNotUse<(GameOutcome), Void> where M1.MatchedType == GameOutcome {
	        let matchers: [Cuckoo.ParameterMatcher<(GameOutcome)>] = [wrap(matchable: outcome) { $0 }]
	        return cuckoo_manager.verify("setOutcome(_: GameOutcome)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func removePlayer<M1: Cuckoo.Matchable>(_ playerId: M1) -> Cuckoo.__DoNotUse<(String), PlayerProtocol?> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: playerId) { $0 }]
	        return cuckoo_manager.verify("removePlayer(_: String) -> PlayerProtocol?", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func addEliminated<M1: Cuckoo.Matchable>(_ player: M1) -> Cuckoo.__DoNotUse<(PlayerProtocol), Void> where M1.MatchedType == PlayerProtocol {
	        let matchers: [Cuckoo.ParameterMatcher<(PlayerProtocol)>] = [wrap(matchable: player) { $0 }]
	        return cuckoo_manager.verify("addEliminated(_: PlayerProtocol)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func addDamageEvent<M1: Cuckoo.Matchable>(_ event: M1) -> Cuckoo.__DoNotUse<(DamageEvent), Void> where M1.MatchedType == DamageEvent {
	        let matchers: [Cuckoo.ParameterMatcher<(DamageEvent)>] = [wrap(matchable: event) { $0 }]
	        return cuckoo_manager.verify("addDamageEvent(_: DamageEvent)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
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
	    func addGeneralStore<M1: Cuckoo.Matchable>(_ card: M1) -> Cuckoo.__DoNotUse<(CardProtocol), Void> where M1.MatchedType == CardProtocol {
	        let matchers: [Cuckoo.ParameterMatcher<(CardProtocol)>] = [wrap(matchable: card) { $0 }]
	        return cuckoo_manager.verify("addGeneralStore(_: CardProtocol)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func removeGeneralStore<M1: Cuckoo.Matchable>(_ cardId: M1) -> Cuckoo.__DoNotUse<(String), CardProtocol?> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: cardId) { $0 }]
	        return cuckoo_manager.verify("removeGeneralStore(_: String) -> CardProtocol?", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func playerSetHealth<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(_ playerId: M1, _ health: M2) -> Cuckoo.__DoNotUse<(String, Int), Void> where M1.MatchedType == String, M2.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(String, Int)>] = [wrap(matchable: playerId) { $0.0 }, wrap(matchable: health) { $0.1 }]
	        return cuckoo_manager.verify("playerSetHealth(_: String, _: Int)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func playerAddHand<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(_ playerId: M1, _ card: M2) -> Cuckoo.__DoNotUse<(String, CardProtocol), Void> where M1.MatchedType == String, M2.MatchedType == CardProtocol {
	        let matchers: [Cuckoo.ParameterMatcher<(String, CardProtocol)>] = [wrap(matchable: playerId) { $0.0 }, wrap(matchable: card) { $0.1 }]
	        return cuckoo_manager.verify("playerAddHand(_: String, _: CardProtocol)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func playerRemoveHand<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(_ playerId: M1, _ cardId: M2) -> Cuckoo.__DoNotUse<(String, String), CardProtocol?> where M1.MatchedType == String, M2.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String, String)>] = [wrap(matchable: playerId) { $0.0 }, wrap(matchable: cardId) { $0.1 }]
	        return cuckoo_manager.verify("playerRemoveHand(_: String, _: String) -> CardProtocol?", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func playerAddInPlay<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(_ playerId: M1, _ card: M2) -> Cuckoo.__DoNotUse<(String, CardProtocol), Void> where M1.MatchedType == String, M2.MatchedType == CardProtocol {
	        let matchers: [Cuckoo.ParameterMatcher<(String, CardProtocol)>] = [wrap(matchable: playerId) { $0.0 }, wrap(matchable: card) { $0.1 }]
	        return cuckoo_manager.verify("playerAddInPlay(_: String, _: CardProtocol)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func playerRemoveInPlay<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(_ playerId: M1, _ cardId: M2) -> Cuckoo.__DoNotUse<(String, String), CardProtocol?> where M1.MatchedType == String, M2.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String, String)>] = [wrap(matchable: playerId) { $0.0 }, wrap(matchable: cardId) { $0.1 }]
	        return cuckoo_manager.verify("playerRemoveInPlay(_: String, _: String) -> CardProtocol?", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class GameDatabaseProtocolStub: GameDatabaseProtocol {
    
    
     var state: GameStateProtocol {
        get {
            return DefaultValueRegistry.defaultValue(for: (GameStateProtocol).self)
        }
        
    }
    

    

    
     func setTurn(_ turn: String)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func setChallenge(_ challenge: Challenge?)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func setBangsPlayed(_ bangsPlayed: Int)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func setBarrelsResolved(_ barrelsResolved: Int)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func addExecutedMove(_ move: GameMove)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func setValidMoves(_ moves: [String: [GameMove]])   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func setOutcome(_ outcome: GameOutcome)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func removePlayer(_ playerId: String) -> PlayerProtocol?  {
        return DefaultValueRegistry.defaultValue(for: (PlayerProtocol?).self)
    }
    
     func addEliminated(_ player: PlayerProtocol)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func addDamageEvent(_ event: DamageEvent)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func deckRemoveFirst() -> CardProtocol  {
        return DefaultValueRegistry.defaultValue(for: (CardProtocol).self)
    }
    
     func addDiscard(_ card: CardProtocol)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func addGeneralStore(_ card: CardProtocol)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func removeGeneralStore(_ cardId: String) -> CardProtocol?  {
        return DefaultValueRegistry.defaultValue(for: (CardProtocol?).self)
    }
    
     func playerSetHealth(_ playerId: String, _ health: Int)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func playerAddHand(_ playerId: String, _ card: CardProtocol)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func playerRemoveHand(_ playerId: String, _ cardId: String) -> CardProtocol?  {
        return DefaultValueRegistry.defaultValue(for: (CardProtocol?).self)
    }
    
     func playerAddInPlay(_ playerId: String, _ card: CardProtocol)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func playerRemoveInPlay(_ playerId: String, _ cardId: String) -> CardProtocol?  {
        return DefaultValueRegistry.defaultValue(for: (CardProtocol?).self)
    }
    
}


import Cuckoo
@testable import WildWest


 class MockValidMoveMatcherProtocol: ValidMoveMatcherProtocol, Cuckoo.ProtocolMock {
    
     typealias MocksType = ValidMoveMatcherProtocol
    
     typealias Stubbing = __StubbingProxy_ValidMoveMatcherProtocol
     typealias Verification = __VerificationProxy_ValidMoveMatcherProtocol

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: ValidMoveMatcherProtocol?

     func enableDefaultImplementation(_ stub: ValidMoveMatcherProtocol) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
     func validMoves(matching state: GameStateProtocol) -> [GameMove]? {
        
    return cuckoo_manager.call("validMoves(matching: GameStateProtocol) -> [GameMove]?",
            parameters: (state),
            escapingParameters: (state),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.validMoves(matching: state))
        
    }
    

	 struct __StubbingProxy_ValidMoveMatcherProtocol: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func validMoves<M1: Cuckoo.Matchable>(matching state: M1) -> Cuckoo.ProtocolStubFunction<(GameStateProtocol), [GameMove]?> where M1.MatchedType == GameStateProtocol {
	        let matchers: [Cuckoo.ParameterMatcher<(GameStateProtocol)>] = [wrap(matchable: state) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockValidMoveMatcherProtocol.self, method: "validMoves(matching: GameStateProtocol) -> [GameMove]?", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_ValidMoveMatcherProtocol: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func validMoves<M1: Cuckoo.Matchable>(matching state: M1) -> Cuckoo.__DoNotUse<(GameStateProtocol), [GameMove]?> where M1.MatchedType == GameStateProtocol {
	        let matchers: [Cuckoo.ParameterMatcher<(GameStateProtocol)>] = [wrap(matchable: state) { $0 }]
	        return cuckoo_manager.verify("validMoves(matching: GameStateProtocol) -> [GameMove]?", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class ValidMoveMatcherProtocolStub: ValidMoveMatcherProtocol {
    

    

    
     func validMoves(matching state: GameStateProtocol) -> [GameMove]?  {
        return DefaultValueRegistry.defaultValue(for: ([GameMove]?).self)
    }
    
}



 class MockAutoplayMoveMatcherProtocol: AutoplayMoveMatcherProtocol, Cuckoo.ProtocolMock {
    
     typealias MocksType = AutoplayMoveMatcherProtocol
    
     typealias Stubbing = __StubbingProxy_AutoplayMoveMatcherProtocol
     typealias Verification = __VerificationProxy_AutoplayMoveMatcherProtocol

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: AutoplayMoveMatcherProtocol?

     func enableDefaultImplementation(_ stub: AutoplayMoveMatcherProtocol) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
     func autoPlayMoves(matching state: GameStateProtocol) -> [GameMove]? {
        
    return cuckoo_manager.call("autoPlayMoves(matching: GameStateProtocol) -> [GameMove]?",
            parameters: (state),
            escapingParameters: (state),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.autoPlayMoves(matching: state))
        
    }
    

	 struct __StubbingProxy_AutoplayMoveMatcherProtocol: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func autoPlayMoves<M1: Cuckoo.Matchable>(matching state: M1) -> Cuckoo.ProtocolStubFunction<(GameStateProtocol), [GameMove]?> where M1.MatchedType == GameStateProtocol {
	        let matchers: [Cuckoo.ParameterMatcher<(GameStateProtocol)>] = [wrap(matchable: state) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockAutoplayMoveMatcherProtocol.self, method: "autoPlayMoves(matching: GameStateProtocol) -> [GameMove]?", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_AutoplayMoveMatcherProtocol: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func autoPlayMoves<M1: Cuckoo.Matchable>(matching state: M1) -> Cuckoo.__DoNotUse<(GameStateProtocol), [GameMove]?> where M1.MatchedType == GameStateProtocol {
	        let matchers: [Cuckoo.ParameterMatcher<(GameStateProtocol)>] = [wrap(matchable: state) { $0 }]
	        return cuckoo_manager.verify("autoPlayMoves(matching: GameStateProtocol) -> [GameMove]?", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class AutoplayMoveMatcherProtocolStub: AutoplayMoveMatcherProtocol {
    

    

    
     func autoPlayMoves(matching state: GameStateProtocol) -> [GameMove]?  {
        return DefaultValueRegistry.defaultValue(for: ([GameMove]?).self)
    }
    
}



 class MockEffectMatcherProtocol: EffectMatcherProtocol, Cuckoo.ProtocolMock {
    
     typealias MocksType = EffectMatcherProtocol
    
     typealias Stubbing = __StubbingProxy_EffectMatcherProtocol
     typealias Verification = __VerificationProxy_EffectMatcherProtocol

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: EffectMatcherProtocol?

     func enableDefaultImplementation(_ stub: EffectMatcherProtocol) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
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
    

	 struct __StubbingProxy_EffectMatcherProtocol: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func effect<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(onExecuting move: M1, in state: M2) -> Cuckoo.ProtocolStubFunction<(GameMove, GameStateProtocol), GameMove?> where M1.MatchedType == GameMove, M2.MatchedType == GameStateProtocol {
	        let matchers: [Cuckoo.ParameterMatcher<(GameMove, GameStateProtocol)>] = [wrap(matchable: move) { $0.0 }, wrap(matchable: state) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockEffectMatcherProtocol.self, method: "effect(onExecuting: GameMove, in: GameStateProtocol) -> GameMove?", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_EffectMatcherProtocol: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func effect<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(onExecuting move: M1, in state: M2) -> Cuckoo.__DoNotUse<(GameMove, GameStateProtocol), GameMove?> where M1.MatchedType == GameMove, M2.MatchedType == GameStateProtocol {
	        let matchers: [Cuckoo.ParameterMatcher<(GameMove, GameStateProtocol)>] = [wrap(matchable: move) { $0.0 }, wrap(matchable: state) { $0.1 }]
	        return cuckoo_manager.verify("effect(onExecuting: GameMove, in: GameStateProtocol) -> GameMove?", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class EffectMatcherProtocolStub: EffectMatcherProtocol {
    

    

    
     func effect(onExecuting move: GameMove, in state: GameStateProtocol) -> GameMove?  {
        return DefaultValueRegistry.defaultValue(for: (GameMove?).self)
    }
    
}



 class MockMoveExecutorProtocol: MoveExecutorProtocol, Cuckoo.ProtocolMock {
    
     typealias MocksType = MoveExecutorProtocol
    
     typealias Stubbing = __StubbingProxy_MoveExecutorProtocol
     typealias Verification = __VerificationProxy_MoveExecutorProtocol

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: MoveExecutorProtocol?

     func enableDefaultImplementation(_ stub: MoveExecutorProtocol) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
     func execute(_ move: GameMove, in state: GameStateProtocol) -> [GameUpdate]? {
        
    return cuckoo_manager.call("execute(_: GameMove, in: GameStateProtocol) -> [GameUpdate]?",
            parameters: (move, state),
            escapingParameters: (move, state),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.execute(move, in: state))
        
    }
    

	 struct __StubbingProxy_MoveExecutorProtocol: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func execute<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(_ move: M1, in state: M2) -> Cuckoo.ProtocolStubFunction<(GameMove, GameStateProtocol), [GameUpdate]?> where M1.MatchedType == GameMove, M2.MatchedType == GameStateProtocol {
	        let matchers: [Cuckoo.ParameterMatcher<(GameMove, GameStateProtocol)>] = [wrap(matchable: move) { $0.0 }, wrap(matchable: state) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockMoveExecutorProtocol.self, method: "execute(_: GameMove, in: GameStateProtocol) -> [GameUpdate]?", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_MoveExecutorProtocol: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func execute<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(_ move: M1, in state: M2) -> Cuckoo.__DoNotUse<(GameMove, GameStateProtocol), [GameUpdate]?> where M1.MatchedType == GameMove, M2.MatchedType == GameStateProtocol {
	        let matchers: [Cuckoo.ParameterMatcher<(GameMove, GameStateProtocol)>] = [wrap(matchable: move) { $0.0 }, wrap(matchable: state) { $0.1 }]
	        return cuckoo_manager.verify("execute(_: GameMove, in: GameStateProtocol) -> [GameUpdate]?", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class MoveExecutorProtocolStub: MoveExecutorProtocol {
    

    

    
     func execute(_ move: GameMove, in state: GameStateProtocol) -> [GameUpdate]?  {
        return DefaultValueRegistry.defaultValue(for: ([GameUpdate]?).self)
    }
    
}


import Cuckoo
@testable import WildWest


 class MockOutcomeCalculatorProtocol: OutcomeCalculatorProtocol, Cuckoo.ProtocolMock {
    
     typealias MocksType = OutcomeCalculatorProtocol
    
     typealias Stubbing = __StubbingProxy_OutcomeCalculatorProtocol
     typealias Verification = __VerificationProxy_OutcomeCalculatorProtocol

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: OutcomeCalculatorProtocol?

     func enableDefaultImplementation(_ stub: OutcomeCalculatorProtocol) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
     func outcome(for remainingRoles: [Role]) -> GameOutcome? {
        
    return cuckoo_manager.call("outcome(for: [Role]) -> GameOutcome?",
            parameters: (remainingRoles),
            escapingParameters: (remainingRoles),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.outcome(for: remainingRoles))
        
    }
    

	 struct __StubbingProxy_OutcomeCalculatorProtocol: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func outcome<M1: Cuckoo.Matchable>(for remainingRoles: M1) -> Cuckoo.ProtocolStubFunction<([Role]), GameOutcome?> where M1.MatchedType == [Role] {
	        let matchers: [Cuckoo.ParameterMatcher<([Role])>] = [wrap(matchable: remainingRoles) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockOutcomeCalculatorProtocol.self, method: "outcome(for: [Role]) -> GameOutcome?", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_OutcomeCalculatorProtocol: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func outcome<M1: Cuckoo.Matchable>(for remainingRoles: M1) -> Cuckoo.__DoNotUse<([Role]), GameOutcome?> where M1.MatchedType == [Role] {
	        let matchers: [Cuckoo.ParameterMatcher<([Role])>] = [wrap(matchable: remainingRoles) { $0 }]
	        return cuckoo_manager.verify("outcome(for: [Role]) -> GameOutcome?", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class OutcomeCalculatorProtocolStub: OutcomeCalculatorProtocol {
    

    

    
     func outcome(for remainingRoles: [Role]) -> GameOutcome?  {
        return DefaultValueRegistry.defaultValue(for: (GameOutcome?).self)
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
    
    
    
     var discardPile: [CardProtocol] {
        get {
            return cuckoo_manager.getter("discardPile",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.discardPile)
        }
        
    }
    
    
    
     var turn: String? {
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
    
    
    
     var barrelsResolved: Int {
        get {
            return cuckoo_manager.getter("barrelsResolved",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.barrelsResolved)
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
    
    
    
     var eliminated: [PlayerProtocol] {
        get {
            return cuckoo_manager.getter("eliminated",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.eliminated)
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
    
    
    
     var validMoves: [String: [GameMove]] {
        get {
            return cuckoo_manager.getter("validMoves",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.validMoves)
        }
        
    }
    
    
    
     var executedMoves: [GameMove] {
        get {
            return cuckoo_manager.getter("executedMoves",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.executedMoves)
        }
        
    }
    
    
    
     var damageEvents: [DamageEvent] {
        get {
            return cuckoo_manager.getter("damageEvents",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.damageEvents)
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
	    
	    
	    var discardPile: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockGameStateProtocol, [CardProtocol]> {
	        return .init(manager: cuckoo_manager, name: "discardPile")
	    }
	    
	    
	    var turn: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockGameStateProtocol, String?> {
	        return .init(manager: cuckoo_manager, name: "turn")
	    }
	    
	    
	    var challenge: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockGameStateProtocol, Challenge?> {
	        return .init(manager: cuckoo_manager, name: "challenge")
	    }
	    
	    
	    var bangsPlayed: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockGameStateProtocol, Int> {
	        return .init(manager: cuckoo_manager, name: "bangsPlayed")
	    }
	    
	    
	    var barrelsResolved: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockGameStateProtocol, Int> {
	        return .init(manager: cuckoo_manager, name: "barrelsResolved")
	    }
	    
	    
	    var generalStore: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockGameStateProtocol, [CardProtocol]> {
	        return .init(manager: cuckoo_manager, name: "generalStore")
	    }
	    
	    
	    var eliminated: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockGameStateProtocol, [PlayerProtocol]> {
	        return .init(manager: cuckoo_manager, name: "eliminated")
	    }
	    
	    
	    var outcome: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockGameStateProtocol, GameOutcome?> {
	        return .init(manager: cuckoo_manager, name: "outcome")
	    }
	    
	    
	    var validMoves: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockGameStateProtocol, [String: [GameMove]]> {
	        return .init(manager: cuckoo_manager, name: "validMoves")
	    }
	    
	    
	    var executedMoves: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockGameStateProtocol, [GameMove]> {
	        return .init(manager: cuckoo_manager, name: "executedMoves")
	    }
	    
	    
	    var damageEvents: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockGameStateProtocol, [DamageEvent]> {
	        return .init(manager: cuckoo_manager, name: "damageEvents")
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
	    
	    
	    var discardPile: Cuckoo.VerifyReadOnlyProperty<[CardProtocol]> {
	        return .init(manager: cuckoo_manager, name: "discardPile", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var turn: Cuckoo.VerifyReadOnlyProperty<String?> {
	        return .init(manager: cuckoo_manager, name: "turn", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var challenge: Cuckoo.VerifyReadOnlyProperty<Challenge?> {
	        return .init(manager: cuckoo_manager, name: "challenge", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var bangsPlayed: Cuckoo.VerifyReadOnlyProperty<Int> {
	        return .init(manager: cuckoo_manager, name: "bangsPlayed", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var barrelsResolved: Cuckoo.VerifyReadOnlyProperty<Int> {
	        return .init(manager: cuckoo_manager, name: "barrelsResolved", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var generalStore: Cuckoo.VerifyReadOnlyProperty<[CardProtocol]> {
	        return .init(manager: cuckoo_manager, name: "generalStore", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var eliminated: Cuckoo.VerifyReadOnlyProperty<[PlayerProtocol]> {
	        return .init(manager: cuckoo_manager, name: "eliminated", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var outcome: Cuckoo.VerifyReadOnlyProperty<GameOutcome?> {
	        return .init(manager: cuckoo_manager, name: "outcome", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var validMoves: Cuckoo.VerifyReadOnlyProperty<[String: [GameMove]]> {
	        return .init(manager: cuckoo_manager, name: "validMoves", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var executedMoves: Cuckoo.VerifyReadOnlyProperty<[GameMove]> {
	        return .init(manager: cuckoo_manager, name: "executedMoves", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var damageEvents: Cuckoo.VerifyReadOnlyProperty<[DamageEvent]> {
	        return .init(manager: cuckoo_manager, name: "damageEvents", callMatcher: callMatcher, sourceLocation: sourceLocation)
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
    
    
     var discardPile: [CardProtocol] {
        get {
            return DefaultValueRegistry.defaultValue(for: ([CardProtocol]).self)
        }
        
    }
    
    
     var turn: String? {
        get {
            return DefaultValueRegistry.defaultValue(for: (String?).self)
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
    
    
     var barrelsResolved: Int {
        get {
            return DefaultValueRegistry.defaultValue(for: (Int).self)
        }
        
    }
    
    
     var generalStore: [CardProtocol] {
        get {
            return DefaultValueRegistry.defaultValue(for: ([CardProtocol]).self)
        }
        
    }
    
    
     var eliminated: [PlayerProtocol] {
        get {
            return DefaultValueRegistry.defaultValue(for: ([PlayerProtocol]).self)
        }
        
    }
    
    
     var outcome: GameOutcome? {
        get {
            return DefaultValueRegistry.defaultValue(for: (GameOutcome?).self)
        }
        
    }
    
    
     var validMoves: [String: [GameMove]] {
        get {
            return DefaultValueRegistry.defaultValue(for: ([String: [GameMove]]).self)
        }
        
    }
    
    
     var executedMoves: [GameMove] {
        get {
            return DefaultValueRegistry.defaultValue(for: ([GameMove]).self)
        }
        
    }
    
    
     var damageEvents: [DamageEvent] {
        get {
            return DefaultValueRegistry.defaultValue(for: ([DamageEvent]).self)
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


import Cuckoo
@testable import WildWest


 class MockUpdateExecutorProtocol: UpdateExecutorProtocol, Cuckoo.ProtocolMock {
    
     typealias MocksType = UpdateExecutorProtocol
    
     typealias Stubbing = __StubbingProxy_UpdateExecutorProtocol
     typealias Verification = __VerificationProxy_UpdateExecutorProtocol

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: UpdateExecutorProtocol?

     func enableDefaultImplementation(_ stub: UpdateExecutorProtocol) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
     func execute(_ update: GameUpdate, in database: GameDatabaseProtocol)  {
        
    return cuckoo_manager.call("execute(_: GameUpdate, in: GameDatabaseProtocol)",
            parameters: (update, database),
            escapingParameters: (update, database),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.execute(update, in: database))
        
    }
    

	 struct __StubbingProxy_UpdateExecutorProtocol: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func execute<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(_ update: M1, in database: M2) -> Cuckoo.ProtocolStubNoReturnFunction<(GameUpdate, GameDatabaseProtocol)> where M1.MatchedType == GameUpdate, M2.MatchedType == GameDatabaseProtocol {
	        let matchers: [Cuckoo.ParameterMatcher<(GameUpdate, GameDatabaseProtocol)>] = [wrap(matchable: update) { $0.0 }, wrap(matchable: database) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockUpdateExecutorProtocol.self, method: "execute(_: GameUpdate, in: GameDatabaseProtocol)", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_UpdateExecutorProtocol: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func execute<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(_ update: M1, in database: M2) -> Cuckoo.__DoNotUse<(GameUpdate, GameDatabaseProtocol), Void> where M1.MatchedType == GameUpdate, M2.MatchedType == GameDatabaseProtocol {
	        let matchers: [Cuckoo.ParameterMatcher<(GameUpdate, GameDatabaseProtocol)>] = [wrap(matchable: update) { $0.0 }, wrap(matchable: database) { $0.1 }]
	        return cuckoo_manager.verify("execute(_: GameUpdate, in: GameDatabaseProtocol)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class UpdateExecutorProtocolStub: UpdateExecutorProtocol {
    

    

    
     func execute(_ update: GameUpdate, in database: GameDatabaseProtocol)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
}

