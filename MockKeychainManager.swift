//
// Created by Bohigas, Pere for the use in the Swift Island app
// Copyright © 2024 AppTrix AB. All rights reserved.
//
import Foundation
@testable import Swift_Island

class MockKeychainManager: KeychainManaging {
    private var storage: [String: Data] = [:]

    func get(key: KeychainAttrAccount) throws -> String? {
        guard let data = storage[key.rawValue], let value = String(data: data, encoding: .utf8) else { return nil }
        return value
    }

    func get<T: Decodable>(key: KeychainAttrAccount) throws -> T? {
        guard let data = storage[key.rawValue] else { return nil }
        return try JSONDecoder().decode(T.self, from: data)
    }

    func delete(key: KeychainAttrAccount) throws {
        storage[key.rawValue] = nil
    }

    func store<T: Encodable>(key: KeychainAttrAccount, data: T) throws {
        let encodedData = try JSONEncoder().encode(data)
        storage[key.rawValue] = encodedData
    }
}
