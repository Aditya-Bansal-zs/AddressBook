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
    var mockManager: MockAddressManager?
    var viewModel: SectionViewModel!
    static let sharedUUID: UUID = UUID()
    init() {
        mockManager = MockAddressManager()
        viewModel = SectionViewModel(manager: mockManager!)
    }
    
    @Test("Section view model initialization.", arguments: [
       ( [],0),
        ([AddressModel(id: UUID(), street: "A", apt: "B", city: "C", state: "D", postalcode: "12345", isMailingAddress: true, isCurrent: false)],1),
        ([AddressModel(id: UUID(), street: "Aa", apt: "Ba", city: "Ca", state: "Da", postalcode: "22345", isMailingAddress: true, isCurrent: false),AddressModel(id: UUID(), street: "A", apt: "B", city: "C", state: "D", postalcode: "12345", isMailingAddress: true, isCurrent: false)],2)
    ])
    mutating func test_Initialization(addresses: [AddressModel],expectedCount: Int) {
        guard let mockManager = mockManager else {
            #expect(Bool(false), "mockManager is not initialized")
            return
        }
        mockManager.mockAddresses = addresses
        viewModel = SectionViewModel(manager: mockManager)
        #expect(mockManager.mockAddresses.count == expectedCount)
        #expect(viewModel.addresses.count == expectedCount)
    }
    
    @Test("Section view model update current function.", arguments: [
        ( [],nil),
        ([AddressModel(id: sharedUUID, street: "Aa", apt: "Ba", city: "Ca", state: "Da", postalcode: "22345", isMailingAddress: true, isCurrent: false),AddressModel(id: UUID(), street: "A", apt: "B", city: "C", state: "D", postalcode: "12345", isMailingAddress: true, isCurrent: false)],AddressModel(id: sharedUUID, street: "Aa", apt: "Ba", city: "Ca", state: "Da", postalcode: "22345", isMailingAddress: true, isCurrent: false))
     ])
    mutating func test_UpdateCurrent(addresses: [AddressModel],addressToManipulate: AddressModel?){
        guard let mockManager = mockManager else {
            #expect(Bool(false), "mockManager is not initialized")
            return
        }
        mockManager.mockAddresses = addresses
        viewModel = SectionViewModel(manager: mockManager)
        viewModel.addressToManipulate = addressToManipulate
        viewModel.updateCurrent()
        if mockManager.mockAddresses.count > 0 {
            #expect(mockManager.mockAddresses.first?.isCurrent == true)
            #expect(mockManager.mockAddresses.last?.isCurrent == false)
        } else {
            #expect(mockManager.updateCurrent == false)
        }
    }
    @Test("Section view model temp update current function.", arguments: [
        ( [],nil),
        ([AddressModel(id: sharedUUID, street: "Aa", apt: "Ba", city: "Ca", state: "Da", postalcode: "22345", isMailingAddress: true, isCurrent: false),AddressModel(id: UUID(), street: "A", apt: "B", city: "C", state: "D", postalcode: "12345", isMailingAddress: true, isCurrent: true)],AddressModel(id: sharedUUID, street: "Aa", apt: "Ba", city: "Ca", state: "Da", postalcode: "22345", isMailingAddress: true, isCurrent: true))
     ])
    mutating func test_tempUpdateCurrent(addresses: [AddressModel], addressToManipulate: AddressModel?) {
        guard let mockManager = mockManager else {
            #expect(Bool(false), "mockManager is not initialized")
            return
        }
        mockManager.mockAddresses = addresses
        viewModel = SectionViewModel(manager: mockManager)
        viewModel.addressToManipulate = addressToManipulate
        viewModel.fetchAddresses()
        let firstAddress = viewModel.addresses.first
        viewModel.tempUpdateCurrent()
        if viewModel.addresses.count > 0 {
            #expect(viewModel.addressToManipulate?.id == viewModel.addresses.first?.id)
            
            #expect(viewModel.addresses.first?.isCurrent == true)
            #expect(viewModel.addresses[1].isCurrent == false)
            #expect(viewModel.addresses.first?.id != firstAddress?.id)
        }
    }
    @Test("Section view model temp update current function.", arguments: [
        ( [],nil),
        ([AddressModel(id: sharedUUID, street: "Aa", apt: "Ba", city: "Ca", state: "Da", postalcode: "22345", isMailingAddress: true, isCurrent: false),AddressModel(id: UUID(), street: "A", apt: "B", city: "C", state: "D", postalcode: "12345", isMailingAddress: true, isCurrent: true)],AddressModel(id: sharedUUID, street: "Aa", apt: "Ba", city: "Ca", state: "Da", postalcode: "22345", isMailingAddress: true, isCurrent: false))
     ])
    mutating func test_updateCurrentAfterEdit(addresses: [AddressModel], addressToManipulate: AddressModel?){
        guard let mockManager = mockManager else {
            #expect(Bool(false), "mockManager is not initialized")
            return
        }
        mockManager.mockAddresses = addresses
        viewModel = SectionViewModel(manager: mockManager)
        viewModel.addresses = addresses
        viewModel.addressToManipulate = addressToManipulate
        viewModel.updateCurrentAfterEdit()
        if  mockManager.mockAddresses.count > 0{
            #expect(viewModel.addresses.last?.isCurrent == false)
            
            #expect(mockManager.mockAddresses.first?.isCurrent == false)
            #expect(viewModel.addressToManipulate?.id == mockManager.mockAddresses.first?.id)
            #expect(viewModel.addressToManipulate?.isCurrent == true)
            #expect(viewModel.addresses.count != 0)
            #expect(viewModel.addresses.first?.isCurrent == true)
            #expect(viewModel.addresses.first?.id == addressToManipulate?.id)
        }
    }
    @Test("SectionViewModel updateCurrentAfterEdit function.", arguments: [
        ( [],nil),
        ([AddressModel(id: sharedUUID, street: "Aa", apt: "Ba", city: "Ca", state: "Da", postalcode: "22345", isMailingAddress: true, isCurrent: false),AddressModel(id: UUID(), street: "A", apt: "B", city: "C", state: "D", postalcode: "12345", isMailingAddress: true, isCurrent: true)],AddressModel(id: sharedUUID, street: "Aa", apt: "Ba", city: "Ca", state: "Da", postalcode: "22345", isMailingAddress: true, isCurrent: false))
     ])
    mutating func test_selectAddress(addresses: [AddressModel], addressToManipulate: AddressModel?) async {
        // Ensure the mock manager is available
        guard let mockManager = mockManager else {
            #expect(Bool(false), "mockManager is not initialized")
            return
        }
        viewModel = SectionViewModel(manager: mockManager)
        viewModel.addresses = addresses
        let addressToSelect = addressToManipulate

        if let addressToSelect = addressToSelect, !viewModel.addresses.isEmpty {
            // Act - Select the address
            viewModel.selectAddress(addressToSelect)

            // Allow async operation to complete
            try? await Task.sleep(nanoseconds: 500_000_000) // 0.5 seconds

            // Assert
            #expect(viewModel.addressToManipulate == addressToSelect)
            
        }
    }
}
