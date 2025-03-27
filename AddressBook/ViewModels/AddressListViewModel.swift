//
//  AddressListViewModel.swift
//  DummyAddressBookNew
//
//  Created by ZopSmart on 12/03/25.
//

import Foundation
import CoreData

class AddressListViewModel: ObservableObject {
    @Published var addresses: [AddressModel] = []
    var section: Bool = false
    private let manager: AddressManagerProtocol

    init(manager:AddressManagerProtocol = AddressManager.shared,section: Bool) {
        self.manager = manager
        self.section = section
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(refreshData),
            name: .didUpdateAddresses,
            object: nil
        )
        addresses =  fetchAddressList()
    }

    @objc func refreshData() {
        addresses = fetchAddressList()
    }

    func fetchAddressList()->[AddressModel] {
        return manager.mapEntityToAddressModel(section: section)
    }
}
