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
    func addAddress(_ address: AddressBook.AddressModel) {
        mockAddresses.append(address)
    }
    
    func updateAddress(addressToManipulate: AddressBook.AddressModel?, updatedAddress: AddressBook.AddressModel) {
        guard let index = mockAddresses.firstIndex(where: { $0.id == addressToManipulate?.id }) else { return }
        mockAddresses[index] = updatedAddress
    }
    
    func deleteAddress(addressToDelete: AddressBook.AddressModel) {
        mockAddresses.removeAll(where: { $0.id == addressToDelete.id})
    }
    
    func mapEntityToAddressModel(section: Bool) -> [AddressBook.AddressModel] {
        return section ? mockAddresses.filter { $0.isCurrent } : mockAddresses
    }
    
    func updateCurrent(addressToManipulate: AddressBook.AddressModel?) {
        guard let addressToManipulate,
              let index = mockAddresses.firstIndex(where: { $0.id == addressToManipulate.id }),
              !mockAddresses.isEmpty else { return }

        for i in mockAddresses.indices {
            mockAddresses[i].isCurrent = false
        }

        mockAddresses[index].isCurrent = true
    }
}
