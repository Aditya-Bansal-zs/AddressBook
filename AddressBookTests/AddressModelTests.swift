//
//  AddressModelTests.swift
//  AddressBookTests
//
//  Created by ZopSmart on 24/03/25.
//
import Foundation
import Testing
@testable import AddressBook
struct AddressModelTests {
    @Test func test_hasher() {
        let id1 = UUID()
        let id2 = UUID()
        let address1 = AddressModel(id: id1, street: "A", apt: "B", city: "C", state: "D", postalcode: "12345", isMailingAddress: true, isCurrent: false)
        let address2 = AddressModel(id: id1, street: "A", apt: "B", city: "C", state: "D", postalcode: "12345", isMailingAddress: true, isCurrent: false)
        let address3 = AddressModel(id: id2, street: "AA", apt: "BB", city: "CC", state: "DD", postalcode: "98765", isMailingAddress: true, isCurrent: false)
        var hasher1 = Hasher()
        var hasher2 = Hasher()
        var hasher3 = Hasher()
        address1.hash(into: &hasher1)
        address2.hash(into: &hasher2)
        address3.hash(into: &hasher3)
        let hashValue1 = hasher1.finalize()
        let hashValue2 = hasher2.finalize()
        let hashValue3 = hasher3.finalize()
        #expect(hashValue1 == hashValue2)
        #expect(hashValue1 != hashValue3)
    }
}
