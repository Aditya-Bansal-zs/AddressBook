//
//  StateDropDownViewModel.swift
//  DummyAddressBookNew
//
//  Created by ZopSmart on 18/03/25.
//

import Foundation


class StateDropDownViewModel: ObservableObject {
    
    let indianStates = [
        "Andhra Pradesh", "Arunachal Pradesh", "Assam", "Bihar", "Chhattisgarh",
        "Goa", "Gujarat", "Haryana", "Himachal Pradesh", "Jharkhand",
        "Karnataka", "Kerala", "Madhya Pradesh", "Maharashtra", "Manipur",
        "Meghalaya", "Mizoram", "Nagaland", "Odisha", "Punjab",
        "Rajasthan", "Sikkim", "Tamil Nadu", "Telangana", "Tripura",
        "Uttar Pradesh", "Uttarakhand", "West Bengal", "Andaman and Nicobar Islands",
        "Chandigarh", "Dadra and Nagar Haveli and Daman and Diu", "Lakshadweep",
        "Delhi", "Puducherry", "Jammu and Kashmir", "Ladakh"
    ]
    @Published var selectedOption: String
    init(selectedOption: String) {
        self.selectedOption = selectedOption
    }
    
}
