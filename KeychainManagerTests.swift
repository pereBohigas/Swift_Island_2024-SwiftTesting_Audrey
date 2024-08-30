//
// Created by Bohigas, Pere for the use in the Swift Island app
// Copyright © 2024 AppTrix AB. All rights reserved.
//

import Foundation
import Testing
@testable import Swift_Island

@Suite
struct KeychainManagerTests {
    private var mockManager: MockKeychainManager!

    init() {
        mockManager = MockKeychainManager()
    }

    struct TestObject: Codable, Equatable {
        let id: Int
        let name: String
    }

    @Test
    func testStoreAndRetrieveDecodableObject() throws {
        //TODO: Test storing and retrieving of decodable object `TestObject`

        // Given
        let testKey = KeychainAttrAccount.tickets
        let testObject = TestObject(id: 1, name: "SampleObject")

        // TODO: Ensure key doesn't exist before storing by using #require macro
        try #require(mockManager.get(key: testKey) == nil)

        try mockManager.store(key: testKey, data: testObject)

        let retrievedObject: TestObject? = try mockManager.get(key: testKey)
        #expect(retrievedObject == testObject)
    }
}
