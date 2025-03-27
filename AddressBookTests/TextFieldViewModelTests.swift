//
//  TextFieldViewModelTests.swift
//  AddressBookTests
//
//  Created by ZopSmart on 22/03/25.
//

import Testing
@testable import AddressBook

//enum TextFieldTestCases: CaseIterable{
//    case street
//    case apt
//    case city
//    case zip
//    var fieldType: TextFieldType {
//        switch self{
//        case .street:
//            return .street
//        case .apt:
//            return .apt
//        case .city:
//            return .city
//        case .zip:
//            return .zip
//        }
//    }
//    var Title: String {
//        switch self{
//        case .street:
//            return "street"
//        case .apt:
//            return "apt"
//        case .city:
//            return "city"
//        case .zip:
//            return "zip"
//        }
//    }
//    var placeHolder: String {
//        switch self {
//        case .street: "Enter street"
//        case .apt: "Enter apt"
//        case .city: "Enter city"
//        case .zip: "Enter zip"
//        }
//    }
//    var validationMessage: String {
//        switch self{
//        case .street:
//            return "Please enter a valid street."
//        case .apt:
//            return "Please enter a valid apt."
//        case .city:
//            return "Please enter a valid city."
//        case .zip:
//            return "Please enter a valid zip code (5 digits)."
//        }
//    }
//}
//
//enum BooleanTestCase: CaseIterable {
//    case bothTrue
//    case bothFalse
//    case firstTrueSecondFalse
//    case firstFalseSecondTrue
//    var isValid: Bool {
//        switch self{
//        case .bothTrue:
//            return true
//        case .bothFalse:
//            return false
//        case .firstTrueSecondFalse:
//            return true
//        case .firstFalseSecondTrue:
//            return false
//        }
//    }
//    var firstTime: Bool {
//        switch self{
//        case .bothTrue:
//            return true
//        case .bothFalse:
//            return false
//        case .firstTrueSecondFalse:
//            return false
//        case .firstFalseSecondTrue:
//            return true
//        }
//    }
//    var expectedValue: Bool {
//        switch self{
//        case .bothTrue:
//            return false
//        case .bothFalse:
//            return true
//        case .firstTrueSecondFalse:
//            return false
//        case .firstFalseSecondTrue:
//            return false
//        }
//    }
//}
//
//enum validateInputTestCase: CaseIterable{
//    case zipWithValidCount
//    case zipWithNotValidCount
//    case otherWithNotEmptyString
//    case otherWithEmptyString
//    
//    var fieldType: TextFieldType{
//        switch self{
//        case .zipWithValidCount:
//            return .zip
//        case .zipWithNotValidCount:
//            return .zip
//        case .otherWithEmptyString:
//            return .street
//        case .otherWithNotEmptyString:
//            return .street
//        }
//    }
//    var isValid: Bool {
//        switch self{
//        case .zipWithValidCount:
//            return true
//        case .zipWithNotValidCount:
//            return false
//        case .otherWithEmptyString:
//            return false
//        case .otherWithNotEmptyString:
//            return true
//        }
//    }
//    var value: String{
//        switch self{
//        case .zipWithValidCount:
//            return "12234"
//        case .zipWithNotValidCount:
//            return "12"
//        case .otherWithEmptyString:
//            return ""
//        case .otherWithNotEmptyString:
//            return "A"
//        }
//    }
//}
@MainActor
struct TextFieldViewModelTests {
    var viewModel: TextFieldViewModel
    init() {
        viewModel = TextFieldViewModel(fieldType: .apt, Title: "A")
    }
    @Test("Text field view model initialization test",arguments: [
        (textFieldType: TextFieldType.street,Title: "street"),
        (textFieldType: TextFieldType.city, Title: "city"),
        (textFieldType: TextFieldType.apt,Title: "apt"),
        (textFieldType: TextFieldType.zip,Title: "zip"),
    ])
    func test_initialization(textFieldType: TextFieldType, Title: String) {
        let viewModel = TextFieldViewModel(fieldType: textFieldType, Title: Title)
        #expect(viewModel.fieldType == textFieldType)
        #expect(viewModel.Title == Title)
    }
    @Test("Text field view model validation test",arguments: [
        (textFieldType: TextFieldType.street,firstTime: true, isValid: true,expectedValue: false),
        (textFieldType: TextFieldType.city, firstTime: true, isValid: false,expectedValue: false),
        (textFieldType: TextFieldType.apt,firstTime: false, isValid: true,expectedValue: false),
        (textFieldType: TextFieldType.zip,firstTime: false, isValid: false ,expectedValue: true),
    ])
    mutating func test_validation(textFieldType: TextFieldType,firstTime: Bool, isValid: Bool, expectedValue: Bool) {
        viewModel = TextFieldViewModel(fieldType: textFieldType, Title: "A")
        viewModel.isValid = isValid
        viewModel.firstTime = firstTime
        #expect(viewModel.validation() == expectedValue)
    }
    
    @Test("Text field view model validateInput test", arguments: [
        (textFieldType: TextFieldType.street,input: "A", isValid: true),
        (textFieldType: TextFieldType.city, input: "A", isValid: true),
        (textFieldType: TextFieldType.apt,input: "A", isValid: true),
        (textFieldType: TextFieldType.zip,input: "12345", isValid: true ),
        (textFieldType: TextFieldType.street,input: "", isValid: false),
        (textFieldType: TextFieldType.city, input: "", isValid: false),
        (textFieldType: TextFieldType.apt,input: "", isValid: false),
        (textFieldType: TextFieldType.zip,input: "1345", isValid: false )
    ]) mutating func test_validateInput(textFieldType: TextFieldType, input: String, isValid: Bool){
        viewModel = TextFieldViewModel(fieldType: textFieldType, Title: "A")
        viewModel.validateInput(value: input)
        #expect(viewModel.isValid == isValid)
    }
    @Test("Text field view model validationMessage test",arguments: [
        (textFieldType: TextFieldType.street, validationMessage: "Please enter a valid street."),
        (textFieldType: TextFieldType.city, validationMessage: "Please enter a valid city."),
        (textFieldType: TextFieldType.apt, validationMessage: "Please enter a valid apt."),
        (textFieldType: TextFieldType.zip, validationMessage: "Please enter a valid zip code (5 digits).")
    ])
    mutating func test_validationMessage(textFieldType: TextFieldType, validationMessage: String) {
        viewModel = TextFieldViewModel(fieldType: textFieldType, Title: "Test")
        let result: String = viewModel.validationMessage()
        #expect(result == validationMessage)
    }

    @Test("TextFieldType placeholder values", arguments: [
        (textFieldType: TextFieldType.street, expectedPlaceHolder: "Enter street"),
        (textFieldType: TextFieldType.city, expectedPlaceHolder: "Enter city"),
        (textFieldType: TextFieldType.apt, expectedPlaceHolder: "Enter apt"),
        (textFieldType: TextFieldType.zip, expectedPlaceHolder: "Enter zip")
    ])
    func test_PlaceHolderValues(textFieldType: TextFieldType, expectedPlaceHolder: String) {
        let viewModel = TextFieldViewModel(fieldType: textFieldType, Title: "Test")
        #expect(viewModel.fieldType.placeHolder == expectedPlaceHolder)
    }

}
