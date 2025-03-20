//
//  AddressManager.swift
//  DummyAddressBookNew
//
//  Created by ZopSmart on 12/03/25.
//

import Foundation
import CoreData

extension Notification.Name {
    static let didUpdateAddresses = Notification.Name("didUpdateAddresses")
}

protocol AddressManagerProtocol {
    func addAddress(_ address: AddressModel)
    func updateAddress(addressToManipulate: AddressModel?, updatedAddress: AddressModel)
    func deleteAddress(addressToDelete: AddressModel)
    func mapEntityToAddressModel(section: Bool) -> [AddressModel]
    func updateCurrent(addressToManipulate:AddressModel?)
}

class AddressManager: AddressManagerProtocol {
    static let shared: AddressManager = AddressManager()
    
    var container: NSPersistentContainer
    var context: NSManagedObjectContext

    private init() {
        container = NSPersistentContainer(name: "AddressDatabase")
        container.loadPersistentStores { (description, error) in
            if let error {
                print("Error in initializing container \(error.localizedDescription).")
            }
        }
        context = container.viewContext
    }

    func fetchAddress(section: Bool) -> [AddressEntity] {
        let request = NSFetchRequest<AddressEntity>(entityName: "AddressEntity")
        var key: String = "isChecked"
        if section {
            key = "isCurrent"
        }
        request.sortDescriptors = [NSSortDescriptor(key: key, ascending: false)]
        do {
            return try context.fetch(request)
        } catch {
            print("Error in fetching address \(error.localizedDescription)")
            return []
        }
    }

    private func updateFlag() {
        let addresses = fetchAddress(section: false)
        for address in addresses  {
            if address.isChecked == true {
                address.isChecked = false
            }
        }
        save()
    }

    func addAddress(_ address: AddressModel) {
        let newAddress = AddressEntity(context: context)
        newAddress.id = address.id
        newAddress.street = address.street
        newAddress.apt = address.apt
        newAddress.city = address.city
        newAddress.state = address.state
        newAddress.postalcode = address.postalcode
        newAddress.isCurrent = false
        if address.isMailingAddress == true{
            print("\(address.street)")
            updateFlag()
        }
        newAddress.isChecked = address.isMailingAddress
        save()
        notifyUpdate()
    }

    func updateAddress(addressToManipulate:AddressModel?,  updatedAddress: AddressModel) {
        guard let addressToManipulate = addressToManipulate else{return}
        let fetchRequest: NSFetchRequest<AddressEntity> = AddressEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", addressToManipulate.id as NSUUID)
        do {
            let results = try context.fetch(fetchRequest)
            if let existingAddress = results.first {
                print("\(existingAddress.isChecked)")
                print("\(updatedAddress.isMailingAddress)")
                existingAddress.street = updatedAddress.street
                existingAddress.apt = updatedAddress.apt
                existingAddress.city = updatedAddress.city
                existingAddress.state = updatedAddress.state
                existingAddress.postalcode = updatedAddress.postalcode
                if updatedAddress.isMailingAddress == true {
                    updateFlag()
                }
                existingAddress.isChecked = updatedAddress.isMailingAddress
                save()
                print("Address updated successfully!")
                notifyUpdate()
            } else {
                print("Address not found in database.")
            }
        } catch {
            print("Error updating address: \(error.localizedDescription)")
        }
    }

    func deleteAddress(addressToDelete: AddressModel) {
        let fetchRequest: NSFetchRequest<AddressEntity> = AddressEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", addressToDelete.id as NSUUID)

        do {
            let results = try context.fetch(fetchRequest)
            if let addressEntity = results.first {
                context.delete(addressEntity)
                save()
                print("Address deleted successfully!")
                notifyUpdate()
            } else {
                print("Address not found in database.")
            }
        } catch {
            print("Error deleting address: \(error.localizedDescription)")
        }
    }
    
    func updateCurrentInDatabase() {
        let addresses = fetchAddress(section: false)
        for address in addresses  {
            if address.isCurrent == true {
                address.isCurrent = false
            }
        }
        save()
    }
    
    func updateCurrent(addressToManipulate:AddressModel?) {
        guard let addressToManipulate = addressToManipulate else{return}
        let fetchRequest: NSFetchRequest<AddressEntity> = AddressEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", addressToManipulate.id as NSUUID)
        do {
            let results = try context.fetch(fetchRequest)
            if let existingAddress = results.first {
                updateCurrentInDatabase()
                existingAddress.isCurrent = true
                save()
                print("notifying update")
                notifyUpdate()
            }
        } catch let error {
            print("Error in updating the check item \(error.localizedDescription)")
        }
    }

    func mapEntityToAddressModel(section: Bool) -> [AddressModel] {
        return fetchAddress(section: section).compactMap { entity in
            guard let storedID = entity.id else {
                print(" Found AddressEntity with nil ID, skipping")
                return nil
            }
            
            return AddressModel(
                id: storedID,
                street: entity.street ?? "",
                apt: entity.apt,
                city: entity.city ?? "",
                state: entity.state ?? "",
                postalcode: entity.postalcode ?? "",
                isMailingAddress: entity.isChecked,
                isCurrent: entity.isCurrent
            )
        }
    }
    private func notifyUpdate() {
        DispatchQueue.main.async {
            NotificationCenter.default.post(name: .didUpdateAddresses, object: nil)
        }
    }


    func save() {
        do {
            try context.save()
            print("Changes saved successfully!")
        } catch {
            print("Error saving data: \(error.localizedDescription)")
        }
    }
}
