//
//  AddressListViewModelTests.swift
//  AddressBookTests
//
//  Created by ZopSmart on 20/03/25.
//
import Foundation
import Testing
@testable import AddressBook


enum SectionCases: CaseIterable{
    case sectionTrue
    case sectionFalse
    var sectionValue: Bool {
        switch self {
        case .sectionTrue:
            return true
        case .sectionFalse:
            return false
        }
    }
}

enum AddressListTestCase: CaseIterable {
    case emptyList
    case nonEmptyList
    
    var mockAddresses: [AddressModel] {
        switch self{
        case .emptyList:
            return []
        case .nonEmptyList:
            return [AddressModel(id: UUID(), street: "A", apt: "B", city: "C", state: "D", postalcode: "12345", isMailingAddress: true, isCurrent: false)]
        }
    }
    var expectedCount: Int {
        return mockAddresses.count
    }
}

class AddressListViewModelTests {
    var mockManager: MockAddressManager?

    init() {
        setUp()
    }

    func setUp() {
        mockManager = MockAddressManager()
    }

    func tearDown() {
        mockManager = nil
    }

    @Test("All section cases", arguments: SectionCases.allCases)
    func test_section(_ section: SectionCases) {
        guard let mockManager = mockManager else {
            #expect(Bool(false), "mockManager is not initialized")
            return
        }
        let viewModel: AddressListViewModel = AddressListViewModel(manager: mockManager, section: section.sectionValue)
        #expect(viewModel.section == section.sectionValue)
    }
    
    @Test("All address list cases", arguments: AddressListTestCase.allCases)
    func test_refreshData(_ addresses: AddressListTestCase) {
        guard let mockManager = mockManager else {
            #expect(Bool(false), "mockManager is not initialized")
            return
        }
        let section: Bool  = false
        mockManager.mockAddresses = addresses.mockAddresses
        let viewModel = AddressListViewModel(manager: mockManager, section: section)
        viewModel.refreshData()
        #expect(viewModel.addresses.count == addresses.expectedCount)
    }
    
    @Test("All address list cases", arguments: AddressListTestCase.allCases)
    func test_fetchAddressList(_ addressCase: AddressListTestCase) {
        guard let mockManager = mockManager else {
            #expect(Bool(false), "mockManager is not initialized")
            return
        }
        let section: Bool  = false
        mockManager.mockAddresses = addressCase.mockAddresses
        let viewModel = AddressListViewModel(manager: mockManager , section: section)
        #expect(viewModel.addresses.count == addressCase.expectedCount)
    }
}
