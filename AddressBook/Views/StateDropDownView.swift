//
//  StateDropDownView.swift
//  DummyAddressBookNew
//
//  Created by ZopSmart on 12/03/25.
//

import SwiftUI

struct StateDropDownView: View {
    @Environment(\.colorScheme) var colorScheme
    @Binding var state: String
    @StateObject var vm: StateDropDownViewModel

    init(state: Binding<String>) {
        self._state = state
        _vm = StateObject(wrappedValue: StateDropDownViewModel(selectedOption: state.wrappedValue))
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("State")
                .font(.subheadline)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Menu {
                ForEach(vm.indianStates.sorted(by: >), id: \.self) { stateName in
                    Button(stateName) {
                        vm.selectedOption = stateName
                        state = stateName
                    }
                }
            } label: {
                HStack {
                    Text(vm.selectedOption.isEmpty ? "Select an option" : vm.selectedOption)
                        .foregroundStyle(Color.primary)
                    Image(systemName: "chevron.down")
                        .foregroundColor(.gray)
                }
                .padding()
                .frame(maxWidth: 200)
                .background(Color(getBackgroundColor()))
                .cornerRadius(10)
            }
        }
    }
    
    private func getBackgroundColor() -> Color {
        return colorScheme == .dark ? Color.black : Color(.systemGray6)
    }
}


// MARK: - Preview

#Preview {
    @Previewable @State var state: String = "Test"
    StateDropDownView(state: $state)
}
