//
//  AddressManipulationViewModel.swift
//  DummyAddressBookNew
//
//  Created by ZopSmart on 12/03/25.
//

import Foundation
import CoreData

class AddressManipulationViewModel: ObservableObject {
    var addressToManipulate: AddressModel?
    var decider: Bool = false
    private let manager: AddressManager
    
    @Published var street: String = ""
    @Published var apt: String = ""
    @Published var city: String = ""
    @Published var state: String = ""
    @Published var postalcode: String = ""
    @Published var isMailingAddress: Bool = false
    @Published var isCurrent: Bool = false

    init(manager: AddressManager = .shared,
         addressToManipulate: AddressModel? = nil,
         decider: Bool) {
        self.manager = manager
        self.addressToManipulate = addressToManipulate
        self.decider = decider
        self.street = addressToManipulate?.street ?? ""
        self.apt = addressToManipulate?.apt ?? ""  
        self.city = addressToManipulate?.city ?? ""
        self.state = addressToManipulate?.state ?? ""
        self.postalcode = addressToManipulate?.postalcode ?? ""
        self.isMailingAddress = addressToManipulate?.isMailingAddress ?? false

    }

//    private var isValidAddress: Bool {
//        !street.isEmpty && !city.isEmpty && !state.isEmpty && postalcode.count == 5
//    }

    func addAddress() {
        let newAddress = AddressModel(
            id: UUID(),
            street: street,
            apt: apt,
            city: city,
            state: state,
            postalcode: postalcode,
            isMailingAddress: isMailingAddress,
            isCurrent: isCurrent
        )
        manager.addAddress(newAddress)
    }

    func updateAddress() {
        let updatedAddress = AddressModel(
            id: UUID(),
            street: street,
            apt: apt,
            city: city,
            state: state,
            postalcode: postalcode,
            isMailingAddress: isMailingAddress,
            isCurrent: isCurrent
        )
        print("Mailing Address \(updatedAddress.isMailingAddress)")
        manager.updateAddress(addressToManipulate: addressToManipulate, updatedAddress: updatedAddress)
    }

    func deleteAddress() {
        guard let address = addressToManipulate else{return}
        manager.deleteAddress(addressToDelete: address)
    }
}
