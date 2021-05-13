//
//  MockDatabaseReference.swift
//  WildWestTests
//
//  Created by Hugues Stéphano TELOLAHY on 12/05/2021.
//  Copyright © 2021 creativeGames. All rights reserved.
//

import Firebase

class MockDatabaseReference: DatabaseReference {
    
    var settedValues: [String: Any] = [:]
    var returnedValues: [String: Any] = [:]
    
    private var requestedPaths: [String] = []
    private var autoId = 0
    
    override var key: String? {
        "\(autoId)"
    }
    
    override func child(_ pathString: String) -> DatabaseReference {
        requestedPaths.append(pathString)
        return self
    }
    
    override func childByAutoId() -> DatabaseReference {
        autoId += 1
        return self
    }
    
    override func observeSingleEvent(of eventType: DataEventType,
                                     with block: @escaping (DataSnapshot) -> Void,
                                     withCancel cancelBlock: ((Error) -> Void)? = nil) {
        let pathString = requestedPaths.remove(at: 0)
        let snapshot = MockSnapshot(data: returnedValues[pathString])
        DispatchQueue.global().async {
            block(snapshot)
        }
    }
    
    override func setValue(_ value: Any?, withCompletionBlock block: @escaping (Error?, DatabaseReference) -> Void) {
        let pathString = requestedPaths.remove(at: 0)
        settedValues[pathString] = value
        DispatchQueue.global().async {
            block(nil, self)
        }
    }
}

private class MockSnapshot: DataSnapshot {
    
    private var data: Any?
    
    convenience init(data: Any?) {
        self.init()
        self.data = data
    }
    
    override var value: Any? {
        data
    }
}
