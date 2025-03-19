//
//  AddressModel.swift
//  DummyAddressBookNew
//
//  Created by ZopSmart on 12/03/25.
//

import Foundation

//use to return addressmodel
extension AddressModel {
    func withUpdated(isCurrent: Bool) -> AddressModel {
        return AddressModel(
            id: self.id,
            street: self.street,
            apt: self.apt,
            city: self.city,
            state: self.state,
            postalcode: self.postalcode,
            isMailingAddress: self.isMailingAddress,
            isCurrent: isCurrent
        )
    }
}

struct AddressModel: Identifiable, Hashable, Equatable {
    var id: UUID  // Ensure it's a UUID for unique identity
    var street: String
    var apt: String?
    var city: String
    var state: String
    var postalcode: String
    var isMailingAddress: Bool
    var isCurrent: Bool

    init(id: UUID, street: String, apt: String? = nil, city: String, state: String, postalcode: String, isMailingAddress: Bool, isCurrent: Bool) {
        self.id = id
        self.street = street
        self.apt = apt
        self.city = city
        self.state = state
        self.postalcode = postalcode
        self.isMailingAddress = isMailingAddress
        self.isCurrent = isCurrent
    }

    // Implement Equatable manually
    static func == (lhs: AddressModel, rhs: AddressModel) -> Bool {
        return lhs.id == rhs.id
    }

    // Implement Hashable manually
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
