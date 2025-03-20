//
//  SectionViewModel.swift
//  DummyAddressBookNew
//
//  Created by ZopSmart on 17/03/25.
//

import Foundation

class SectionViewModel: ObservableObject {
    private let manager: AddressManagerProtocol
    @Published var addresses: [AddressModel] = []
    @Published var addressToManipulate: AddressModel? = nil
    
    init(manager: AddressManagerProtocol = AddressManager.shared) {
        self.manager = manager
        fetchAddresses()
    }
    
    func updateCurrent() {
        manager.updateCurrent(addressToManipulate: addressToManipulate)
    }
    
    func tempUpdateCurrent() {
        guard let addressToManipulate else { return }
        print("edit called")
        
        // Find and reset current address
        if let firstIndex = addresses.firstIndex(where: { $0.isCurrent }) {
            addresses[firstIndex] = addresses[firstIndex].withUpdated(isCurrent: false)
        }

        // Find and update selected address
        if let targetIndex = addresses.firstIndex(where: { $0.id == addressToManipulate.id }) {
            addresses[targetIndex] = addresses[targetIndex].withUpdated(isCurrent: true)
        }

        // Sort to keep current address on top
        addresses.sort { $0.isCurrent && !$1.isCurrent }
    }
    
    func updateCurrentAfterEdit() {
        let updatedAddresses = manager.mapEntityToAddressModel(section: true)

        let newAddresses = addresses.map { existingAddress in
            if let updatedAddress = updatedAddresses.first(where: { $0.id == existingAddress.id }) {
                return updatedAddress.withUpdated(isCurrent: true) // Ensure isCurrent is true
            } else {
                return existingAddress
            }
        }

        // Reassign the array to force a UI update
        addresses = newAddresses

        // Ensure addressToManipulate is also updated
        if let selectedAddress = addressToManipulate,
           let updatedSelection = newAddresses.first(where: { $0.id == selectedAddress.id }) {
            addressToManipulate = updatedSelection
        }

        // Force a UI refresh
        objectWillChange.send()
    }
    
    func fetchAddresses() {
        self.addresses = manager.mapEntityToAddressModel(section: true)
    }
    
    func selectAddress(_ address: AddressModel) {
        self.addressToManipulate = address
        DispatchQueue.main.async {
            self.tempUpdateCurrent()
        }
    }
}

