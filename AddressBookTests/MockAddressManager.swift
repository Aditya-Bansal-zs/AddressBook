//
//  MockAddressManager.swift
//  AddressBookTests
//
//  Created by ZopSmart on 20/03/25.
//

import Foundation
@testable import AddressBook

class MockAddressManager: AddressManagerProtocol {
    var mockAddresses: [AddressBook.AddressModel] = []
    var updateAddressCalled: Bool = false
    var deleteAddressCalled: Bool = false
    var deletedAddress: AddressModel?
    var updateCurrentAddress: AddressModel?
    var updateCurrent: Bool = false
    func addAddress(_ address: AddressBook.AddressModel) {
        mockAddresses.append(address)
    }
    
    func updateAddress(addressToManipulate: AddressBook.AddressModel?, updatedAddress: AddressBook.AddressModel) {
        updateAddressCalled = true
        guard let index = mockAddresses.firstIndex(where: { $0.id == addressToManipulate?.id }) else { return }
        mockAddresses[index] = updatedAddress
    }
    
    func deleteAddress(addressToDelete: AddressBook.AddressModel) {
        deleteAddressCalled = true
        deletedAddress = addressToDelete
        mockAddresses.removeAll(where: { $0.id == addressToDelete.id})
    }
    
    func mapEntityToAddressModel(section: Bool) -> [AddressBook.AddressModel] {
        if section == true {
            return mockAddresses.sorted(by: {$0.isCurrent && !$1.isCurrent})
        }
        return mockAddresses.sorted(by: {$0.isMailingAddress && !$1.isMailingAddress})
    }
    
    func updateCurrent(addressToManipulate: AddressBook.AddressModel?) {
        guard let addressToManipulate,
              let index = mockAddresses.firstIndex(where: { $0.id == addressToManipulate.id }),
              !mockAddresses.isEmpty else { return }
        updateCurrent = true
        updateCurrentAddress = addressToManipulate
        for i in mockAddresses.indices {
            mockAddresses[i].isCurrent = false
        }

        mockAddresses[index].isCurrent = true
    }
}
