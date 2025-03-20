//
//  SectionViewModelTests.swift
//  AddressBookTests
//
//  Created by ZopSmart on 20/03/25.
//
import Foundation
import Testing
@testable import AddressBook

struct SectionViewModelTests {

//    @Test func <#test function name#>() async throws {
//        // Write your test here and use APIs like `#expect(...)` to check expected conditions.
//    }
    @Test func SectionViewModel_Initialization() {
        let mockManager = MockAddressManager()
        mockManager.mockAddresses.append(AddressModel(id: UUID(), street: "A", apt: "B", city: "C", state: "D", postalcode: "12345", isMailingAddress: true, isCurrent: true))
        let vm = SectionViewModel(manager: mockManager)
        #expect(vm.addresses.count == 1)
    }
}
