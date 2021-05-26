import Cuckoo
@testable import WildWestEngine


public class MockAIProtocol: AIProtocol, Cuckoo.ProtocolMock {
    
    public typealias MocksType = AIProtocol
    
    public typealias Stubbing = __StubbingProxy_AIProtocol
    public typealias Verification = __VerificationProxy_AIProtocol

    public let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: AIProtocol?

    public func enableDefaultImplementation(_ stub: AIProtocol) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
    public func bestMove(among moves: [GMove], in state: StateProtocol) -> GMove {
        
    return cuckoo_manager.call("bestMove(among: [GMove], in: StateProtocol) -> GMove",
            parameters: (moves, state),
            escapingParameters: (moves, state),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.bestMove(among: moves, in: state))
        
    }
    

	public struct __StubbingProxy_AIProtocol: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	    public init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func bestMove<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(among moves: M1, in state: M2) -> Cuckoo.ProtocolStubFunction<([GMove], StateProtocol), GMove> where M1.MatchedType == [GMove], M2.MatchedType == StateProtocol {
	        let matchers: [Cuckoo.ParameterMatcher<([GMove], StateProtocol)>] = [wrap(matchable: moves) { $0.0 }, wrap(matchable: state) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockAIProtocol.self, method: "bestMove(among: [GMove], in: StateProtocol) -> GMove", parameterMatchers: matchers))
	    }
	    
	}

	public struct __VerificationProxy_AIProtocol: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	    public init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func bestMove<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(among moves: M1, in state: M2) -> Cuckoo.__DoNotUse<([GMove], StateProtocol), GMove> where M1.MatchedType == [GMove], M2.MatchedType == StateProtocol {
	        let matchers: [Cuckoo.ParameterMatcher<([GMove], StateProtocol)>] = [wrap(matchable: moves) { $0.0 }, wrap(matchable: state) { $0.1 }]
	        return cuckoo_manager.verify("bestMove(among: [GMove], in: StateProtocol) -> GMove", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

public class AIProtocolStub: AIProtocol {
    

    

    
    public func bestMove(among moves: [GMove], in state: StateProtocol) -> GMove  {
        return DefaultValueRegistry.defaultValue(for: (GMove).self)
    }
    
}


import Cuckoo
@testable import WildWestEngine

import RxSwift


public class MockAIAgentProtocol: AIAgentProtocol, Cuckoo.ProtocolMock {
    
    public typealias MocksType = AIAgentProtocol
    
    public typealias Stubbing = __StubbingProxy_AIAgentProtocol
    public typealias Verification = __VerificationProxy_AIAgentProtocol

    public let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: AIAgentProtocol?

    public func enableDefaultImplementation(_ stub: AIAgentProtocol) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
    public func observe(_ database: RestrictedDatabaseProtocol)  {
        
    return cuckoo_manager.call("observe(_: RestrictedDatabaseProtocol)",
            parameters: (database),
            escapingParameters: (database),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.observe(database))
        
    }
    

	public struct __StubbingProxy_AIAgentProtocol: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	    public init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func observe<M1: Cuckoo.Matchable>(_ database: M1) -> Cuckoo.ProtocolStubNoReturnFunction<(RestrictedDatabaseProtocol)> where M1.MatchedType == RestrictedDatabaseProtocol {
	        let matchers: [Cuckoo.ParameterMatcher<(RestrictedDatabaseProtocol)>] = [wrap(matchable: database) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockAIAgentProtocol.self, method: "observe(_: RestrictedDatabaseProtocol)", parameterMatchers: matchers))
	    }
	    
	}

	public struct __VerificationProxy_AIAgentProtocol: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	    public init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func observe<M1: Cuckoo.Matchable>(_ database: M1) -> Cuckoo.__DoNotUse<(RestrictedDatabaseProtocol), Void> where M1.MatchedType == RestrictedDatabaseProtocol {
	        let matchers: [Cuckoo.ParameterMatcher<(RestrictedDatabaseProtocol)>] = [wrap(matchable: database) { $0 }]
	        return cuckoo_manager.verify("observe(_: RestrictedDatabaseProtocol)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

public class AIAgentProtocolStub: AIAgentProtocol {
    

    

    
    public func observe(_ database: RestrictedDatabaseProtocol)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
}


import Cuckoo
@testable import WildWestEngine


public class MockAbilityEvaluatorProtocol: AbilityEvaluatorProtocol, Cuckoo.ProtocolMock {
    
    public typealias MocksType = AbilityEvaluatorProtocol
    
    public typealias Stubbing = __StubbingProxy_AbilityEvaluatorProtocol
    public typealias Verification = __VerificationProxy_AbilityEvaluatorProtocol

    public let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: AbilityEvaluatorProtocol?

    public func enableDefaultImplementation(_ stub: AbilityEvaluatorProtocol) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
    public func evaluate(_ move: GMove) -> Int {
        
    return cuckoo_manager.call("evaluate(_: GMove) -> Int",
            parameters: (move),
            escapingParameters: (move),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.evaluate(move))
        
    }
    

	public struct __StubbingProxy_AbilityEvaluatorProtocol: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	    public init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func evaluate<M1: Cuckoo.Matchable>(_ move: M1) -> Cuckoo.ProtocolStubFunction<(GMove), Int> where M1.MatchedType == GMove {
	        let matchers: [Cuckoo.ParameterMatcher<(GMove)>] = [wrap(matchable: move) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockAbilityEvaluatorProtocol.self, method: "evaluate(_: GMove) -> Int", parameterMatchers: matchers))
	    }
	    
	}

	public struct __VerificationProxy_AbilityEvaluatorProtocol: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	    public init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func evaluate<M1: Cuckoo.Matchable>(_ move: M1) -> Cuckoo.__DoNotUse<(GMove), Int> where M1.MatchedType == GMove {
	        let matchers: [Cuckoo.ParameterMatcher<(GMove)>] = [wrap(matchable: move) { $0 }]
	        return cuckoo_manager.verify("evaluate(_: GMove) -> Int", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

public class AbilityEvaluatorProtocolStub: AbilityEvaluatorProtocol {
    

    

    
    public func evaluate(_ move: GMove) -> Int  {
        return DefaultValueRegistry.defaultValue(for: (Int).self)
    }
    
}


import Cuckoo
@testable import WildWestEngine


public class MockMoveEvaluatorProtocol: MoveEvaluatorProtocol, Cuckoo.ProtocolMock {
    
    public typealias MocksType = MoveEvaluatorProtocol
    
    public typealias Stubbing = __StubbingProxy_MoveEvaluatorProtocol
    public typealias Verification = __VerificationProxy_MoveEvaluatorProtocol

    public let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: MoveEvaluatorProtocol?

    public func enableDefaultImplementation(_ stub: MoveEvaluatorProtocol) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
    public func evaluate(_ move: GMove, in state: StateProtocol) -> Int {
        
    return cuckoo_manager.call("evaluate(_: GMove, in: StateProtocol) -> Int",
            parameters: (move, state),
            escapingParameters: (move, state),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.evaluate(move, in: state))
        
    }
    

	public struct __StubbingProxy_MoveEvaluatorProtocol: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	    public init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func evaluate<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(_ move: M1, in state: M2) -> Cuckoo.ProtocolStubFunction<(GMove, StateProtocol), Int> where M1.MatchedType == GMove, M2.MatchedType == StateProtocol {
	        let matchers: [Cuckoo.ParameterMatcher<(GMove, StateProtocol)>] = [wrap(matchable: move) { $0.0 }, wrap(matchable: state) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockMoveEvaluatorProtocol.self, method: "evaluate(_: GMove, in: StateProtocol) -> Int", parameterMatchers: matchers))
	    }
	    
	}

	public struct __VerificationProxy_MoveEvaluatorProtocol: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	    public init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func evaluate<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(_ move: M1, in state: M2) -> Cuckoo.__DoNotUse<(GMove, StateProtocol), Int> where M1.MatchedType == GMove, M2.MatchedType == StateProtocol {
	        let matchers: [Cuckoo.ParameterMatcher<(GMove, StateProtocol)>] = [wrap(matchable: move) { $0.0 }, wrap(matchable: state) { $0.1 }]
	        return cuckoo_manager.verify("evaluate(_: GMove, in: StateProtocol) -> Int", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

public class MoveEvaluatorProtocolStub: MoveEvaluatorProtocol {
    

    

    
    public func evaluate(_ move: GMove, in state: StateProtocol) -> Int  {
        return DefaultValueRegistry.defaultValue(for: (Int).self)
    }
    
}


import Cuckoo
@testable import WildWestEngine


public class MockRoleEstimatorProtocol: RoleEstimatorProtocol, Cuckoo.ProtocolMock {
    
    public typealias MocksType = RoleEstimatorProtocol
    
    public typealias Stubbing = __StubbingProxy_RoleEstimatorProtocol
    public typealias Verification = __VerificationProxy_RoleEstimatorProtocol

    public let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: RoleEstimatorProtocol?

    public func enableDefaultImplementation(_ stub: RoleEstimatorProtocol) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
    public func score(for player: String) -> Int {
        
    return cuckoo_manager.call("score(for: String) -> Int",
            parameters: (player),
            escapingParameters: (player),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.score(for: player))
        
    }
    
    
    
    public func estimatedRole(for player: String) -> Role? {
        
    return cuckoo_manager.call("estimatedRole(for: String) -> Role?",
            parameters: (player),
            escapingParameters: (player),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.estimatedRole(for: player))
        
    }
    
    
    
    public func update(on move: GMove)  {
        
    return cuckoo_manager.call("update(on: GMove)",
            parameters: (move),
            escapingParameters: (move),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.update(on: move))
        
    }
    

	public struct __StubbingProxy_RoleEstimatorProtocol: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	    public init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func score<M1: Cuckoo.Matchable>(for player: M1) -> Cuckoo.ProtocolStubFunction<(String), Int> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: player) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockRoleEstimatorProtocol.self, method: "score(for: String) -> Int", parameterMatchers: matchers))
	    }
	    
	    func estimatedRole<M1: Cuckoo.Matchable>(for player: M1) -> Cuckoo.ProtocolStubFunction<(String), Role?> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: player) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockRoleEstimatorProtocol.self, method: "estimatedRole(for: String) -> Role?", parameterMatchers: matchers))
	    }
	    
	    func update<M1: Cuckoo.Matchable>(on move: M1) -> Cuckoo.ProtocolStubNoReturnFunction<(GMove)> where M1.MatchedType == GMove {
	        let matchers: [Cuckoo.ParameterMatcher<(GMove)>] = [wrap(matchable: move) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockRoleEstimatorProtocol.self, method: "update(on: GMove)", parameterMatchers: matchers))
	    }
	    
	}

	public struct __VerificationProxy_RoleEstimatorProtocol: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	    public init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func score<M1: Cuckoo.Matchable>(for player: M1) -> Cuckoo.__DoNotUse<(String), Int> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: player) { $0 }]
	        return cuckoo_manager.verify("score(for: String) -> Int", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func estimatedRole<M1: Cuckoo.Matchable>(for player: M1) -> Cuckoo.__DoNotUse<(String), Role?> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: player) { $0 }]
	        return cuckoo_manager.verify("estimatedRole(for: String) -> Role?", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func update<M1: Cuckoo.Matchable>(on move: M1) -> Cuckoo.__DoNotUse<(GMove), Void> where M1.MatchedType == GMove {
	        let matchers: [Cuckoo.ParameterMatcher<(GMove)>] = [wrap(matchable: move) { $0 }]
	        return cuckoo_manager.verify("update(on: GMove)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

public class RoleEstimatorProtocolStub: RoleEstimatorProtocol {
    

    

    
    public func score(for player: String) -> Int  {
        return DefaultValueRegistry.defaultValue(for: (Int).self)
    }
    
    public func estimatedRole(for player: String) -> Role?  {
        return DefaultValueRegistry.defaultValue(for: (Role?).self)
    }
    
    public func update(on move: GMove)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
}


import Cuckoo
@testable import WildWestEngine


public class MockRoleStrategyProtocol: RoleStrategyProtocol, Cuckoo.ProtocolMock {
    
    public typealias MocksType = RoleStrategyProtocol
    
    public typealias Stubbing = __StubbingProxy_RoleStrategyProtocol
    public typealias Verification = __VerificationProxy_RoleStrategyProtocol

    public let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: RoleStrategyProtocol?

    public func enableDefaultImplementation(_ stub: RoleStrategyProtocol) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
    public func relationship(of role: Role, to otherRole: Role, in state: StateProtocol) -> Int {
        
    return cuckoo_manager.call("relationship(of: Role, to: Role, in: StateProtocol) -> Int",
            parameters: (role, otherRole, state),
            escapingParameters: (role, otherRole, state),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.relationship(of: role, to: otherRole, in: state))
        
    }
    

	public struct __StubbingProxy_RoleStrategyProtocol: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	    public init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func relationship<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable>(of role: M1, to otherRole: M2, in state: M3) -> Cuckoo.ProtocolStubFunction<(Role, Role, StateProtocol), Int> where M1.MatchedType == Role, M2.MatchedType == Role, M3.MatchedType == StateProtocol {
	        let matchers: [Cuckoo.ParameterMatcher<(Role, Role, StateProtocol)>] = [wrap(matchable: role) { $0.0 }, wrap(matchable: otherRole) { $0.1 }, wrap(matchable: state) { $0.2 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockRoleStrategyProtocol.self, method: "relationship(of: Role, to: Role, in: StateProtocol) -> Int", parameterMatchers: matchers))
	    }
	    
	}

	public struct __VerificationProxy_RoleStrategyProtocol: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	    public init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func relationship<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable>(of role: M1, to otherRole: M2, in state: M3) -> Cuckoo.__DoNotUse<(Role, Role, StateProtocol), Int> where M1.MatchedType == Role, M2.MatchedType == Role, M3.MatchedType == StateProtocol {
	        let matchers: [Cuckoo.ParameterMatcher<(Role, Role, StateProtocol)>] = [wrap(matchable: role) { $0.0 }, wrap(matchable: otherRole) { $0.1 }, wrap(matchable: state) { $0.2 }]
	        return cuckoo_manager.verify("relationship(of: Role, to: Role, in: StateProtocol) -> Int", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

public class RoleStrategyProtocolStub: RoleStrategyProtocol {
    

    

    
    public func relationship(of role: Role, to otherRole: Role, in state: StateProtocol) -> Int  {
        return DefaultValueRegistry.defaultValue(for: (Int).self)
    }
    
}


import Cuckoo
@testable import WildWestEngine


public class MockStateStoredProtocol: StateStoredProtocol, Cuckoo.ProtocolMock {
    
    public typealias MocksType = StateStoredProtocol
    
    public typealias Stubbing = __StubbingProxy_StateStoredProtocol
    public typealias Verification = __VerificationProxy_StateStoredProtocol

    public let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: StateStoredProtocol?

    public func enableDefaultImplementation(_ stub: StateStoredProtocol) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    
    
    
    public var players: [String: PlayerProtocol] {
        get {
            return cuckoo_manager.getter("players",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.players)
        }
        
    }
    
    
    
    public var initialOrder: [String] {
        get {
            return cuckoo_manager.getter("initialOrder",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.initialOrder)
        }
        
    }
    
    
    
    public var playOrder: [String] {
        get {
            return cuckoo_manager.getter("playOrder",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.playOrder)
        }
        
    }
    
    
    
    public var turn: String {
        get {
            return cuckoo_manager.getter("turn",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.turn)
        }
        
    }
    
    
    
    public var phase: Int {
        get {
            return cuckoo_manager.getter("phase",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.phase)
        }
        
    }
    
    
    
    public var deck: [CardProtocol] {
        get {
            return cuckoo_manager.getter("deck",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.deck)
        }
        
    }
    
    
    
    public var discard: [CardProtocol] {
        get {
            return cuckoo_manager.getter("discard",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.discard)
        }
        
    }
    
    
    
    public var store: [CardProtocol] {
        get {
            return cuckoo_manager.getter("store",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.store)
        }
        
    }
    
    
    
    public var hits: [HitProtocol] {
        get {
            return cuckoo_manager.getter("hits",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.hits)
        }
        
    }
    
    
    
    public var played: [String] {
        get {
            return cuckoo_manager.getter("played",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.played)
        }
        
    }
    

    

    

	public struct __StubbingProxy_StateStoredProtocol: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	    public init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    var players: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockStateStoredProtocol, [String: PlayerProtocol]> {
	        return .init(manager: cuckoo_manager, name: "players")
	    }
	    
	    
	    var initialOrder: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockStateStoredProtocol, [String]> {
	        return .init(manager: cuckoo_manager, name: "initialOrder")
	    }
	    
	    
	    var playOrder: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockStateStoredProtocol, [String]> {
	        return .init(manager: cuckoo_manager, name: "playOrder")
	    }
	    
	    
	    var turn: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockStateStoredProtocol, String> {
	        return .init(manager: cuckoo_manager, name: "turn")
	    }
	    
	    
	    var phase: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockStateStoredProtocol, Int> {
	        return .init(manager: cuckoo_manager, name: "phase")
	    }
	    
	    
	    var deck: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockStateStoredProtocol, [CardProtocol]> {
	        return .init(manager: cuckoo_manager, name: "deck")
	    }
	    
	    
	    var discard: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockStateStoredProtocol, [CardProtocol]> {
	        return .init(manager: cuckoo_manager, name: "discard")
	    }
	    
	    
	    var store: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockStateStoredProtocol, [CardProtocol]> {
	        return .init(manager: cuckoo_manager, name: "store")
	    }
	    
	    
	    var hits: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockStateStoredProtocol, [HitProtocol]> {
	        return .init(manager: cuckoo_manager, name: "hits")
	    }
	    
	    
	    var played: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockStateStoredProtocol, [String]> {
	        return .init(manager: cuckoo_manager, name: "played")
	    }
	    
	    
	}

	public struct __VerificationProxy_StateStoredProtocol: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	    public init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	    
	    var players: Cuckoo.VerifyReadOnlyProperty<[String: PlayerProtocol]> {
	        return .init(manager: cuckoo_manager, name: "players", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var initialOrder: Cuckoo.VerifyReadOnlyProperty<[String]> {
	        return .init(manager: cuckoo_manager, name: "initialOrder", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var playOrder: Cuckoo.VerifyReadOnlyProperty<[String]> {
	        return .init(manager: cuckoo_manager, name: "playOrder", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var turn: Cuckoo.VerifyReadOnlyProperty<String> {
	        return .init(manager: cuckoo_manager, name: "turn", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var phase: Cuckoo.VerifyReadOnlyProperty<Int> {
	        return .init(manager: cuckoo_manager, name: "phase", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var deck: Cuckoo.VerifyReadOnlyProperty<[CardProtocol]> {
	        return .init(manager: cuckoo_manager, name: "deck", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var discard: Cuckoo.VerifyReadOnlyProperty<[CardProtocol]> {
	        return .init(manager: cuckoo_manager, name: "discard", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var store: Cuckoo.VerifyReadOnlyProperty<[CardProtocol]> {
	        return .init(manager: cuckoo_manager, name: "store", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var hits: Cuckoo.VerifyReadOnlyProperty<[HitProtocol]> {
	        return .init(manager: cuckoo_manager, name: "hits", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var played: Cuckoo.VerifyReadOnlyProperty<[String]> {
	        return .init(manager: cuckoo_manager, name: "played", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	
	    
	}
}

public class StateStoredProtocolStub: StateStoredProtocol {
    
    
    public var players: [String: PlayerProtocol] {
        get {
            return DefaultValueRegistry.defaultValue(for: ([String: PlayerProtocol]).self)
        }
        
    }
    
    
    public var initialOrder: [String] {
        get {
            return DefaultValueRegistry.defaultValue(for: ([String]).self)
        }
        
    }
    
    
    public var playOrder: [String] {
        get {
            return DefaultValueRegistry.defaultValue(for: ([String]).self)
        }
        
    }
    
    
    public var turn: String {
        get {
            return DefaultValueRegistry.defaultValue(for: (String).self)
        }
        
    }
    
    
    public var phase: Int {
        get {
            return DefaultValueRegistry.defaultValue(for: (Int).self)
        }
        
    }
    
    
    public var deck: [CardProtocol] {
        get {
            return DefaultValueRegistry.defaultValue(for: ([CardProtocol]).self)
        }
        
    }
    
    
    public var discard: [CardProtocol] {
        get {
            return DefaultValueRegistry.defaultValue(for: ([CardProtocol]).self)
        }
        
    }
    
    
    public var store: [CardProtocol] {
        get {
            return DefaultValueRegistry.defaultValue(for: ([CardProtocol]).self)
        }
        
    }
    
    
    public var hits: [HitProtocol] {
        get {
            return DefaultValueRegistry.defaultValue(for: ([HitProtocol]).self)
        }
        
    }
    
    
    public var played: [String] {
        get {
            return DefaultValueRegistry.defaultValue(for: ([String]).self)
        }
        
    }
    

    

    
}



public class MockStateComputedProtocol: StateComputedProtocol, Cuckoo.ProtocolMock {
    
    public typealias MocksType = StateComputedProtocol
    
    public typealias Stubbing = __StubbingProxy_StateComputedProtocol
    public typealias Verification = __VerificationProxy_StateComputedProtocol

    public let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: StateComputedProtocol?

    public func enableDefaultImplementation(_ stub: StateComputedProtocol) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    
    
    
    public var winner: Role? {
        get {
            return cuckoo_manager.getter("winner",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.winner)
        }
        
    }
    

    

    
    
    
    public func distance(from player: String, to other: String) -> Int {
        
    return cuckoo_manager.call("distance(from: String, to: String) -> Int",
            parameters: (player, other),
            escapingParameters: (player, other),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.distance(from: player, to: other))
        
    }
    

	public struct __StubbingProxy_StateComputedProtocol: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	    public init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    var winner: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockStateComputedProtocol, Role?> {
	        return .init(manager: cuckoo_manager, name: "winner")
	    }
	    
	    
	    func distance<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(from player: M1, to other: M2) -> Cuckoo.ProtocolStubFunction<(String, String), Int> where M1.MatchedType == String, M2.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String, String)>] = [wrap(matchable: player) { $0.0 }, wrap(matchable: other) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockStateComputedProtocol.self, method: "distance(from: String, to: String) -> Int", parameterMatchers: matchers))
	    }
	    
	}

	public struct __VerificationProxy_StateComputedProtocol: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	    public init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	    
	    var winner: Cuckoo.VerifyReadOnlyProperty<Role?> {
	        return .init(manager: cuckoo_manager, name: "winner", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	
	    
	    @discardableResult
	    func distance<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(from player: M1, to other: M2) -> Cuckoo.__DoNotUse<(String, String), Int> where M1.MatchedType == String, M2.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String, String)>] = [wrap(matchable: player) { $0.0 }, wrap(matchable: other) { $0.1 }]
	        return cuckoo_manager.verify("distance(from: String, to: String) -> Int", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

public class StateComputedProtocolStub: StateComputedProtocol {
    
    
    public var winner: Role? {
        get {
            return DefaultValueRegistry.defaultValue(for: (Role?).self)
        }
        
    }
    

    

    
    public func distance(from player: String, to other: String) -> Int  {
        return DefaultValueRegistry.defaultValue(for: (Int).self)
    }
    
}



public class MockStateProtocol: StateProtocol, Cuckoo.ProtocolMock {
    
    public typealias MocksType = StateProtocol
    
    public typealias Stubbing = __StubbingProxy_StateProtocol
    public typealias Verification = __VerificationProxy_StateProtocol

    public let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: StateProtocol?

    public func enableDefaultImplementation(_ stub: StateProtocol) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    
    
    
    public var players: [String: PlayerProtocol] {
        get {
            return cuckoo_manager.getter("players",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.players)
        }
        
    }
    
    
    
    public var initialOrder: [String] {
        get {
            return cuckoo_manager.getter("initialOrder",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.initialOrder)
        }
        
    }
    
    
    
    public var playOrder: [String] {
        get {
            return cuckoo_manager.getter("playOrder",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.playOrder)
        }
        
    }
    
    
    
    public var turn: String {
        get {
            return cuckoo_manager.getter("turn",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.turn)
        }
        
    }
    
    
    
    public var phase: Int {
        get {
            return cuckoo_manager.getter("phase",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.phase)
        }
        
    }
    
    
    
    public var deck: [CardProtocol] {
        get {
            return cuckoo_manager.getter("deck",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.deck)
        }
        
    }
    
    
    
    public var discard: [CardProtocol] {
        get {
            return cuckoo_manager.getter("discard",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.discard)
        }
        
    }
    
    
    
    public var store: [CardProtocol] {
        get {
            return cuckoo_manager.getter("store",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.store)
        }
        
    }
    
    
    
    public var hits: [HitProtocol] {
        get {
            return cuckoo_manager.getter("hits",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.hits)
        }
        
    }
    
    
    
    public var played: [String] {
        get {
            return cuckoo_manager.getter("played",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.played)
        }
        
    }
    
    
    
    public var winner: Role? {
        get {
            return cuckoo_manager.getter("winner",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.winner)
        }
        
    }
    

    

    
    
    
    public func distance(from player: String, to other: String) -> Int {
        
    return cuckoo_manager.call("distance(from: String, to: String) -> Int",
            parameters: (player, other),
            escapingParameters: (player, other),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.distance(from: player, to: other))
        
    }
    

	public struct __StubbingProxy_StateProtocol: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	    public init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    var players: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockStateProtocol, [String: PlayerProtocol]> {
	        return .init(manager: cuckoo_manager, name: "players")
	    }
	    
	    
	    var initialOrder: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockStateProtocol, [String]> {
	        return .init(manager: cuckoo_manager, name: "initialOrder")
	    }
	    
	    
	    var playOrder: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockStateProtocol, [String]> {
	        return .init(manager: cuckoo_manager, name: "playOrder")
	    }
	    
	    
	    var turn: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockStateProtocol, String> {
	        return .init(manager: cuckoo_manager, name: "turn")
	    }
	    
	    
	    var phase: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockStateProtocol, Int> {
	        return .init(manager: cuckoo_manager, name: "phase")
	    }
	    
	    
	    var deck: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockStateProtocol, [CardProtocol]> {
	        return .init(manager: cuckoo_manager, name: "deck")
	    }
	    
	    
	    var discard: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockStateProtocol, [CardProtocol]> {
	        return .init(manager: cuckoo_manager, name: "discard")
	    }
	    
	    
	    var store: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockStateProtocol, [CardProtocol]> {
	        return .init(manager: cuckoo_manager, name: "store")
	    }
	    
	    
	    var hits: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockStateProtocol, [HitProtocol]> {
	        return .init(manager: cuckoo_manager, name: "hits")
	    }
	    
	    
	    var played: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockStateProtocol, [String]> {
	        return .init(manager: cuckoo_manager, name: "played")
	    }
	    
	    
	    var winner: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockStateProtocol, Role?> {
	        return .init(manager: cuckoo_manager, name: "winner")
	    }
	    
	    
	    func distance<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(from player: M1, to other: M2) -> Cuckoo.ProtocolStubFunction<(String, String), Int> where M1.MatchedType == String, M2.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String, String)>] = [wrap(matchable: player) { $0.0 }, wrap(matchable: other) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockStateProtocol.self, method: "distance(from: String, to: String) -> Int", parameterMatchers: matchers))
	    }
	    
	}

	public struct __VerificationProxy_StateProtocol: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	    public init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	    
	    var players: Cuckoo.VerifyReadOnlyProperty<[String: PlayerProtocol]> {
	        return .init(manager: cuckoo_manager, name: "players", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var initialOrder: Cuckoo.VerifyReadOnlyProperty<[String]> {
	        return .init(manager: cuckoo_manager, name: "initialOrder", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var playOrder: Cuckoo.VerifyReadOnlyProperty<[String]> {
	        return .init(manager: cuckoo_manager, name: "playOrder", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var turn: Cuckoo.VerifyReadOnlyProperty<String> {
	        return .init(manager: cuckoo_manager, name: "turn", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var phase: Cuckoo.VerifyReadOnlyProperty<Int> {
	        return .init(manager: cuckoo_manager, name: "phase", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var deck: Cuckoo.VerifyReadOnlyProperty<[CardProtocol]> {
	        return .init(manager: cuckoo_manager, name: "deck", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var discard: Cuckoo.VerifyReadOnlyProperty<[CardProtocol]> {
	        return .init(manager: cuckoo_manager, name: "discard", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var store: Cuckoo.VerifyReadOnlyProperty<[CardProtocol]> {
	        return .init(manager: cuckoo_manager, name: "store", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var hits: Cuckoo.VerifyReadOnlyProperty<[HitProtocol]> {
	        return .init(manager: cuckoo_manager, name: "hits", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var played: Cuckoo.VerifyReadOnlyProperty<[String]> {
	        return .init(manager: cuckoo_manager, name: "played", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var winner: Cuckoo.VerifyReadOnlyProperty<Role?> {
	        return .init(manager: cuckoo_manager, name: "winner", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	
	    
	    @discardableResult
	    func distance<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(from player: M1, to other: M2) -> Cuckoo.__DoNotUse<(String, String), Int> where M1.MatchedType == String, M2.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String, String)>] = [wrap(matchable: player) { $0.0 }, wrap(matchable: other) { $0.1 }]
	        return cuckoo_manager.verify("distance(from: String, to: String) -> Int", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

public class StateProtocolStub: StateProtocol {
    
    
    public var players: [String: PlayerProtocol] {
        get {
            return DefaultValueRegistry.defaultValue(for: ([String: PlayerProtocol]).self)
        }
        
    }
    
    
    public var initialOrder: [String] {
        get {
            return DefaultValueRegistry.defaultValue(for: ([String]).self)
        }
        
    }
    
    
    public var playOrder: [String] {
        get {
            return DefaultValueRegistry.defaultValue(for: ([String]).self)
        }
        
    }
    
    
    public var turn: String {
        get {
            return DefaultValueRegistry.defaultValue(for: (String).self)
        }
        
    }
    
    
    public var phase: Int {
        get {
            return DefaultValueRegistry.defaultValue(for: (Int).self)
        }
        
    }
    
    
    public var deck: [CardProtocol] {
        get {
            return DefaultValueRegistry.defaultValue(for: ([CardProtocol]).self)
        }
        
    }
    
    
    public var discard: [CardProtocol] {
        get {
            return DefaultValueRegistry.defaultValue(for: ([CardProtocol]).self)
        }
        
    }
    
    
    public var store: [CardProtocol] {
        get {
            return DefaultValueRegistry.defaultValue(for: ([CardProtocol]).self)
        }
        
    }
    
    
    public var hits: [HitProtocol] {
        get {
            return DefaultValueRegistry.defaultValue(for: ([HitProtocol]).self)
        }
        
    }
    
    
    public var played: [String] {
        get {
            return DefaultValueRegistry.defaultValue(for: ([String]).self)
        }
        
    }
    
    
    public var winner: Role? {
        get {
            return DefaultValueRegistry.defaultValue(for: (Role?).self)
        }
        
    }
    

    

    
    public func distance(from player: String, to other: String) -> Int  {
        return DefaultValueRegistry.defaultValue(for: (Int).self)
    }
    
}



public class MockHitProtocol: HitProtocol, Cuckoo.ProtocolMock {
    
    public typealias MocksType = HitProtocol
    
    public typealias Stubbing = __StubbingProxy_HitProtocol
    public typealias Verification = __VerificationProxy_HitProtocol

    public let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: HitProtocol?

    public func enableDefaultImplementation(_ stub: HitProtocol) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    
    
    
    public var player: String {
        get {
            return cuckoo_manager.getter("player",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.player)
        }
        
    }
    
    
    
    public var name: String {
        get {
            return cuckoo_manager.getter("name",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.name)
        }
        
    }
    
    
    
    public var abilities: [String] {
        get {
            return cuckoo_manager.getter("abilities",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.abilities)
        }
        
    }
    
    
    
    public var offender: String {
        get {
            return cuckoo_manager.getter("offender",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.offender)
        }
        
    }
    
    
    
    public var cancelable: Int {
        get {
            return cuckoo_manager.getter("cancelable",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.cancelable)
        }
        
    }
    
    
    
    public var target: String? {
        get {
            return cuckoo_manager.getter("target",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.target)
        }
        
    }
    

    

    

	public struct __StubbingProxy_HitProtocol: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	    public init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    var player: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockHitProtocol, String> {
	        return .init(manager: cuckoo_manager, name: "player")
	    }
	    
	    
	    var name: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockHitProtocol, String> {
	        return .init(manager: cuckoo_manager, name: "name")
	    }
	    
	    
	    var abilities: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockHitProtocol, [String]> {
	        return .init(manager: cuckoo_manager, name: "abilities")
	    }
	    
	    
	    var offender: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockHitProtocol, String> {
	        return .init(manager: cuckoo_manager, name: "offender")
	    }
	    
	    
	    var cancelable: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockHitProtocol, Int> {
	        return .init(manager: cuckoo_manager, name: "cancelable")
	    }
	    
	    
	    var target: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockHitProtocol, String?> {
	        return .init(manager: cuckoo_manager, name: "target")
	    }
	    
	    
	}

	public struct __VerificationProxy_HitProtocol: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	    public init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	    
	    var player: Cuckoo.VerifyReadOnlyProperty<String> {
	        return .init(manager: cuckoo_manager, name: "player", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var name: Cuckoo.VerifyReadOnlyProperty<String> {
	        return .init(manager: cuckoo_manager, name: "name", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var abilities: Cuckoo.VerifyReadOnlyProperty<[String]> {
	        return .init(manager: cuckoo_manager, name: "abilities", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var offender: Cuckoo.VerifyReadOnlyProperty<String> {
	        return .init(manager: cuckoo_manager, name: "offender", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var cancelable: Cuckoo.VerifyReadOnlyProperty<Int> {
	        return .init(manager: cuckoo_manager, name: "cancelable", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var target: Cuckoo.VerifyReadOnlyProperty<String?> {
	        return .init(manager: cuckoo_manager, name: "target", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	
	    
	}
}

public class HitProtocolStub: HitProtocol {
    
    
    public var player: String {
        get {
            return DefaultValueRegistry.defaultValue(for: (String).self)
        }
        
    }
    
    
    public var name: String {
        get {
            return DefaultValueRegistry.defaultValue(for: (String).self)
        }
        
    }
    
    
    public var abilities: [String] {
        get {
            return DefaultValueRegistry.defaultValue(for: ([String]).self)
        }
        
    }
    
    
    public var offender: String {
        get {
            return DefaultValueRegistry.defaultValue(for: (String).self)
        }
        
    }
    
    
    public var cancelable: Int {
        get {
            return DefaultValueRegistry.defaultValue(for: (Int).self)
        }
        
    }
    
    
    public var target: String? {
        get {
            return DefaultValueRegistry.defaultValue(for: (String?).self)
        }
        
    }
    

    

    
}



public class MockBaseCardProtocol: BaseCardProtocol, Cuckoo.ProtocolMock {
    
    public typealias MocksType = BaseCardProtocol
    
    public typealias Stubbing = __StubbingProxy_BaseCardProtocol
    public typealias Verification = __VerificationProxy_BaseCardProtocol

    public let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: BaseCardProtocol?

    public func enableDefaultImplementation(_ stub: BaseCardProtocol) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    
    
    
    public var name: String {
        get {
            return cuckoo_manager.getter("name",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.name)
        }
        
    }
    
    
    
    public var desc: String {
        get {
            return cuckoo_manager.getter("desc",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.desc)
        }
        
    }
    
    
    
    public var abilities: [String: Int] {
        get {
            return cuckoo_manager.getter("abilities",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.abilities)
        }
        
    }
    

    

    

	public struct __StubbingProxy_BaseCardProtocol: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	    public init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    var name: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockBaseCardProtocol, String> {
	        return .init(manager: cuckoo_manager, name: "name")
	    }
	    
	    
	    var desc: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockBaseCardProtocol, String> {
	        return .init(manager: cuckoo_manager, name: "desc")
	    }
	    
	    
	    var abilities: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockBaseCardProtocol, [String: Int]> {
	        return .init(manager: cuckoo_manager, name: "abilities")
	    }
	    
	    
	}

	public struct __VerificationProxy_BaseCardProtocol: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	    public init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	    
	    var name: Cuckoo.VerifyReadOnlyProperty<String> {
	        return .init(manager: cuckoo_manager, name: "name", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var desc: Cuckoo.VerifyReadOnlyProperty<String> {
	        return .init(manager: cuckoo_manager, name: "desc", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var abilities: Cuckoo.VerifyReadOnlyProperty<[String: Int]> {
	        return .init(manager: cuckoo_manager, name: "abilities", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	
	    
	}
}

public class BaseCardProtocolStub: BaseCardProtocol {
    
    
    public var name: String {
        get {
            return DefaultValueRegistry.defaultValue(for: (String).self)
        }
        
    }
    
    
    public var desc: String {
        get {
            return DefaultValueRegistry.defaultValue(for: (String).self)
        }
        
    }
    
    
    public var abilities: [String: Int] {
        get {
            return DefaultValueRegistry.defaultValue(for: ([String: Int]).self)
        }
        
    }
    

    

    
}



public class MockPlayerStoredProtocol: PlayerStoredProtocol, Cuckoo.ProtocolMock {
    
    public typealias MocksType = PlayerStoredProtocol
    
    public typealias Stubbing = __StubbingProxy_PlayerStoredProtocol
    public typealias Verification = __VerificationProxy_PlayerStoredProtocol

    public let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: PlayerStoredProtocol?

    public func enableDefaultImplementation(_ stub: PlayerStoredProtocol) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    
    
    
    public var identifier: String {
        get {
            return cuckoo_manager.getter("identifier",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.identifier)
        }
        
    }
    
    
    
    public var role: Role? {
        get {
            return cuckoo_manager.getter("role",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.role)
        }
        
    }
    
    
    
    public var maxHealth: Int {
        get {
            return cuckoo_manager.getter("maxHealth",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.maxHealth)
        }
        
    }
    
    
    
    public var health: Int {
        get {
            return cuckoo_manager.getter("health",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.health)
        }
        
    }
    
    
    
    public var hand: [CardProtocol] {
        get {
            return cuckoo_manager.getter("hand",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.hand)
        }
        
    }
    
    
    
    public var inPlay: [CardProtocol] {
        get {
            return cuckoo_manager.getter("inPlay",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.inPlay)
        }
        
    }
    
    
    
    public var name: String {
        get {
            return cuckoo_manager.getter("name",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.name)
        }
        
    }
    
    
    
    public var desc: String {
        get {
            return cuckoo_manager.getter("desc",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.desc)
        }
        
    }
    
    
    
    public var abilities: [String: Int] {
        get {
            return cuckoo_manager.getter("abilities",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.abilities)
        }
        
    }
    

    

    

	public struct __StubbingProxy_PlayerStoredProtocol: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	    public init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    var identifier: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockPlayerStoredProtocol, String> {
	        return .init(manager: cuckoo_manager, name: "identifier")
	    }
	    
	    
	    var role: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockPlayerStoredProtocol, Role?> {
	        return .init(manager: cuckoo_manager, name: "role")
	    }
	    
	    
	    var maxHealth: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockPlayerStoredProtocol, Int> {
	        return .init(manager: cuckoo_manager, name: "maxHealth")
	    }
	    
	    
	    var health: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockPlayerStoredProtocol, Int> {
	        return .init(manager: cuckoo_manager, name: "health")
	    }
	    
	    
	    var hand: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockPlayerStoredProtocol, [CardProtocol]> {
	        return .init(manager: cuckoo_manager, name: "hand")
	    }
	    
	    
	    var inPlay: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockPlayerStoredProtocol, [CardProtocol]> {
	        return .init(manager: cuckoo_manager, name: "inPlay")
	    }
	    
	    
	    var name: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockPlayerStoredProtocol, String> {
	        return .init(manager: cuckoo_manager, name: "name")
	    }
	    
	    
	    var desc: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockPlayerStoredProtocol, String> {
	        return .init(manager: cuckoo_manager, name: "desc")
	    }
	    
	    
	    var abilities: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockPlayerStoredProtocol, [String: Int]> {
	        return .init(manager: cuckoo_manager, name: "abilities")
	    }
	    
	    
	}

	public struct __VerificationProxy_PlayerStoredProtocol: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	    public init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
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
	    
	    
	    var name: Cuckoo.VerifyReadOnlyProperty<String> {
	        return .init(manager: cuckoo_manager, name: "name", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var desc: Cuckoo.VerifyReadOnlyProperty<String> {
	        return .init(manager: cuckoo_manager, name: "desc", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var abilities: Cuckoo.VerifyReadOnlyProperty<[String: Int]> {
	        return .init(manager: cuckoo_manager, name: "abilities", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	
	    
	}
}

public class PlayerStoredProtocolStub: PlayerStoredProtocol {
    
    
    public var identifier: String {
        get {
            return DefaultValueRegistry.defaultValue(for: (String).self)
        }
        
    }
    
    
    public var role: Role? {
        get {
            return DefaultValueRegistry.defaultValue(for: (Role?).self)
        }
        
    }
    
    
    public var maxHealth: Int {
        get {
            return DefaultValueRegistry.defaultValue(for: (Int).self)
        }
        
    }
    
    
    public var health: Int {
        get {
            return DefaultValueRegistry.defaultValue(for: (Int).self)
        }
        
    }
    
    
    public var hand: [CardProtocol] {
        get {
            return DefaultValueRegistry.defaultValue(for: ([CardProtocol]).self)
        }
        
    }
    
    
    public var inPlay: [CardProtocol] {
        get {
            return DefaultValueRegistry.defaultValue(for: ([CardProtocol]).self)
        }
        
    }
    
    
    public var name: String {
        get {
            return DefaultValueRegistry.defaultValue(for: (String).self)
        }
        
    }
    
    
    public var desc: String {
        get {
            return DefaultValueRegistry.defaultValue(for: (String).self)
        }
        
    }
    
    
    public var abilities: [String: Int] {
        get {
            return DefaultValueRegistry.defaultValue(for: ([String: Int]).self)
        }
        
    }
    

    

    
}



public class MockPlayerComputedProtocol: PlayerComputedProtocol, Cuckoo.ProtocolMock {
    
    public typealias MocksType = PlayerComputedProtocol
    
    public typealias Stubbing = __StubbingProxy_PlayerComputedProtocol
    public typealias Verification = __VerificationProxy_PlayerComputedProtocol

    public let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: PlayerComputedProtocol?

    public func enableDefaultImplementation(_ stub: PlayerComputedProtocol) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    
    
    
    public var weapon: Int {
        get {
            return cuckoo_manager.getter("weapon",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.weapon)
        }
        
    }
    
    
    
    public var scope: Int {
        get {
            return cuckoo_manager.getter("scope",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.scope)
        }
        
    }
    
    
    
    public var mustang: Int {
        get {
            return cuckoo_manager.getter("mustang",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.mustang)
        }
        
    }
    
    
    
    public var bangsPerTurn: Int {
        get {
            return cuckoo_manager.getter("bangsPerTurn",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.bangsPerTurn)
        }
        
    }
    
    
    
    public var bangsCancelable: Int {
        get {
            return cuckoo_manager.getter("bangsCancelable",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.bangsCancelable)
        }
        
    }
    
    
    
    public var flippedCards: Int {
        get {
            return cuckoo_manager.getter("flippedCards",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.flippedCards)
        }
        
    }
    
    
    
    public var handLimit: Int {
        get {
            return cuckoo_manager.getter("handLimit",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.handLimit)
        }
        
    }
    

    

    

	public struct __StubbingProxy_PlayerComputedProtocol: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	    public init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    var weapon: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockPlayerComputedProtocol, Int> {
	        return .init(manager: cuckoo_manager, name: "weapon")
	    }
	    
	    
	    var scope: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockPlayerComputedProtocol, Int> {
	        return .init(manager: cuckoo_manager, name: "scope")
	    }
	    
	    
	    var mustang: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockPlayerComputedProtocol, Int> {
	        return .init(manager: cuckoo_manager, name: "mustang")
	    }
	    
	    
	    var bangsPerTurn: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockPlayerComputedProtocol, Int> {
	        return .init(manager: cuckoo_manager, name: "bangsPerTurn")
	    }
	    
	    
	    var bangsCancelable: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockPlayerComputedProtocol, Int> {
	        return .init(manager: cuckoo_manager, name: "bangsCancelable")
	    }
	    
	    
	    var flippedCards: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockPlayerComputedProtocol, Int> {
	        return .init(manager: cuckoo_manager, name: "flippedCards")
	    }
	    
	    
	    var handLimit: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockPlayerComputedProtocol, Int> {
	        return .init(manager: cuckoo_manager, name: "handLimit")
	    }
	    
	    
	}

	public struct __VerificationProxy_PlayerComputedProtocol: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	    public init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	    
	    var weapon: Cuckoo.VerifyReadOnlyProperty<Int> {
	        return .init(manager: cuckoo_manager, name: "weapon", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var scope: Cuckoo.VerifyReadOnlyProperty<Int> {
	        return .init(manager: cuckoo_manager, name: "scope", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var mustang: Cuckoo.VerifyReadOnlyProperty<Int> {
	        return .init(manager: cuckoo_manager, name: "mustang", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var bangsPerTurn: Cuckoo.VerifyReadOnlyProperty<Int> {
	        return .init(manager: cuckoo_manager, name: "bangsPerTurn", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var bangsCancelable: Cuckoo.VerifyReadOnlyProperty<Int> {
	        return .init(manager: cuckoo_manager, name: "bangsCancelable", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var flippedCards: Cuckoo.VerifyReadOnlyProperty<Int> {
	        return .init(manager: cuckoo_manager, name: "flippedCards", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var handLimit: Cuckoo.VerifyReadOnlyProperty<Int> {
	        return .init(manager: cuckoo_manager, name: "handLimit", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	
	    
	}
}

public class PlayerComputedProtocolStub: PlayerComputedProtocol {
    
    
    public var weapon: Int {
        get {
            return DefaultValueRegistry.defaultValue(for: (Int).self)
        }
        
    }
    
    
    public var scope: Int {
        get {
            return DefaultValueRegistry.defaultValue(for: (Int).self)
        }
        
    }
    
    
    public var mustang: Int {
        get {
            return DefaultValueRegistry.defaultValue(for: (Int).self)
        }
        
    }
    
    
    public var bangsPerTurn: Int {
        get {
            return DefaultValueRegistry.defaultValue(for: (Int).self)
        }
        
    }
    
    
    public var bangsCancelable: Int {
        get {
            return DefaultValueRegistry.defaultValue(for: (Int).self)
        }
        
    }
    
    
    public var flippedCards: Int {
        get {
            return DefaultValueRegistry.defaultValue(for: (Int).self)
        }
        
    }
    
    
    public var handLimit: Int {
        get {
            return DefaultValueRegistry.defaultValue(for: (Int).self)
        }
        
    }
    

    

    
}



public class MockPlayerProtocol: PlayerProtocol, Cuckoo.ProtocolMock {
    
    public typealias MocksType = PlayerProtocol
    
    public typealias Stubbing = __StubbingProxy_PlayerProtocol
    public typealias Verification = __VerificationProxy_PlayerProtocol

    public let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: PlayerProtocol?

    public func enableDefaultImplementation(_ stub: PlayerProtocol) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    
    
    
    public var identifier: String {
        get {
            return cuckoo_manager.getter("identifier",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.identifier)
        }
        
    }
    
    
    
    public var role: Role? {
        get {
            return cuckoo_manager.getter("role",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.role)
        }
        
    }
    
    
    
    public var maxHealth: Int {
        get {
            return cuckoo_manager.getter("maxHealth",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.maxHealth)
        }
        
    }
    
    
    
    public var health: Int {
        get {
            return cuckoo_manager.getter("health",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.health)
        }
        
    }
    
    
    
    public var hand: [CardProtocol] {
        get {
            return cuckoo_manager.getter("hand",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.hand)
        }
        
    }
    
    
    
    public var inPlay: [CardProtocol] {
        get {
            return cuckoo_manager.getter("inPlay",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.inPlay)
        }
        
    }
    
    
    
    public var name: String {
        get {
            return cuckoo_manager.getter("name",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.name)
        }
        
    }
    
    
    
    public var desc: String {
        get {
            return cuckoo_manager.getter("desc",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.desc)
        }
        
    }
    
    
    
    public var abilities: [String: Int] {
        get {
            return cuckoo_manager.getter("abilities",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.abilities)
        }
        
    }
    
    
    
    public var weapon: Int {
        get {
            return cuckoo_manager.getter("weapon",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.weapon)
        }
        
    }
    
    
    
    public var scope: Int {
        get {
            return cuckoo_manager.getter("scope",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.scope)
        }
        
    }
    
    
    
    public var mustang: Int {
        get {
            return cuckoo_manager.getter("mustang",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.mustang)
        }
        
    }
    
    
    
    public var bangsPerTurn: Int {
        get {
            return cuckoo_manager.getter("bangsPerTurn",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.bangsPerTurn)
        }
        
    }
    
    
    
    public var bangsCancelable: Int {
        get {
            return cuckoo_manager.getter("bangsCancelable",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.bangsCancelable)
        }
        
    }
    
    
    
    public var flippedCards: Int {
        get {
            return cuckoo_manager.getter("flippedCards",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.flippedCards)
        }
        
    }
    
    
    
    public var handLimit: Int {
        get {
            return cuckoo_manager.getter("handLimit",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.handLimit)
        }
        
    }
    

    

    

	public struct __StubbingProxy_PlayerProtocol: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	    public init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    var identifier: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockPlayerProtocol, String> {
	        return .init(manager: cuckoo_manager, name: "identifier")
	    }
	    
	    
	    var role: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockPlayerProtocol, Role?> {
	        return .init(manager: cuckoo_manager, name: "role")
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
	    
	    
	    var name: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockPlayerProtocol, String> {
	        return .init(manager: cuckoo_manager, name: "name")
	    }
	    
	    
	    var desc: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockPlayerProtocol, String> {
	        return .init(manager: cuckoo_manager, name: "desc")
	    }
	    
	    
	    var abilities: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockPlayerProtocol, [String: Int]> {
	        return .init(manager: cuckoo_manager, name: "abilities")
	    }
	    
	    
	    var weapon: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockPlayerProtocol, Int> {
	        return .init(manager: cuckoo_manager, name: "weapon")
	    }
	    
	    
	    var scope: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockPlayerProtocol, Int> {
	        return .init(manager: cuckoo_manager, name: "scope")
	    }
	    
	    
	    var mustang: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockPlayerProtocol, Int> {
	        return .init(manager: cuckoo_manager, name: "mustang")
	    }
	    
	    
	    var bangsPerTurn: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockPlayerProtocol, Int> {
	        return .init(manager: cuckoo_manager, name: "bangsPerTurn")
	    }
	    
	    
	    var bangsCancelable: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockPlayerProtocol, Int> {
	        return .init(manager: cuckoo_manager, name: "bangsCancelable")
	    }
	    
	    
	    var flippedCards: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockPlayerProtocol, Int> {
	        return .init(manager: cuckoo_manager, name: "flippedCards")
	    }
	    
	    
	    var handLimit: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockPlayerProtocol, Int> {
	        return .init(manager: cuckoo_manager, name: "handLimit")
	    }
	    
	    
	}

	public struct __VerificationProxy_PlayerProtocol: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	    public init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
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
	    
	    
	    var name: Cuckoo.VerifyReadOnlyProperty<String> {
	        return .init(manager: cuckoo_manager, name: "name", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var desc: Cuckoo.VerifyReadOnlyProperty<String> {
	        return .init(manager: cuckoo_manager, name: "desc", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var abilities: Cuckoo.VerifyReadOnlyProperty<[String: Int]> {
	        return .init(manager: cuckoo_manager, name: "abilities", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var weapon: Cuckoo.VerifyReadOnlyProperty<Int> {
	        return .init(manager: cuckoo_manager, name: "weapon", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var scope: Cuckoo.VerifyReadOnlyProperty<Int> {
	        return .init(manager: cuckoo_manager, name: "scope", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var mustang: Cuckoo.VerifyReadOnlyProperty<Int> {
	        return .init(manager: cuckoo_manager, name: "mustang", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var bangsPerTurn: Cuckoo.VerifyReadOnlyProperty<Int> {
	        return .init(manager: cuckoo_manager, name: "bangsPerTurn", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var bangsCancelable: Cuckoo.VerifyReadOnlyProperty<Int> {
	        return .init(manager: cuckoo_manager, name: "bangsCancelable", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var flippedCards: Cuckoo.VerifyReadOnlyProperty<Int> {
	        return .init(manager: cuckoo_manager, name: "flippedCards", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var handLimit: Cuckoo.VerifyReadOnlyProperty<Int> {
	        return .init(manager: cuckoo_manager, name: "handLimit", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	
	    
	}
}

public class PlayerProtocolStub: PlayerProtocol {
    
    
    public var identifier: String {
        get {
            return DefaultValueRegistry.defaultValue(for: (String).self)
        }
        
    }
    
    
    public var role: Role? {
        get {
            return DefaultValueRegistry.defaultValue(for: (Role?).self)
        }
        
    }
    
    
    public var maxHealth: Int {
        get {
            return DefaultValueRegistry.defaultValue(for: (Int).self)
        }
        
    }
    
    
    public var health: Int {
        get {
            return DefaultValueRegistry.defaultValue(for: (Int).self)
        }
        
    }
    
    
    public var hand: [CardProtocol] {
        get {
            return DefaultValueRegistry.defaultValue(for: ([CardProtocol]).self)
        }
        
    }
    
    
    public var inPlay: [CardProtocol] {
        get {
            return DefaultValueRegistry.defaultValue(for: ([CardProtocol]).self)
        }
        
    }
    
    
    public var name: String {
        get {
            return DefaultValueRegistry.defaultValue(for: (String).self)
        }
        
    }
    
    
    public var desc: String {
        get {
            return DefaultValueRegistry.defaultValue(for: (String).self)
        }
        
    }
    
    
    public var abilities: [String: Int] {
        get {
            return DefaultValueRegistry.defaultValue(for: ([String: Int]).self)
        }
        
    }
    
    
    public var weapon: Int {
        get {
            return DefaultValueRegistry.defaultValue(for: (Int).self)
        }
        
    }
    
    
    public var scope: Int {
        get {
            return DefaultValueRegistry.defaultValue(for: (Int).self)
        }
        
    }
    
    
    public var mustang: Int {
        get {
            return DefaultValueRegistry.defaultValue(for: (Int).self)
        }
        
    }
    
    
    public var bangsPerTurn: Int {
        get {
            return DefaultValueRegistry.defaultValue(for: (Int).self)
        }
        
    }
    
    
    public var bangsCancelable: Int {
        get {
            return DefaultValueRegistry.defaultValue(for: (Int).self)
        }
        
    }
    
    
    public var flippedCards: Int {
        get {
            return DefaultValueRegistry.defaultValue(for: (Int).self)
        }
        
    }
    
    
    public var handLimit: Int {
        get {
            return DefaultValueRegistry.defaultValue(for: (Int).self)
        }
        
    }
    

    

    
}



public class MockCardProtocol: CardProtocol, Cuckoo.ProtocolMock {
    
    public typealias MocksType = CardProtocol
    
    public typealias Stubbing = __StubbingProxy_CardProtocol
    public typealias Verification = __VerificationProxy_CardProtocol

    public let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: CardProtocol?

    public func enableDefaultImplementation(_ stub: CardProtocol) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    
    
    
    public var identifier: String {
        get {
            return cuckoo_manager.getter("identifier",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.identifier)
        }
        
    }
    
    
    
    public var type: CardType {
        get {
            return cuckoo_manager.getter("type",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.type)
        }
        
    }
    
    
    
    public var suit: String {
        get {
            return cuckoo_manager.getter("suit",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.suit)
        }
        
    }
    
    
    
    public var value: String {
        get {
            return cuckoo_manager.getter("value",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.value)
        }
        
    }
    
    
    
    public var name: String {
        get {
            return cuckoo_manager.getter("name",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.name)
        }
        
    }
    
    
    
    public var desc: String {
        get {
            return cuckoo_manager.getter("desc",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.desc)
        }
        
    }
    
    
    
    public var abilities: [String: Int] {
        get {
            return cuckoo_manager.getter("abilities",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.abilities)
        }
        
    }
    

    

    

	public struct __StubbingProxy_CardProtocol: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	    public init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    var identifier: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockCardProtocol, String> {
	        return .init(manager: cuckoo_manager, name: "identifier")
	    }
	    
	    
	    var type: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockCardProtocol, CardType> {
	        return .init(manager: cuckoo_manager, name: "type")
	    }
	    
	    
	    var suit: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockCardProtocol, String> {
	        return .init(manager: cuckoo_manager, name: "suit")
	    }
	    
	    
	    var value: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockCardProtocol, String> {
	        return .init(manager: cuckoo_manager, name: "value")
	    }
	    
	    
	    var name: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockCardProtocol, String> {
	        return .init(manager: cuckoo_manager, name: "name")
	    }
	    
	    
	    var desc: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockCardProtocol, String> {
	        return .init(manager: cuckoo_manager, name: "desc")
	    }
	    
	    
	    var abilities: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockCardProtocol, [String: Int]> {
	        return .init(manager: cuckoo_manager, name: "abilities")
	    }
	    
	    
	}

	public struct __VerificationProxy_CardProtocol: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	    public init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	    
	    var identifier: Cuckoo.VerifyReadOnlyProperty<String> {
	        return .init(manager: cuckoo_manager, name: "identifier", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var type: Cuckoo.VerifyReadOnlyProperty<CardType> {
	        return .init(manager: cuckoo_manager, name: "type", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var suit: Cuckoo.VerifyReadOnlyProperty<String> {
	        return .init(manager: cuckoo_manager, name: "suit", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var value: Cuckoo.VerifyReadOnlyProperty<String> {
	        return .init(manager: cuckoo_manager, name: "value", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var name: Cuckoo.VerifyReadOnlyProperty<String> {
	        return .init(manager: cuckoo_manager, name: "name", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var desc: Cuckoo.VerifyReadOnlyProperty<String> {
	        return .init(manager: cuckoo_manager, name: "desc", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var abilities: Cuckoo.VerifyReadOnlyProperty<[String: Int]> {
	        return .init(manager: cuckoo_manager, name: "abilities", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	
	    
	}
}

public class CardProtocolStub: CardProtocol {
    
    
    public var identifier: String {
        get {
            return DefaultValueRegistry.defaultValue(for: (String).self)
        }
        
    }
    
    
    public var type: CardType {
        get {
            return DefaultValueRegistry.defaultValue(for: (CardType).self)
        }
        
    }
    
    
    public var suit: String {
        get {
            return DefaultValueRegistry.defaultValue(for: (String).self)
        }
        
    }
    
    
    public var value: String {
        get {
            return DefaultValueRegistry.defaultValue(for: (String).self)
        }
        
    }
    
    
    public var name: String {
        get {
            return DefaultValueRegistry.defaultValue(for: (String).self)
        }
        
    }
    
    
    public var desc: String {
        get {
            return DefaultValueRegistry.defaultValue(for: (String).self)
        }
        
    }
    
    
    public var abilities: [String: Int] {
        get {
            return DefaultValueRegistry.defaultValue(for: ([String: Int]).self)
        }
        
    }
    

    

    
}


import Cuckoo
@testable import WildWestEngine

import RxSwift


public class MockRestrictedDatabaseProtocol: RestrictedDatabaseProtocol, Cuckoo.ProtocolMock {
    
    public typealias MocksType = RestrictedDatabaseProtocol
    
    public typealias Stubbing = __StubbingProxy_RestrictedDatabaseProtocol
    public typealias Verification = __VerificationProxy_RestrictedDatabaseProtocol

    public let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: RestrictedDatabaseProtocol?

    public func enableDefaultImplementation(_ stub: RestrictedDatabaseProtocol) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    
    
    
    public var event: PublishSubject<GEvent> {
        get {
            return cuckoo_manager.getter("event",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.event)
        }
        
    }
    

    

    
    
    
    public func state(observedBy actor: String?) -> Observable<StateProtocol> {
        
    return cuckoo_manager.call("state(observedBy: String?) -> Observable<StateProtocol>",
            parameters: (actor),
            escapingParameters: (actor),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.state(observedBy: actor))
        
    }
    

	public struct __StubbingProxy_RestrictedDatabaseProtocol: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	    public init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    var event: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockRestrictedDatabaseProtocol, PublishSubject<GEvent>> {
	        return .init(manager: cuckoo_manager, name: "event")
	    }
	    
	    
	    func state<M1: Cuckoo.OptionalMatchable>(observedBy actor: M1) -> Cuckoo.ProtocolStubFunction<(String?), Observable<StateProtocol>> where M1.OptionalMatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String?)>] = [wrap(matchable: actor) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockRestrictedDatabaseProtocol.self, method: "state(observedBy: String?) -> Observable<StateProtocol>", parameterMatchers: matchers))
	    }
	    
	}

	public struct __VerificationProxy_RestrictedDatabaseProtocol: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	    public init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	    
	    var event: Cuckoo.VerifyReadOnlyProperty<PublishSubject<GEvent>> {
	        return .init(manager: cuckoo_manager, name: "event", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	
	    
	    @discardableResult
	    func state<M1: Cuckoo.OptionalMatchable>(observedBy actor: M1) -> Cuckoo.__DoNotUse<(String?), Observable<StateProtocol>> where M1.OptionalMatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String?)>] = [wrap(matchable: actor) { $0 }]
	        return cuckoo_manager.verify("state(observedBy: String?) -> Observable<StateProtocol>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

public class RestrictedDatabaseProtocolStub: RestrictedDatabaseProtocol {
    
    
    public var event: PublishSubject<GEvent> {
        get {
            return DefaultValueRegistry.defaultValue(for: (PublishSubject<GEvent>).self)
        }
        
    }
    

    

    
    public func state(observedBy actor: String?) -> Observable<StateProtocol>  {
        return DefaultValueRegistry.defaultValue(for: (Observable<StateProtocol>).self)
    }
    
}



public class MockDatabaseProtocol: DatabaseProtocol, Cuckoo.ProtocolMock {
    
    public typealias MocksType = DatabaseProtocol
    
    public typealias Stubbing = __StubbingProxy_DatabaseProtocol
    public typealias Verification = __VerificationProxy_DatabaseProtocol

    public let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: DatabaseProtocol?

    public func enableDefaultImplementation(_ stub: DatabaseProtocol) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    
    
    
    public var state: BehaviorSubject<StateProtocol> {
        get {
            return cuckoo_manager.getter("state",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.state)
        }
        
    }
    
    
    
    public var event: PublishSubject<GEvent> {
        get {
            return cuckoo_manager.getter("event",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.event)
        }
        
    }
    

    

    
    
    
    public func update(event: GEvent) -> Completable {
        
    return cuckoo_manager.call("update(event: GEvent) -> Completable",
            parameters: (event),
            escapingParameters: (event),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.update(event: event))
        
    }
    
    
    
    public func state(observedBy actor: String?) -> Observable<StateProtocol> {
        
    return cuckoo_manager.call("state(observedBy: String?) -> Observable<StateProtocol>",
            parameters: (actor),
            escapingParameters: (actor),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.state(observedBy: actor))
        
    }
    

	public struct __StubbingProxy_DatabaseProtocol: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	    public init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    var state: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockDatabaseProtocol, BehaviorSubject<StateProtocol>> {
	        return .init(manager: cuckoo_manager, name: "state")
	    }
	    
	    
	    var event: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockDatabaseProtocol, PublishSubject<GEvent>> {
	        return .init(manager: cuckoo_manager, name: "event")
	    }
	    
	    
	    func update<M1: Cuckoo.Matchable>(event: M1) -> Cuckoo.ProtocolStubFunction<(GEvent), Completable> where M1.MatchedType == GEvent {
	        let matchers: [Cuckoo.ParameterMatcher<(GEvent)>] = [wrap(matchable: event) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockDatabaseProtocol.self, method: "update(event: GEvent) -> Completable", parameterMatchers: matchers))
	    }
	    
	    func state<M1: Cuckoo.OptionalMatchable>(observedBy actor: M1) -> Cuckoo.ProtocolStubFunction<(String?), Observable<StateProtocol>> where M1.OptionalMatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String?)>] = [wrap(matchable: actor) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockDatabaseProtocol.self, method: "state(observedBy: String?) -> Observable<StateProtocol>", parameterMatchers: matchers))
	    }
	    
	}

	public struct __VerificationProxy_DatabaseProtocol: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	    public init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	    
	    var state: Cuckoo.VerifyReadOnlyProperty<BehaviorSubject<StateProtocol>> {
	        return .init(manager: cuckoo_manager, name: "state", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var event: Cuckoo.VerifyReadOnlyProperty<PublishSubject<GEvent>> {
	        return .init(manager: cuckoo_manager, name: "event", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	
	    
	    @discardableResult
	    func update<M1: Cuckoo.Matchable>(event: M1) -> Cuckoo.__DoNotUse<(GEvent), Completable> where M1.MatchedType == GEvent {
	        let matchers: [Cuckoo.ParameterMatcher<(GEvent)>] = [wrap(matchable: event) { $0 }]
	        return cuckoo_manager.verify("update(event: GEvent) -> Completable", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func state<M1: Cuckoo.OptionalMatchable>(observedBy actor: M1) -> Cuckoo.__DoNotUse<(String?), Observable<StateProtocol>> where M1.OptionalMatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String?)>] = [wrap(matchable: actor) { $0 }]
	        return cuckoo_manager.verify("state(observedBy: String?) -> Observable<StateProtocol>", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

public class DatabaseProtocolStub: DatabaseProtocol {
    
    
    public var state: BehaviorSubject<StateProtocol> {
        get {
            return DefaultValueRegistry.defaultValue(for: (BehaviorSubject<StateProtocol>).self)
        }
        
    }
    
    
    public var event: PublishSubject<GEvent> {
        get {
            return DefaultValueRegistry.defaultValue(for: (PublishSubject<GEvent>).self)
        }
        
    }
    

    

    
    public func update(event: GEvent) -> Completable  {
        return DefaultValueRegistry.defaultValue(for: (Completable).self)
    }
    
    public func state(observedBy actor: String?) -> Observable<StateProtocol>  {
        return DefaultValueRegistry.defaultValue(for: (Observable<StateProtocol>).self)
    }
    
}


import Cuckoo
@testable import WildWestEngine

import RxSwift


public class MockEngineProtocol: EngineProtocol, Cuckoo.ProtocolMock {
    
    public typealias MocksType = EngineProtocol
    
    public typealias Stubbing = __StubbingProxy_EngineProtocol
    public typealias Verification = __VerificationProxy_EngineProtocol

    public let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: EngineProtocol?

    public func enableDefaultImplementation(_ stub: EngineProtocol) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
    public func execute(_ move: GMove)  {
        
    return cuckoo_manager.call("execute(_: GMove)",
            parameters: (move),
            escapingParameters: (move),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.execute(move))
        
    }
    
    
    
    public func refresh()  {
        
    return cuckoo_manager.call("refresh()",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.refresh())
        
    }
    

	public struct __StubbingProxy_EngineProtocol: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	    public init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func execute<M1: Cuckoo.Matchable>(_ move: M1) -> Cuckoo.ProtocolStubNoReturnFunction<(GMove)> where M1.MatchedType == GMove {
	        let matchers: [Cuckoo.ParameterMatcher<(GMove)>] = [wrap(matchable: move) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockEngineProtocol.self, method: "execute(_: GMove)", parameterMatchers: matchers))
	    }
	    
	    func refresh() -> Cuckoo.ProtocolStubNoReturnFunction<()> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockEngineProtocol.self, method: "refresh()", parameterMatchers: matchers))
	    }
	    
	}

	public struct __VerificationProxy_EngineProtocol: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	    public init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func execute<M1: Cuckoo.Matchable>(_ move: M1) -> Cuckoo.__DoNotUse<(GMove), Void> where M1.MatchedType == GMove {
	        let matchers: [Cuckoo.ParameterMatcher<(GMove)>] = [wrap(matchable: move) { $0 }]
	        return cuckoo_manager.verify("execute(_: GMove)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func refresh() -> Cuckoo.__DoNotUse<(), Void> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("refresh()", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

public class EngineProtocolStub: EngineProtocol {
    

    

    
    public func execute(_ move: GMove)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    public func refresh()   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
}


import Cuckoo
@testable import WildWestEngine


public class MockGDatabaseUpdaterProtocol: GDatabaseUpdaterProtocol, Cuckoo.ProtocolMock {
    
    public typealias MocksType = GDatabaseUpdaterProtocol
    
    public typealias Stubbing = __StubbingProxy_GDatabaseUpdaterProtocol
    public typealias Verification = __VerificationProxy_GDatabaseUpdaterProtocol

    public let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: GDatabaseUpdaterProtocol?

    public func enableDefaultImplementation(_ stub: GDatabaseUpdaterProtocol) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
    public func execute(_ event: GEvent, in state: GState)  {
        
    return cuckoo_manager.call("execute(_: GEvent, in: GState)",
            parameters: (event, state),
            escapingParameters: (event, state),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.execute(event, in: state))
        
    }
    

	public struct __StubbingProxy_GDatabaseUpdaterProtocol: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	    public init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func execute<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(_ event: M1, in state: M2) -> Cuckoo.ProtocolStubNoReturnFunction<(GEvent, GState)> where M1.MatchedType == GEvent, M2.MatchedType == GState {
	        let matchers: [Cuckoo.ParameterMatcher<(GEvent, GState)>] = [wrap(matchable: event) { $0.0 }, wrap(matchable: state) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockGDatabaseUpdaterProtocol.self, method: "execute(_: GEvent, in: GState)", parameterMatchers: matchers))
	    }
	    
	}

	public struct __VerificationProxy_GDatabaseUpdaterProtocol: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	    public init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func execute<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(_ event: M1, in state: M2) -> Cuckoo.__DoNotUse<(GEvent, GState), Void> where M1.MatchedType == GEvent, M2.MatchedType == GState {
	        let matchers: [Cuckoo.ParameterMatcher<(GEvent, GState)>] = [wrap(matchable: event) { $0.0 }, wrap(matchable: state) { $0.1 }]
	        return cuckoo_manager.verify("execute(_: GEvent, in: GState)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

public class GDatabaseUpdaterProtocolStub: GDatabaseUpdaterProtocol {
    

    

    
    public func execute(_ event: GEvent, in state: GState)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
}


import Cuckoo
@testable import WildWestEngine


public class MockGEventQueueProtocol: GEventQueueProtocol, Cuckoo.ProtocolMock {
    
    public typealias MocksType = GEventQueueProtocol
    
    public typealias Stubbing = __StubbingProxy_GEventQueueProtocol
    public typealias Verification = __VerificationProxy_GEventQueueProtocol

    public let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: GEventQueueProtocol?

    public func enableDefaultImplementation(_ stub: GEventQueueProtocol) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
    public func queue(_ event: GEvent)  {
        
    return cuckoo_manager.call("queue(_: GEvent)",
            parameters: (event),
            escapingParameters: (event),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.queue(event))
        
    }
    
    
    
    public func push(_ event: GEvent)  {
        
    return cuckoo_manager.call("push(_: GEvent)",
            parameters: (event),
            escapingParameters: (event),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.push(event))
        
    }
    
    
    
    public func pop() -> GEvent? {
        
    return cuckoo_manager.call("pop() -> GEvent?",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.pop())
        
    }
    

	public struct __StubbingProxy_GEventQueueProtocol: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	    public init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func queue<M1: Cuckoo.Matchable>(_ event: M1) -> Cuckoo.ProtocolStubNoReturnFunction<(GEvent)> where M1.MatchedType == GEvent {
	        let matchers: [Cuckoo.ParameterMatcher<(GEvent)>] = [wrap(matchable: event) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockGEventQueueProtocol.self, method: "queue(_: GEvent)", parameterMatchers: matchers))
	    }
	    
	    func push<M1: Cuckoo.Matchable>(_ event: M1) -> Cuckoo.ProtocolStubNoReturnFunction<(GEvent)> where M1.MatchedType == GEvent {
	        let matchers: [Cuckoo.ParameterMatcher<(GEvent)>] = [wrap(matchable: event) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockGEventQueueProtocol.self, method: "push(_: GEvent)", parameterMatchers: matchers))
	    }
	    
	    func pop() -> Cuckoo.ProtocolStubFunction<(), GEvent?> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockGEventQueueProtocol.self, method: "pop() -> GEvent?", parameterMatchers: matchers))
	    }
	    
	}

	public struct __VerificationProxy_GEventQueueProtocol: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	    public init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func queue<M1: Cuckoo.Matchable>(_ event: M1) -> Cuckoo.__DoNotUse<(GEvent), Void> where M1.MatchedType == GEvent {
	        let matchers: [Cuckoo.ParameterMatcher<(GEvent)>] = [wrap(matchable: event) { $0 }]
	        return cuckoo_manager.verify("queue(_: GEvent)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func push<M1: Cuckoo.Matchable>(_ event: M1) -> Cuckoo.__DoNotUse<(GEvent), Void> where M1.MatchedType == GEvent {
	        let matchers: [Cuckoo.ParameterMatcher<(GEvent)>] = [wrap(matchable: event) { $0 }]
	        return cuckoo_manager.verify("push(_: GEvent)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func pop() -> Cuckoo.__DoNotUse<(), GEvent?> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("pop() -> GEvent?", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

public class GEventQueueProtocolStub: GEventQueueProtocol {
    

    

    
    public func queue(_ event: GEvent)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    public func push(_ event: GEvent)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
    public func pop() -> GEvent?  {
        return DefaultValueRegistry.defaultValue(for: (GEvent?).self)
    }
    
}


import Cuckoo
@testable import WildWestEngine

import RxSwift


public class MockGLoopProtocol: GLoopProtocol, Cuckoo.ProtocolMock {
    
    public typealias MocksType = GLoopProtocol
    
    public typealias Stubbing = __StubbingProxy_GLoopProtocol
    public typealias Verification = __VerificationProxy_GLoopProtocol

    public let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: GLoopProtocol?

    public func enableDefaultImplementation(_ stub: GLoopProtocol) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
    public func run(_ move: GMove?) -> Completable {
        
    return cuckoo_manager.call("run(_: GMove?) -> Completable",
            parameters: (move),
            escapingParameters: (move),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.run(move))
        
    }
    

	public struct __StubbingProxy_GLoopProtocol: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	    public init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func run<M1: Cuckoo.OptionalMatchable>(_ move: M1) -> Cuckoo.ProtocolStubFunction<(GMove?), Completable> where M1.OptionalMatchedType == GMove {
	        let matchers: [Cuckoo.ParameterMatcher<(GMove?)>] = [wrap(matchable: move) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockGLoopProtocol.self, method: "run(_: GMove?) -> Completable", parameterMatchers: matchers))
	    }
	    
	}

	public struct __VerificationProxy_GLoopProtocol: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	    public init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func run<M1: Cuckoo.OptionalMatchable>(_ move: M1) -> Cuckoo.__DoNotUse<(GMove?), Completable> where M1.OptionalMatchedType == GMove {
	        let matchers: [Cuckoo.ParameterMatcher<(GMove?)>] = [wrap(matchable: move) { $0 }]
	        return cuckoo_manager.verify("run(_: GMove?) -> Completable", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

public class GLoopProtocolStub: GLoopProtocol {
    

    

    
    public func run(_ move: GMove?) -> Completable  {
        return DefaultValueRegistry.defaultValue(for: (Completable).self)
    }
    
}


import Cuckoo
@testable import WildWestEngine


public class MockGTimerProtocol: GTimerProtocol, Cuckoo.ProtocolMock {
    
    public typealias MocksType = GTimerProtocol
    
    public typealias Stubbing = __StubbingProxy_GTimerProtocol
    public typealias Verification = __VerificationProxy_GTimerProtocol

    public let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: GTimerProtocol?

    public func enableDefaultImplementation(_ stub: GTimerProtocol) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
    public func wait(_ event: GEvent, completion: @escaping () -> Void)  {
        
    return cuckoo_manager.call("wait(_: GEvent, completion: @escaping () -> Void)",
            parameters: (event, completion),
            escapingParameters: (event, completion),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.wait(event, completion: completion))
        
    }
    

	public struct __StubbingProxy_GTimerProtocol: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	    public init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func wait<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(_ event: M1, completion: M2) -> Cuckoo.ProtocolStubNoReturnFunction<(GEvent, () -> Void)> where M1.MatchedType == GEvent, M2.MatchedType == () -> Void {
	        let matchers: [Cuckoo.ParameterMatcher<(GEvent, () -> Void)>] = [wrap(matchable: event) { $0.0 }, wrap(matchable: completion) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockGTimerProtocol.self, method: "wait(_: GEvent, completion: @escaping () -> Void)", parameterMatchers: matchers))
	    }
	    
	}

	public struct __VerificationProxy_GTimerProtocol: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	    public init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func wait<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(_ event: M1, completion: M2) -> Cuckoo.__DoNotUse<(GEvent, () -> Void), Void> where M1.MatchedType == GEvent, M2.MatchedType == () -> Void {
	        let matchers: [Cuckoo.ParameterMatcher<(GEvent, () -> Void)>] = [wrap(matchable: event) { $0.0 }, wrap(matchable: completion) { $0.1 }]
	        return cuckoo_manager.verify("wait(_: GEvent, completion: @escaping () -> Void)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

public class GTimerProtocolStub: GTimerProtocol {
    

    

    
    public func wait(_ event: GEvent, completion: @escaping () -> Void)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
}



public class MockDurationMatcherProtocol: DurationMatcherProtocol, Cuckoo.ProtocolMock {
    
    public typealias MocksType = DurationMatcherProtocol
    
    public typealias Stubbing = __StubbingProxy_DurationMatcherProtocol
    public typealias Verification = __VerificationProxy_DurationMatcherProtocol

    public let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: DurationMatcherProtocol?

    public func enableDefaultImplementation(_ stub: DurationMatcherProtocol) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
    public func waitDuration(_ event: GEvent) -> TimeInterval {
        
    return cuckoo_manager.call("waitDuration(_: GEvent) -> TimeInterval",
            parameters: (event),
            escapingParameters: (event),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.waitDuration(event))
        
    }
    

	public struct __StubbingProxy_DurationMatcherProtocol: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	    public init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func waitDuration<M1: Cuckoo.Matchable>(_ event: M1) -> Cuckoo.ProtocolStubFunction<(GEvent), TimeInterval> where M1.MatchedType == GEvent {
	        let matchers: [Cuckoo.ParameterMatcher<(GEvent)>] = [wrap(matchable: event) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockDurationMatcherProtocol.self, method: "waitDuration(_: GEvent) -> TimeInterval", parameterMatchers: matchers))
	    }
	    
	}

	public struct __VerificationProxy_DurationMatcherProtocol: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	    public init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func waitDuration<M1: Cuckoo.Matchable>(_ event: M1) -> Cuckoo.__DoNotUse<(GEvent), TimeInterval> where M1.MatchedType == GEvent {
	        let matchers: [Cuckoo.ParameterMatcher<(GEvent)>] = [wrap(matchable: event) { $0 }]
	        return cuckoo_manager.verify("waitDuration(_: GEvent) -> TimeInterval", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

public class DurationMatcherProtocolStub: DurationMatcherProtocol {
    

    

    
    public func waitDuration(_ event: GEvent) -> TimeInterval  {
        return DefaultValueRegistry.defaultValue(for: (TimeInterval).self)
    }
    
}


import Cuckoo
@testable import WildWestEngine


public class MockAbilityMatcherProtocol: AbilityMatcherProtocol, Cuckoo.ProtocolMock {
    
    public typealias MocksType = AbilityMatcherProtocol
    
    public typealias Stubbing = __StubbingProxy_AbilityMatcherProtocol
    public typealias Verification = __VerificationProxy_AbilityMatcherProtocol

    public let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: AbilityMatcherProtocol?

    public func enableDefaultImplementation(_ stub: AbilityMatcherProtocol) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
    public func active(in state: StateProtocol) -> [GMove]? {
        
    return cuckoo_manager.call("active(in: StateProtocol) -> [GMove]?",
            parameters: (state),
            escapingParameters: (state),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.active(in: state))
        
    }
    
    
    
    public func triggered(on event: GEvent, in state: StateProtocol) -> [GMove]? {
        
    return cuckoo_manager.call("triggered(on: GEvent, in: StateProtocol) -> [GMove]?",
            parameters: (event, state),
            escapingParameters: (event, state),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.triggered(on: event, in: state))
        
    }
    
    
    
    public func effects(on move: GMove, in state: StateProtocol) -> [GEvent]? {
        
    return cuckoo_manager.call("effects(on: GMove, in: StateProtocol) -> [GEvent]?",
            parameters: (move, state),
            escapingParameters: (move, state),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.effects(on: move, in: state))
        
    }
    

	public struct __StubbingProxy_AbilityMatcherProtocol: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	    public init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func active<M1: Cuckoo.Matchable>(in state: M1) -> Cuckoo.ProtocolStubFunction<(StateProtocol), [GMove]?> where M1.MatchedType == StateProtocol {
	        let matchers: [Cuckoo.ParameterMatcher<(StateProtocol)>] = [wrap(matchable: state) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockAbilityMatcherProtocol.self, method: "active(in: StateProtocol) -> [GMove]?", parameterMatchers: matchers))
	    }
	    
	    func triggered<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(on event: M1, in state: M2) -> Cuckoo.ProtocolStubFunction<(GEvent, StateProtocol), [GMove]?> where M1.MatchedType == GEvent, M2.MatchedType == StateProtocol {
	        let matchers: [Cuckoo.ParameterMatcher<(GEvent, StateProtocol)>] = [wrap(matchable: event) { $0.0 }, wrap(matchable: state) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockAbilityMatcherProtocol.self, method: "triggered(on: GEvent, in: StateProtocol) -> [GMove]?", parameterMatchers: matchers))
	    }
	    
	    func effects<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(on move: M1, in state: M2) -> Cuckoo.ProtocolStubFunction<(GMove, StateProtocol), [GEvent]?> where M1.MatchedType == GMove, M2.MatchedType == StateProtocol {
	        let matchers: [Cuckoo.ParameterMatcher<(GMove, StateProtocol)>] = [wrap(matchable: move) { $0.0 }, wrap(matchable: state) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockAbilityMatcherProtocol.self, method: "effects(on: GMove, in: StateProtocol) -> [GEvent]?", parameterMatchers: matchers))
	    }
	    
	}

	public struct __VerificationProxy_AbilityMatcherProtocol: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	    public init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func active<M1: Cuckoo.Matchable>(in state: M1) -> Cuckoo.__DoNotUse<(StateProtocol), [GMove]?> where M1.MatchedType == StateProtocol {
	        let matchers: [Cuckoo.ParameterMatcher<(StateProtocol)>] = [wrap(matchable: state) { $0 }]
	        return cuckoo_manager.verify("active(in: StateProtocol) -> [GMove]?", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func triggered<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(on event: M1, in state: M2) -> Cuckoo.__DoNotUse<(GEvent, StateProtocol), [GMove]?> where M1.MatchedType == GEvent, M2.MatchedType == StateProtocol {
	        let matchers: [Cuckoo.ParameterMatcher<(GEvent, StateProtocol)>] = [wrap(matchable: event) { $0.0 }, wrap(matchable: state) { $0.1 }]
	        return cuckoo_manager.verify("triggered(on: GEvent, in: StateProtocol) -> [GMove]?", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func effects<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(on move: M1, in state: M2) -> Cuckoo.__DoNotUse<(GMove, StateProtocol), [GEvent]?> where M1.MatchedType == GMove, M2.MatchedType == StateProtocol {
	        let matchers: [Cuckoo.ParameterMatcher<(GMove, StateProtocol)>] = [wrap(matchable: move) { $0.0 }, wrap(matchable: state) { $0.1 }]
	        return cuckoo_manager.verify("effects(on: GMove, in: StateProtocol) -> [GEvent]?", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

public class AbilityMatcherProtocolStub: AbilityMatcherProtocol {
    

    

    
    public func active(in state: StateProtocol) -> [GMove]?  {
        return DefaultValueRegistry.defaultValue(for: ([GMove]?).self)
    }
    
    public func triggered(on event: GEvent, in state: StateProtocol) -> [GMove]?  {
        return DefaultValueRegistry.defaultValue(for: ([GMove]?).self)
    }
    
    public func effects(on move: GMove, in state: StateProtocol) -> [GEvent]?  {
        return DefaultValueRegistry.defaultValue(for: ([GEvent]?).self)
    }
    
}


import Cuckoo
@testable import WildWestEngine


public class MockResourcesLoaderProtocol: ResourcesLoaderProtocol, Cuckoo.ProtocolMock {
    
    public typealias MocksType = ResourcesLoaderProtocol
    
    public typealias Stubbing = __StubbingProxy_ResourcesLoaderProtocol
    public typealias Verification = __VerificationProxy_ResourcesLoaderProtocol

    public let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: ResourcesLoaderProtocol?

    public func enableDefaultImplementation(_ stub: ResourcesLoaderProtocol) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
    public func loadCards() -> [Card] {
        
    return cuckoo_manager.call("loadCards() -> [Card]",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.loadCards())
        
    }
    
    
    
    public func loadDeck() -> [DeckCard] {
        
    return cuckoo_manager.call("loadDeck() -> [DeckCard]",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.loadDeck())
        
    }
    
    
    
    public func loadAbilities() -> [Ability] {
        
    return cuckoo_manager.call("loadAbilities() -> [Ability]",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.loadAbilities())
        
    }
    

	public struct __StubbingProxy_ResourcesLoaderProtocol: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	    public init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func loadCards() -> Cuckoo.ProtocolStubFunction<(), [Card]> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockResourcesLoaderProtocol.self, method: "loadCards() -> [Card]", parameterMatchers: matchers))
	    }
	    
	    func loadDeck() -> Cuckoo.ProtocolStubFunction<(), [DeckCard]> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockResourcesLoaderProtocol.self, method: "loadDeck() -> [DeckCard]", parameterMatchers: matchers))
	    }
	    
	    func loadAbilities() -> Cuckoo.ProtocolStubFunction<(), [Ability]> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockResourcesLoaderProtocol.self, method: "loadAbilities() -> [Ability]", parameterMatchers: matchers))
	    }
	    
	}

	public struct __VerificationProxy_ResourcesLoaderProtocol: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	    public init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func loadCards() -> Cuckoo.__DoNotUse<(), [Card]> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("loadCards() -> [Card]", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func loadDeck() -> Cuckoo.__DoNotUse<(), [DeckCard]> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("loadDeck() -> [DeckCard]", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func loadAbilities() -> Cuckoo.__DoNotUse<(), [Ability]> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("loadAbilities() -> [Ability]", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

public class ResourcesLoaderProtocolStub: ResourcesLoaderProtocol {
    

    

    
    public func loadCards() -> [Card]  {
        return DefaultValueRegistry.defaultValue(for: ([Card]).self)
    }
    
    public func loadDeck() -> [DeckCard]  {
        return DefaultValueRegistry.defaultValue(for: ([DeckCard]).self)
    }
    
    public func loadAbilities() -> [Ability]  {
        return DefaultValueRegistry.defaultValue(for: ([Ability]).self)
    }
    
}


import Cuckoo
@testable import WildWestEngine


public class MockSetupProtocol: SetupProtocol, Cuckoo.ProtocolMock {
    
    public typealias MocksType = SetupProtocol
    
    public typealias Stubbing = __StubbingProxy_SetupProtocol
    public typealias Verification = __VerificationProxy_SetupProtocol

    public let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: SetupProtocol?

    public func enableDefaultImplementation(_ stub: SetupProtocol) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
    public func roles(for playersCount: Int) -> [Role] {
        
    return cuckoo_manager.call("roles(for: Int) -> [Role]",
            parameters: (playersCount),
            escapingParameters: (playersCount),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.roles(for: playersCount))
        
    }
    
    
    
    public func setupDeck(cardSet: [DeckCard], cards: [Card]) -> [CardProtocol] {
        
    return cuckoo_manager.call("setupDeck(cardSet: [DeckCard], cards: [Card]) -> [CardProtocol]",
            parameters: (cardSet, cards),
            escapingParameters: (cardSet, cards),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.setupDeck(cardSet: cardSet, cards: cards))
        
    }
    
    
    
    public func setupGame(roles: [Role], cards: [Card], cardSet: [DeckCard], preferredRole: Role?, preferredFigure: String?) -> StateProtocol {
        
    return cuckoo_manager.call("setupGame(roles: [Role], cards: [Card], cardSet: [DeckCard], preferredRole: Role?, preferredFigure: String?) -> StateProtocol",
            parameters: (roles, cards, cardSet, preferredRole, preferredFigure),
            escapingParameters: (roles, cards, cardSet, preferredRole, preferredFigure),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.setupGame(roles: roles, cards: cards, cardSet: cardSet, preferredRole: preferredRole, preferredFigure: preferredFigure))
        
    }
    

	public struct __StubbingProxy_SetupProtocol: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	    public init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func roles<M1: Cuckoo.Matchable>(for playersCount: M1) -> Cuckoo.ProtocolStubFunction<(Int), [Role]> where M1.MatchedType == Int {
	        let matchers: [Cuckoo.ParameterMatcher<(Int)>] = [wrap(matchable: playersCount) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockSetupProtocol.self, method: "roles(for: Int) -> [Role]", parameterMatchers: matchers))
	    }
	    
	    func setupDeck<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(cardSet: M1, cards: M2) -> Cuckoo.ProtocolStubFunction<([DeckCard], [Card]), [CardProtocol]> where M1.MatchedType == [DeckCard], M2.MatchedType == [Card] {
	        let matchers: [Cuckoo.ParameterMatcher<([DeckCard], [Card])>] = [wrap(matchable: cardSet) { $0.0 }, wrap(matchable: cards) { $0.1 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockSetupProtocol.self, method: "setupDeck(cardSet: [DeckCard], cards: [Card]) -> [CardProtocol]", parameterMatchers: matchers))
	    }
	    
	    func setupGame<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable, M4: Cuckoo.OptionalMatchable, M5: Cuckoo.OptionalMatchable>(roles: M1, cards: M2, cardSet: M3, preferredRole: M4, preferredFigure: M5) -> Cuckoo.ProtocolStubFunction<([Role], [Card], [DeckCard], Role?, String?), StateProtocol> where M1.MatchedType == [Role], M2.MatchedType == [Card], M3.MatchedType == [DeckCard], M4.OptionalMatchedType == Role, M5.OptionalMatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<([Role], [Card], [DeckCard], Role?, String?)>] = [wrap(matchable: roles) { $0.0 }, wrap(matchable: cards) { $0.1 }, wrap(matchable: cardSet) { $0.2 }, wrap(matchable: preferredRole) { $0.3 }, wrap(matchable: preferredFigure) { $0.4 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockSetupProtocol.self, method: "setupGame(roles: [Role], cards: [Card], cardSet: [DeckCard], preferredRole: Role?, preferredFigure: String?) -> StateProtocol", parameterMatchers: matchers))
	    }
	    
	}

	public struct __VerificationProxy_SetupProtocol: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	    public init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
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
	    func setupDeck<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable>(cardSet: M1, cards: M2) -> Cuckoo.__DoNotUse<([DeckCard], [Card]), [CardProtocol]> where M1.MatchedType == [DeckCard], M2.MatchedType == [Card] {
	        let matchers: [Cuckoo.ParameterMatcher<([DeckCard], [Card])>] = [wrap(matchable: cardSet) { $0.0 }, wrap(matchable: cards) { $0.1 }]
	        return cuckoo_manager.verify("setupDeck(cardSet: [DeckCard], cards: [Card]) -> [CardProtocol]", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func setupGame<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable, M4: Cuckoo.OptionalMatchable, M5: Cuckoo.OptionalMatchable>(roles: M1, cards: M2, cardSet: M3, preferredRole: M4, preferredFigure: M5) -> Cuckoo.__DoNotUse<([Role], [Card], [DeckCard], Role?, String?), StateProtocol> where M1.MatchedType == [Role], M2.MatchedType == [Card], M3.MatchedType == [DeckCard], M4.OptionalMatchedType == Role, M5.OptionalMatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<([Role], [Card], [DeckCard], Role?, String?)>] = [wrap(matchable: roles) { $0.0 }, wrap(matchable: cards) { $0.1 }, wrap(matchable: cardSet) { $0.2 }, wrap(matchable: preferredRole) { $0.3 }, wrap(matchable: preferredFigure) { $0.4 }]
	        return cuckoo_manager.verify("setupGame(roles: [Role], cards: [Card], cardSet: [DeckCard], preferredRole: Role?, preferredFigure: String?) -> StateProtocol", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

public class SetupProtocolStub: SetupProtocol {
    

    

    
    public func roles(for playersCount: Int) -> [Role]  {
        return DefaultValueRegistry.defaultValue(for: ([Role]).self)
    }
    
    public func setupDeck(cardSet: [DeckCard], cards: [Card]) -> [CardProtocol]  {
        return DefaultValueRegistry.defaultValue(for: ([CardProtocol]).self)
    }
    
    public func setupGame(roles: [Role], cards: [Card], cardSet: [DeckCard], preferredRole: Role?, preferredFigure: String?) -> StateProtocol  {
        return DefaultValueRegistry.defaultValue(for: (StateProtocol).self)
    }
    
}

