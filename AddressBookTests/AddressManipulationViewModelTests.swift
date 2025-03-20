//
//  AddressManipulationViewModelTests.swift
//  AddressBookTests
//
//  Created by ZopSmart on 20/03/25.
//
import Foundation
import Testing
@testable import AddressBook


struct AddressManipulationViewModelTests {
    @Test func test_Initialization_With_Address() {
        let mockManager = MockAddressManager()
        let address = AddressModel(id: UUID(), street: "A",apt: "B", city: "C", state: "D", postalcode: "12345", isMailingAddress: true, isCurrent: false)
        let vm = AddressManipulationViewModel(manager: mockManager,addressToManipulate: address, decider: true)
        #expect(vm.street == "A")
        #expect(vm.apt == "B")
        #expect(vm.city == "C")
        #expect(vm.state == "D")
        #expect(vm.postalcode == "12345")
        #expect(vm.isMailingAddress == true)
        #expect(vm.isCurrent == false)
    }
    @Test func test_AddressManipulationViewModel_Initialization_Without_Address() {
        let mockManager = MockAddressManager()
        
        let vm = AddressManipulationViewModel(manager: mockManager, decider: true)
        #expect(vm.street == "")
        #expect(vm.apt == "")
        #expect(vm.city == "")
        #expect(vm.state == "")
        #expect(vm.postalcode == "")
        #expect(vm.isMailingAddress == false)
        #expect(vm.isCurrent == false)
    }
    
    @Test func test_AddressManipulationViewModel_isAlertShouldTrigger (){
        let vm = AddressManipulationViewModel(decider: true)
        vm.street = ""
        vm.city = "C"
        vm.state = "D"
        vm.postalcode = "12345"
        vm.addAddress()
        #expect(vm.isAlert == true)
    }
    @Test func test_AddressManipulationViewModel_isAlertShouldNotTrigger (){
        let vm = AddressManipulationViewModel(decider: true)
        vm.street = "A"
        vm.city = "C"
        vm.state = "D"
        vm.postalcode = "12345"
        vm.addAddress()
        #expect(vm.isAlert == false)
    }
    
    @Test func test_AddressManipulationViewModel_AddAddress() {
        let mockManager = MockAddressManager()
        let vm = AddressManipulationViewModel(manager: mockManager,decider: true)
        vm.street = "Aa"
        vm.apt = "B"
        vm.city = "C"
        vm.state = "D"
        vm.postalcode = "12345"
        vm.isMailingAddress = true
        vm.isCurrent = true
        vm.addAddress()
        #expect(mockManager.mockAddresses.count == 1)
        #expect(mockManager.mockAddresses.first?.apt == "B")
        #expect(mockManager.mockAddresses.first?.city == "C")
        #expect(mockManager.mockAddresses.first?.state == "D")
        #expect(mockManager.mockAddresses.first?.postalcode == "12345")
        #expect(mockManager.mockAddresses.first?.isMailingAddress == true)
        #expect(mockManager.mockAddresses.first?.isCurrent == true)
    }
    @Test func test_AddressManipulationViewModel_UpdateAddress() {
        let mockManager = MockAddressManager()
        let address = AddressModel(id: UUID(), street: "A", apt: "B", city: "C", state: "D", postalcode: "12345", isMailingAddress: true, isCurrent: true)
        mockManager.addAddress(address)
        let vm = AddressManipulationViewModel(manager: mockManager,addressToManipulate: address, decider: true)
        vm.street = "Aab"
        vm.apt = "Bbb"
        vm.city = "Ccc"
        vm.state = "Ddd"
        vm.postalcode = "12346"
        vm.isMailingAddress = false
        vm.isCurrent = true
        vm.updateAddress()
        #expect(mockManager.mockAddresses.count == 1)
        #expect(mockManager.mockAddresses[0].street == "Aab")
        #expect(mockManager.mockAddresses[0].apt == "Bbb")
        #expect(mockManager.mockAddresses[0].city == "Ccc")
        #expect(mockManager.mockAddresses[0].state == "Ddd")
        #expect(mockManager.mockAddresses[0].postalcode == "12346")
        #expect(mockManager.mockAddresses[0].isMailingAddress == false)
    }
    @Test func test_AddressManipulationViewModel_DeleteAddress() {
        let mockManager = MockAddressManager()
        mockManager.mockAddresses = []
        #expect(mockManager.mockAddresses.count == 0)
        let address = AddressModel(id: UUID(), street: "A", apt: "B", city: "C", state: "D", postalcode: "12345", isMailingAddress: true, isCurrent: true)
        mockManager.addAddress(address)
        let vm = AddressManipulationViewModel(manager: mockManager,addressToManipulate: address, decider: true)
        #expect(mockManager.mockAddresses.count == 1)
        vm.deleteAddress()
        #expect(mockManager.mockAddresses.count == 0)
    }
}
