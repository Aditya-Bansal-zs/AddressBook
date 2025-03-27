//
//  AddressManipulationViewModelTests.swift
//  AddressBookTests
//
//  Created by ZopSmart on 20/03/25.
//
import Foundation
import Testing
@testable import AddressBook

@MainActor
struct AddressManipulationViewModelTests {
    var mockManager: MockAddressManager!
    var viewModel: AddressManipulationViewModel!
    
    init() {
        self.mockManager = MockAddressManager()
        self.viewModel = AddressManipulationViewModel(manager: mockManager,addressToManipulate: AddressModel(
            id: UUID(),
            street: "A",
            apt: "B",
            city: "C",
            state: "D",
            postalcode: "12345",
            isMailingAddress: true,
            isCurrent: false
        ), decider: true)
    }
    
    @Test("Initialization all test case", arguments: [
        AddressModel(
            id: UUID(),
            street: "A",
            apt: "B",
            city: "C",
            state: "D",
            postalcode: "12345",
            isMailingAddress: true,
            isCurrent: false
        ),
        AddressModel(
            id: UUID(),
            street: "",
            apt: "",
            city: "",
            state: "",
            postalcode: "",
            isMailingAddress: false,
            isCurrent: false
        )
    ])
    mutating func test_Initialization(addressToManipulate: AddressModel) {
        guard let mockManager = mockManager else {
            #expect(Bool(false), "mockManager is not initialized")
            return
        }
        viewModel = AddressManipulationViewModel(manager: mockManager,addressToManipulate: addressToManipulate, decider: true)
        #expect(viewModel.street == addressToManipulate.street)
        #expect(viewModel.apt == addressToManipulate.apt)
        #expect(viewModel.city == addressToManipulate.city)
        #expect(viewModel.state == addressToManipulate.state)
        #expect(viewModel.postalcode == addressToManipulate.postalcode)
        #expect(viewModel.isMailingAddress == addressToManipulate.isMailingAddress)
        #expect(viewModel.isCurrent == addressToManipulate.isCurrent)
    }
    @Test("Initialization all test case", arguments: [
       ( AddressModel(
            id: UUID(),
            street: "A",
            apt: "B",
            city: "C",
            state: "D",
            postalcode: "12345",
            isMailingAddress: true,
            isCurrent: false
       ),false),
        (AddressModel(
            id: UUID(),
            street: "",
            apt: "",
            city: "",
            state: "",
            postalcode: "",
            isMailingAddress: false,
            isCurrent: false
        ),true)
    ])
    mutating func test_isAlert (address: AddressModel, expectedValue: Bool){
        guard let mockManager = mockManager else {
            #expect(Bool(false), "mockManager is not initialized")
            return
        }
        viewModel = AddressManipulationViewModel(manager: mockManager,addressToManipulate: address, decider: true)
        viewModel.addAddress()
        #expect(viewModel.isAlert == expectedValue)
    }
    @Test("Initialization all test case", arguments: [
        ( AddressModel(
             id: UUID(),
             street: "A",
             apt: "B",
             city: "C",
             state: "D",
             postalcode: "12345",
             isMailingAddress: true,
             isCurrent: false
        ),1),
         (nil ,0)
     ])
    mutating func test_addAddress (address: AddressModel?, expectedCount: Int){
        guard let mockManager = mockManager else {
            #expect(Bool(false), "mockManager is not initialized")
            return
        }
        viewModel = AddressManipulationViewModel(manager: mockManager,addressToManipulate: address, decider: true)
        viewModel.addAddress()
        #expect(mockManager.mockAddresses.count == expectedCount)
    }
    @Test("Initialization all test case", arguments: [
         (AddressModel(
             id: UUID(),
             street: "A",
             apt: "B",
             city: "C",
             state: "D",
             postalcode: "12345",
             isMailingAddress: true,
             isCurrent: false
         ),true),
         (nil,false)
     ])
    mutating func test_updateAddress (address: AddressModel?, expectedValue: Bool) {
        guard let mockManager = mockManager else {
            #expect(Bool(false), "mockManager is not initialized")
            return
        }
        viewModel = AddressManipulationViewModel(manager: mockManager,addressToManipulate: address, decider: true)
        viewModel.updateAddress()
        #expect(viewModel.isAlert == !expectedValue)
        #expect(mockManager.updateAddressCalled == expectedValue)
    }
    @Test("Initialization all test case", arguments: [
        (AddressModel(
            id: UUID(),
            street: "A",
            apt: "B",
            city: "C",
            state: "D",
            postalcode: "12345",
            isMailingAddress: true,
            isCurrent: false
        ),true),
        (nil,false)
    ])
    mutating func test_deleteAddress (address: AddressModel?, expectedValue: Bool) {
        guard let mockManager = mockManager else {
            #expect(Bool(false), "mockManager is not initialized")
            return
        }
        viewModel = AddressManipulationViewModel(manager: mockManager,addressToManipulate: address, decider: true)
        viewModel.deleteAddress()
        #expect(mockManager.deleteAddressCalled == expectedValue)
    }
}
