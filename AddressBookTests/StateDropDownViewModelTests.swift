//
//  StateDropDownViewModelTests.swift
//  AddressBookTests
//
//  Created by ZopSmart on 21/03/25.
//

import Testing
@testable import AddressBook

@MainActor
struct StateDropDownViewModelTests {
    var mockManager: MockAddressManager?
    var viewModel: StateDropDownViewModel!
    init() {
        mockManager = MockAddressManager()
        viewModel = StateDropDownViewModel(selectedOption: "A")
    }
    
    @Test("State drop down view model initialization",arguments: [
        "A",
        "Select an option"
    ])
    mutating func test_initialization(text: String){
        guard let mockManager = mockManager else {
            #expect(Bool(false), "mockManager is not initialized")
            return
        }
        viewModel = StateDropDownViewModel(selectedOption: text)
        #expect(viewModel.selectedOption == text)
        #expect(viewModel.indianStates.count > 0)
        
    }
}
