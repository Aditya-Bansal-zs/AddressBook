//
//  AddressListViewModelTests.swift
//  AddressBookTests
//
//  Created by ZopSmart on 20/03/25.
//
import Foundation
import Testing
@testable import AddressBook


@MainActor
struct AddressListViewModelTests {
    var mockManager: MockAddressManager?
    var viewModel: AddressListViewModel!

    init() {
        mockManager = MockAddressManager()
        viewModel = AddressListViewModel(manager: mockManager!, section: false)
    }

    @Test("All section cases", arguments: [
        true, false
    ])
    func test_section(section: Bool) {
        guard let mockManager = mockManager else {
            #expect(Bool(false), "mockManager is not initialized")
            return
        }
        let viewModel: AddressListViewModel = AddressListViewModel(manager: mockManager, section: section)
        #expect(viewModel.section == section)
    }
    
    @Test("All address list cases", arguments: [
        ([],0),([AddressModel(id: UUID(), street: "A", apt: "B", city: "C", state: "D", postalcode: "12345", isMailingAddress: true, isCurrent: false)],1)
    ])
    func test_refreshData(addresses: [AddressModel],expectedCount: Int) {
        guard let mockManager = mockManager else {
            #expect(Bool(false), "mockManager is not initialized")
            return
        }
        let section: Bool  = false
        mockManager.mockAddresses = addresses
        let viewModel = AddressListViewModel(manager: mockManager, section: section)
        viewModel.refreshData()
        #expect(viewModel.addresses.count == expectedCount)
    }
    
    @Test("All address list cases", arguments: [
        ([],0),([AddressModel(id: UUID(), street: "A", apt: "B", city: "C", state: "D", postalcode: "12345", isMailingAddress: true, isCurrent: false)],1)
    ])
    func test_fetchAddressList(addresses: [AddressModel], expectedCount: Int) {
        guard let mockManager = mockManager else {
            #expect(Bool(false), "mockManager is not initialized")
            return
        }
        let section: Bool  = false
        mockManager.mockAddresses = addresses
        let viewModel = AddressListViewModel(manager: mockManager , section: section)
        #expect(viewModel.addresses.count == expectedCount)
    }
}
