//
//  MockDatabaseReferenceProtocol+Stub.swift
//  WildWestTests
//
//  Created by Hugues Stéphano TELOLAHY on 14/05/2021.
//  Copyright © 2021 creativeGames. All rights reserved.
//

import Cuckoo
import Firebase

extension MockDatabaseReferenceProtocol {
    
    func withDefault() -> MockDatabaseReferenceProtocol {
        stub(self) { mock in
            when(mock).setValue(anyString(), value: any(), withCompletionBlock: any()).then { _, _, block in
                block(nil, DatabaseReference())
            }
            when(mock).observeSingleEvent(anyString(), eventType: any(), with: any(), withCancel: any()).then { _, _, block, _ in
                block(DataSnapshot())
            }
            when(mock).observe(anyString(), eventType: any(), with: any(), withCancel: any()).then { _, _, block, _ in
                block(DataSnapshot())
            }
        }
        return self
    }
    
    func stubObserveSingleEvent(_ path: String, value: Any) {
        stub(self) { mock in
            when(mock).observeSingleEvent(path, eventType: any(), with: any(), withCancel: any()).then { _, _, block, _ in
                block(MockSnapshot(data: value))
            }
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
