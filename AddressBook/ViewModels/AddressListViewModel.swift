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
    private let manager: AddressManager

    init(manager: AddressManager = .shared,section: Bool) {
        self.manager = manager
        self.section = section
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(refreshData),
            name: .didUpdateAddresses,
            object: nil
        )
//        print("section: \(self.section)")
        addresses =  fetchAddressList()
    }

    @objc func refreshData() {
        addresses = fetchAddressList()
    }

    func fetchAddressList()->[AddressModel] {
//        print("\(self.section)")
        return AddressManager.shared.mapEntityToAddressModel(section: section)
//        print(addresses.first?.isCurrent ?? "No address")
//        print("Fetching addresses...")
    }
}
