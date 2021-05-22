import Cuckoo
@testable import WildWest

import Firebase
import RxSwift


 class MockDatabaseReferenceProtocol: DatabaseReferenceProtocol, Cuckoo.ProtocolMock {
    
     typealias MocksType = DatabaseReferenceProtocol
    
     typealias Stubbing = __StubbingProxy_DatabaseReferenceProtocol
     typealias Verification = __VerificationProxy_DatabaseReferenceProtocol

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: DatabaseReferenceProtocol?

     func enableDefaultImplementation(_ stub: DatabaseReferenceProtocol) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    

    

    
    
    
     func childByAutoIdKey() -> String {
        
    return cuckoo_manager.call("childByAutoIdKey() -> String",
            parameters: (),
            escapingParameters: (),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.childByAutoIdKey())
        
    }
    
    
    
     func childRef(_ path: String) -> DatabaseReferenceProtocol {
        
    return cuckoo_manager.call("childRef(_: String) -> DatabaseReferenceProtocol",
            parameters: (path),
            escapingParameters: (path),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.childRef(path))
        
    }
    
    
    
     func observeSingleEvent(_ path: String, eventType: DataEventType, with block: @escaping (DataSnapshot) -> Void, withCancel cancelBlock: ((Error) -> Void)?)  {
        
    return cuckoo_manager.call("observeSingleEvent(_: String, eventType: DataEventType, with: @escaping (DataSnapshot) -> Void, withCancel: ((Error) -> Void)?)",
            parameters: (path, eventType, block, cancelBlock),
            escapingParameters: (path, eventType, block, cancelBlock),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.observeSingleEvent(path, eventType: eventType, with: block, withCancel: cancelBlock))
        
    }
    
    
    
     func observe(_ path: String, eventType: DataEventType, with block: @escaping (DataSnapshot) -> Void, withCancel cancelBlock: ((Error) -> Void)?)  {
        
    return cuckoo_manager.call("observe(_: String, eventType: DataEventType, with: @escaping (DataSnapshot) -> Void, withCancel: ((Error) -> Void)?)",
            parameters: (path, eventType, block, cancelBlock),
            escapingParameters: (path, eventType, block, cancelBlock),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.observe(path, eventType: eventType, with: block, withCancel: cancelBlock))
        
    }
    
    
    
     func setValue(_ path: String, value: Any?, withCompletionBlock block: @escaping (Error?, DatabaseReference) -> Void)  {
        
    return cuckoo_manager.call("setValue(_: String, value: Any?, withCompletionBlock: @escaping (Error?, DatabaseReference) -> Void)",
            parameters: (path, value, block),
            escapingParameters: (path, value, block),
            superclassCall:
                
                Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                ,
            defaultCall: __defaultImplStub!.setValue(path, value: value, withCompletionBlock: block))
        
    }
    

	 struct __StubbingProxy_DatabaseReferenceProtocol: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    func childByAutoIdKey() -> Cuckoo.ProtocolStubFunction<(), String> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return .init(stub: cuckoo_manager.createStub(for: MockDatabaseReferenceProtocol.self, method: "childByAutoIdKey() -> String", parameterMatchers: matchers))
	    }
	    
	    func childRef<M1: Cuckoo.Matchable>(_ path: M1) -> Cuckoo.ProtocolStubFunction<(String), DatabaseReferenceProtocol> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: path) { $0 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockDatabaseReferenceProtocol.self, method: "childRef(_: String) -> DatabaseReferenceProtocol", parameterMatchers: matchers))
	    }
	    
	    func observeSingleEvent<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable, M4: Cuckoo.OptionalMatchable>(_ path: M1, eventType: M2, with block: M3, withCancel cancelBlock: M4) -> Cuckoo.ProtocolStubNoReturnFunction<(String, DataEventType, (DataSnapshot) -> Void, ((Error) -> Void)?)> where M1.MatchedType == String, M2.MatchedType == DataEventType, M3.MatchedType == (DataSnapshot) -> Void, M4.OptionalMatchedType == ((Error) -> Void) {
	        let matchers: [Cuckoo.ParameterMatcher<(String, DataEventType, (DataSnapshot) -> Void, ((Error) -> Void)?)>] = [wrap(matchable: path) { $0.0 }, wrap(matchable: eventType) { $0.1 }, wrap(matchable: block) { $0.2 }, wrap(matchable: cancelBlock) { $0.3 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockDatabaseReferenceProtocol.self, method: "observeSingleEvent(_: String, eventType: DataEventType, with: @escaping (DataSnapshot) -> Void, withCancel: ((Error) -> Void)?)", parameterMatchers: matchers))
	    }
	    
	    func observe<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable, M4: Cuckoo.OptionalMatchable>(_ path: M1, eventType: M2, with block: M3, withCancel cancelBlock: M4) -> Cuckoo.ProtocolStubNoReturnFunction<(String, DataEventType, (DataSnapshot) -> Void, ((Error) -> Void)?)> where M1.MatchedType == String, M2.MatchedType == DataEventType, M3.MatchedType == (DataSnapshot) -> Void, M4.OptionalMatchedType == ((Error) -> Void) {
	        let matchers: [Cuckoo.ParameterMatcher<(String, DataEventType, (DataSnapshot) -> Void, ((Error) -> Void)?)>] = [wrap(matchable: path) { $0.0 }, wrap(matchable: eventType) { $0.1 }, wrap(matchable: block) { $0.2 }, wrap(matchable: cancelBlock) { $0.3 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockDatabaseReferenceProtocol.self, method: "observe(_: String, eventType: DataEventType, with: @escaping (DataSnapshot) -> Void, withCancel: ((Error) -> Void)?)", parameterMatchers: matchers))
	    }
	    
	    func setValue<M1: Cuckoo.Matchable, M2: Cuckoo.OptionalMatchable, M3: Cuckoo.Matchable>(_ path: M1, value: M2, withCompletionBlock block: M3) -> Cuckoo.ProtocolStubNoReturnFunction<(String, Any?, (Error?, DatabaseReference) -> Void)> where M1.MatchedType == String, M2.OptionalMatchedType == Any, M3.MatchedType == (Error?, DatabaseReference) -> Void {
	        let matchers: [Cuckoo.ParameterMatcher<(String, Any?, (Error?, DatabaseReference) -> Void)>] = [wrap(matchable: path) { $0.0 }, wrap(matchable: value) { $0.1 }, wrap(matchable: block) { $0.2 }]
	        return .init(stub: cuckoo_manager.createStub(for: MockDatabaseReferenceProtocol.self, method: "setValue(_: String, value: Any?, withCompletionBlock: @escaping (Error?, DatabaseReference) -> Void)", parameterMatchers: matchers))
	    }
	    
	}

	 struct __VerificationProxy_DatabaseReferenceProtocol: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	
	    
	    @discardableResult
	    func childByAutoIdKey() -> Cuckoo.__DoNotUse<(), String> {
	        let matchers: [Cuckoo.ParameterMatcher<Void>] = []
	        return cuckoo_manager.verify("childByAutoIdKey() -> String", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func childRef<M1: Cuckoo.Matchable>(_ path: M1) -> Cuckoo.__DoNotUse<(String), DatabaseReferenceProtocol> where M1.MatchedType == String {
	        let matchers: [Cuckoo.ParameterMatcher<(String)>] = [wrap(matchable: path) { $0 }]
	        return cuckoo_manager.verify("childRef(_: String) -> DatabaseReferenceProtocol", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func observeSingleEvent<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable, M4: Cuckoo.OptionalMatchable>(_ path: M1, eventType: M2, with block: M3, withCancel cancelBlock: M4) -> Cuckoo.__DoNotUse<(String, DataEventType, (DataSnapshot) -> Void, ((Error) -> Void)?), Void> where M1.MatchedType == String, M2.MatchedType == DataEventType, M3.MatchedType == (DataSnapshot) -> Void, M4.OptionalMatchedType == ((Error) -> Void) {
	        let matchers: [Cuckoo.ParameterMatcher<(String, DataEventType, (DataSnapshot) -> Void, ((Error) -> Void)?)>] = [wrap(matchable: path) { $0.0 }, wrap(matchable: eventType) { $0.1 }, wrap(matchable: block) { $0.2 }, wrap(matchable: cancelBlock) { $0.3 }]
	        return cuckoo_manager.verify("observeSingleEvent(_: String, eventType: DataEventType, with: @escaping (DataSnapshot) -> Void, withCancel: ((Error) -> Void)?)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func observe<M1: Cuckoo.Matchable, M2: Cuckoo.Matchable, M3: Cuckoo.Matchable, M4: Cuckoo.OptionalMatchable>(_ path: M1, eventType: M2, with block: M3, withCancel cancelBlock: M4) -> Cuckoo.__DoNotUse<(String, DataEventType, (DataSnapshot) -> Void, ((Error) -> Void)?), Void> where M1.MatchedType == String, M2.MatchedType == DataEventType, M3.MatchedType == (DataSnapshot) -> Void, M4.OptionalMatchedType == ((Error) -> Void) {
	        let matchers: [Cuckoo.ParameterMatcher<(String, DataEventType, (DataSnapshot) -> Void, ((Error) -> Void)?)>] = [wrap(matchable: path) { $0.0 }, wrap(matchable: eventType) { $0.1 }, wrap(matchable: block) { $0.2 }, wrap(matchable: cancelBlock) { $0.3 }]
	        return cuckoo_manager.verify("observe(_: String, eventType: DataEventType, with: @escaping (DataSnapshot) -> Void, withCancel: ((Error) -> Void)?)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	    @discardableResult
	    func setValue<M1: Cuckoo.Matchable, M2: Cuckoo.OptionalMatchable, M3: Cuckoo.Matchable>(_ path: M1, value: M2, withCompletionBlock block: M3) -> Cuckoo.__DoNotUse<(String, Any?, (Error?, DatabaseReference) -> Void), Void> where M1.MatchedType == String, M2.OptionalMatchedType == Any, M3.MatchedType == (Error?, DatabaseReference) -> Void {
	        let matchers: [Cuckoo.ParameterMatcher<(String, Any?, (Error?, DatabaseReference) -> Void)>] = [wrap(matchable: path) { $0.0 }, wrap(matchable: value) { $0.1 }, wrap(matchable: block) { $0.2 }]
	        return cuckoo_manager.verify("setValue(_: String, value: Any?, withCompletionBlock: @escaping (Error?, DatabaseReference) -> Void)", callMatcher: callMatcher, parameterMatchers: matchers, sourceLocation: sourceLocation)
	    }
	    
	}
}

 class DatabaseReferenceProtocolStub: DatabaseReferenceProtocol {
    

    

    
     func childByAutoIdKey() -> String  {
        return DefaultValueRegistry.defaultValue(for: (String).self)
    }
    
     func childRef(_ path: String) -> DatabaseReferenceProtocol  {
        return DefaultValueRegistry.defaultValue(for: (DatabaseReferenceProtocol).self)
    }
    
     func observeSingleEvent(_ path: String, eventType: DataEventType, with block: @escaping (DataSnapshot) -> Void, withCancel cancelBlock: ((Error) -> Void)?)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func observe(_ path: String, eventType: DataEventType, with block: @escaping (DataSnapshot) -> Void, withCancel cancelBlock: ((Error) -> Void)?)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
     func setValue(_ path: String, value: Any?, withCompletionBlock block: @escaping (Error?, DatabaseReference) -> Void)   {
        return DefaultValueRegistry.defaultValue(for: (Void).self)
    }
    
}


import Cuckoo
@testable import WildWest

import WildWestEngine


 class MockUserPreferencesProtocol: UserPreferencesProtocol, Cuckoo.ProtocolMock {
    
     typealias MocksType = UserPreferencesProtocol
    
     typealias Stubbing = __StubbingProxy_UserPreferencesProtocol
     typealias Verification = __VerificationProxy_UserPreferencesProtocol

     let cuckoo_manager = Cuckoo.MockManager.preconfiguredManager ?? Cuckoo.MockManager(hasParent: false)

    
    private var __defaultImplStub: UserPreferencesProtocol?

     func enableDefaultImplementation(_ stub: UserPreferencesProtocol) {
        __defaultImplStub = stub
        cuckoo_manager.enableDefaultStubImplementation()
    }
    

    
    
    
     var playersCount: Int {
        get {
            return cuckoo_manager.getter("playersCount",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.playersCount)
        }
        
        set {
            cuckoo_manager.setter("playersCount",
                value: newValue,
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.playersCount = newValue)
        }
        
    }
    
    
    
     var preferredRole: Role? {
        get {
            return cuckoo_manager.getter("preferredRole",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.preferredRole)
        }
        
        set {
            cuckoo_manager.setter("preferredRole",
                value: newValue,
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.preferredRole = newValue)
        }
        
    }
    
    
    
     var preferredFigure: String? {
        get {
            return cuckoo_manager.getter("preferredFigure",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.preferredFigure)
        }
        
        set {
            cuckoo_manager.setter("preferredFigure",
                value: newValue,
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.preferredFigure = newValue)
        }
        
    }
    
    
    
     var updateDelay: Double {
        get {
            return cuckoo_manager.getter("updateDelay",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.updateDelay)
        }
        
    }
    
    
    
     var assistedMode: Bool {
        get {
            return cuckoo_manager.getter("assistedMode",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.assistedMode)
        }
        
    }
    
    
    
     var enableSound: Bool {
        get {
            return cuckoo_manager.getter("enableSound",
                superclassCall:
                    
                    Cuckoo.MockManager.crashOnProtocolSuperclassCall()
                    ,
                defaultCall: __defaultImplStub!.enableSound)
        }
        
    }
    

    

    

	 struct __StubbingProxy_UserPreferencesProtocol: Cuckoo.StubbingProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	
	     init(manager: Cuckoo.MockManager) {
	        self.cuckoo_manager = manager
	    }
	    
	    
	    var playersCount: Cuckoo.ProtocolToBeStubbedProperty<MockUserPreferencesProtocol, Int> {
	        return .init(manager: cuckoo_manager, name: "playersCount")
	    }
	    
	    
	    var preferredRole: Cuckoo.ProtocolToBeStubbedOptionalProperty<MockUserPreferencesProtocol, Role> {
	        return .init(manager: cuckoo_manager, name: "preferredRole")
	    }
	    
	    
	    var preferredFigure: Cuckoo.ProtocolToBeStubbedOptionalProperty<MockUserPreferencesProtocol, String> {
	        return .init(manager: cuckoo_manager, name: "preferredFigure")
	    }
	    
	    
	    var updateDelay: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockUserPreferencesProtocol, Double> {
	        return .init(manager: cuckoo_manager, name: "updateDelay")
	    }
	    
	    
	    var assistedMode: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockUserPreferencesProtocol, Bool> {
	        return .init(manager: cuckoo_manager, name: "assistedMode")
	    }
	    
	    
	    var enableSound: Cuckoo.ProtocolToBeStubbedReadOnlyProperty<MockUserPreferencesProtocol, Bool> {
	        return .init(manager: cuckoo_manager, name: "enableSound")
	    }
	    
	    
	}

	 struct __VerificationProxy_UserPreferencesProtocol: Cuckoo.VerificationProxy {
	    private let cuckoo_manager: Cuckoo.MockManager
	    private let callMatcher: Cuckoo.CallMatcher
	    private let sourceLocation: Cuckoo.SourceLocation
	
	     init(manager: Cuckoo.MockManager, callMatcher: Cuckoo.CallMatcher, sourceLocation: Cuckoo.SourceLocation) {
	        self.cuckoo_manager = manager
	        self.callMatcher = callMatcher
	        self.sourceLocation = sourceLocation
	    }
	
	    
	    
	    var playersCount: Cuckoo.VerifyProperty<Int> {
	        return .init(manager: cuckoo_manager, name: "playersCount", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var preferredRole: Cuckoo.VerifyOptionalProperty<Role> {
	        return .init(manager: cuckoo_manager, name: "preferredRole", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var preferredFigure: Cuckoo.VerifyOptionalProperty<String> {
	        return .init(manager: cuckoo_manager, name: "preferredFigure", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var updateDelay: Cuckoo.VerifyReadOnlyProperty<Double> {
	        return .init(manager: cuckoo_manager, name: "updateDelay", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var assistedMode: Cuckoo.VerifyReadOnlyProperty<Bool> {
	        return .init(manager: cuckoo_manager, name: "assistedMode", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	    
	    var enableSound: Cuckoo.VerifyReadOnlyProperty<Bool> {
	        return .init(manager: cuckoo_manager, name: "enableSound", callMatcher: callMatcher, sourceLocation: sourceLocation)
	    }
	    
	
	    
	}
}

 class UserPreferencesProtocolStub: UserPreferencesProtocol {
    
    
     var playersCount: Int {
        get {
            return DefaultValueRegistry.defaultValue(for: (Int).self)
        }
        
        set { }
        
    }
    
    
     var preferredRole: Role? {
        get {
            return DefaultValueRegistry.defaultValue(for: (Role?).self)
        }
        
        set { }
        
    }
    
    
     var preferredFigure: String? {
        get {
            return DefaultValueRegistry.defaultValue(for: (String?).self)
        }
        
        set { }
        
    }
    
    
     var updateDelay: Double {
        get {
            return DefaultValueRegistry.defaultValue(for: (Double).self)
        }
        
    }
    
    
     var assistedMode: Bool {
        get {
            return DefaultValueRegistry.defaultValue(for: (Bool).self)
        }
        
    }
    
    
     var enableSound: Bool {
        get {
            return DefaultValueRegistry.defaultValue(for: (Bool).self)
        }
        
    }
    

    

    
}

