//
// Created by Bohigas, Pere for the use in the Swift Island app
// Copyright © 2024 AppTrix AB. All rights reserved.
//

import Foundation
import Testing
@testable import Swift_Island

//extension Tag {
//    @Tag static var common
//}

struct ContactDataTests {
    @Test
    func initialValues() {
        // Write your test here and use APIs like `#expect(...)` to check expected conditions.
        let contact = ContactData(name: "John Doe", company: "Tech Corp", phone: "1234567890", email: "john@example.com", url: "https://example.com")

        #expect(contact.name == "John Doe")
        #expect(contact.company == "Tech Corp")
        #expect(contact.phone == "1234567890")
        #expect(contact.email == "john@example.com")
        #expect(contact.url == "https://example.com")
    }

    @Test
    func vCardGeneration() {
        // TODO: Create a ContactData as SUT and compare with an `expectedVCard` using `#expect`
        let testVCard: String = """
            BEGIN:VCARD
            VERSION:3.0
            
            FN:John Doe
            ORG:Tech Corp
            TEL:1234567890
            EMAIL:john@example.com
            URL:https://example.com
            END:VCARD
            """

        #expect(testVCard == """
            BEGIN:VCARD
            VERSION:3.0
            
            FN:John Doe
            ORG:Tech Corp
            TEL:1234567890
            EMAIL:john@example.com
            URL:https://example.com
            END:VCARD
            """)
    }

    @Test(
        "Check various contact data",
        arguments: [
            ("John Doe", "Tech Corp", "1234567890", "john@example.com", "https://example.com"),
            ("", "", "", "", ""),
            ("Jane", "Startup Inc", "0987654321", "jane@example.com", "https://janesite.com")
        ]
    )
    func base64Encoding(name: String, company: String, phone: String, email: String, url: String) {
        let contact = ContactData(name: name, company: company, phone: phone, email: email, url: url)
        guard
            let data: String = contact.base64Encoded
        else {

        }

        let data = try? JSONEncoder().encode(self)
        return data?.base64EncodedString()

        #expect(contact.base64Encoded == )
    }

//    @Test(
//        "Check various contact data",
//        arguments: [
//            ("John Doe", "Tech Corp", "1234567890", "john@example.com", "https://example.com"),
//            ("", "", "", "", ""),
//            ("Jane", "Startup Inc", "0987654321", "jane@example.com", "https://janesite.com")
//        ]
//    )
    @Test(
        "Base64 Encoding and Decoding",
        arguments: [
            ("John Doe", "Tech Corp", "1234567890", "john@example.com", "https://example.com"),
            ("Jane Doe", "Another Corp", "9876543210", "jane@example.com", "https://another.com"),
            ("Jane", "Startup Inc", "0987654321", "jane@example.com", "https://janesite.com")
        ]
    )
    func testBase64EncodingDecoding(name: String, company: String, phone: String, email: String, url: String) async throws {
        let contact = ContactData(name: name, company: company, phone: phone, email: email, url: url)
        if let base64Encoded = contact.base64Encoded {
            let decodedContact = ContactData(base64Encoded: base64Encoded)
            #expect(decodedContact == contact)
        } else {
            Issue.record("Base64 encoding failed")
        }
    }
}
