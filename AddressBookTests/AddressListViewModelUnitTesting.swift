//
//  AddressListViewModelUnitTesting.swift
//  AddressBookTests
//
//  Created by ZopSmart on 20/03/25.
//
import Foundation
import Testing
@testable import AddressBook


struct AddressListViewModelUnitTesting {
    @Test func test_AddressListViewModel_section_shouldBeTrue() {
        let section: Bool = true
        let mockManager = MockAddressManager()
        let vm: AddressListViewModel = AddressListViewModel(manager: mockManager, section: section)
        #expect(vm.section == true)
    }
    @Test func test_AddressListViewModel_section_shouldBeFalse() {
        let section: Bool = false
        let mockManager = MockAddressManager()
        let vm: AddressListViewModel = AddressListViewModel(manager: mockManager, section: section)
        #expect(vm.section == false)
    }
    @Test func test_AddressListViewModel_fetchAddressList_listShouldBeEmpty() {
        let section: Bool  = false
        let mockManager = MockAddressManager()
        mockManager.mockAddresses = []
        let vm = AddressListViewModel(manager: mockManager, section: section)
        #expect(vm.addresses.count == 0)
    }
    @Test func test_AddressListViewModel_fetchAddressList_listShouldNotBeEmpty() {
        let section: Bool  = false
        let mockManager = MockAddressManager()
        mockManager.mockAddresses.append(AddressModel(id: UUID(), street: "A", city: "B", state: "C", postalcode: "12345", isMailingAddress: true, isCurrent: false))
        let vm = AddressListViewModel(manager: mockManager, section: section)
        #expect(vm.addresses.count != 0)
    }
}
