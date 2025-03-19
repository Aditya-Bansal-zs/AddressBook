//
//  TextFieldView.swift
//  DummyAddressBookNew
//
//  Created by ZopSmart on 12/03/25.
//

import SwiftUI

//enum TextFieldType: String {
//    case street
//    case apt
//    case city
//    case zip
//    
//    var placeHolder: String {
//        switch self {
//        case .street: "Enter street"
//        case .apt: "Enter apt"
//        case .city: "Enter city"
//        case .zip: "Enter zip"
//        }
//    }
//}

struct TextFieldView: View {
    @Binding var text: String
    @StateObject var vm: TextFieldViewModel
    
    init(Title: String, text: Binding<String>, fieldType: TextFieldType) {
        self._text = text
        _vm = StateObject(wrappedValue: TextFieldViewModel(fieldType: fieldType,Title: Title))
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(vm.Title)
                .font(.subheadline)
                .frame(maxWidth: .infinity, alignment: .leading)

            TextField(vm.fieldType.placeHolder, text: $text)
                .padding(.horizontal)
                .frame(height: 40) // Moved outside overlay
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.secondary, style: StrokeStyle(lineWidth: 2))
                )
                .keyboardType(vm.fieldType == .zip ? .numberPad : .default)
                .onChange(of: text) { _ , newValue in
                    vm.firstTime = false
                    print("\(vm.firstTime)")
                    vm.validateInput(value: newValue)
                }

            if vm.validation() {
                Text(vm.validationMessage())
                    .foregroundStyle(Color.red)
            }
        }
    }

//    private var validationMessage: String {
//        if vm.fieldType == .zip {
//            return "Please enter a valid zip code (5 digits)."
//        }
//        return "Please enter a valid \(vm.fieldType.rawValue)."
//    }
}

