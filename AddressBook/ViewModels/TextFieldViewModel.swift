//
//  TextFieldViewModel.swift
//  DummyAddressBookNew
//
//  Created by ZopSmart on 18/03/25.
//

import Foundation

enum TextFieldType: String {
    case street
    case apt
    case city
    case zip
    
    var placeHolder: String {
        switch self {
        case .street: "Enter street"
        case .apt: "Enter apt"
        case .city: "Enter city"
        case .zip: "Enter zip"
        }
    }
}


class TextFieldViewModel: ObservableObject {
    @Published var isValid: Bool = true
    @Published var firstTime: Bool = true
    @Published var fieldType: TextFieldType
    @Published var Title: String
    init( fieldType: TextFieldType, Title: String) {
        self.fieldType = fieldType
        self.Title = Title
    }
    
    func validation()-> Bool {
        return !isValid && !firstTime
    }
    
    func validateInput(value: String) {
        if fieldType == .zip {
            isValid = value.allSatisfy(\.isNumber) && value.count == 5
        } else {
            isValid = !value.isEmpty
        }
    }
    
    func validationMessage() -> String {
        if fieldType == .zip {
            return "Please enter a valid zip code (5 digits)."
        }
        return "Please enter a valid \(fieldType.rawValue)."
    }
}
