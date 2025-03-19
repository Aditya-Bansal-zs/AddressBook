//
//  AddressManipulationView.swift
//  DummyAddressBookNew
//
//  Created by ZopSmart on 12/03/25.
//

import SwiftUI

// State Persistence means keeping your data alive even when views disappear and reappear!

struct AddressManipulationView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel: AddressManipulationViewModel
    var onDismiss: () -> Void = {}  //passed from section view

    var body: some View {
        NavigationStack {
            VStack {
                VStack(spacing: 12) {
                    TextFieldView(Title: "Street Address", text: $viewModel.street, fieldType: .street)
                    TextFieldView(Title: "Apartment Address (Optional)", text: $viewModel.apt, fieldType: .apt)
                    TextFieldView(Title: "City", text: $viewModel.city, fieldType: .city)
                    StateDropDownView(state: $viewModel.state)
                    TextFieldView(Title: "Zip Code", text: $viewModel.postalcode, fieldType: .zip)
                    CheckboxView(isChecked: $viewModel.isMailingAddress)
                    Spacer()
                }
                .padding()
                VStack {
                    if viewModel.decider {
                        Button(action: {
                            viewModel.updateAddress()
                            onDismiss()
                            dismiss()
                        }) {
                            Text("Update Address")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.blue)
                                .clipShape(RoundedRectangle(cornerRadius: 30))
                                .padding(.horizontal)
                        }
                        Button(action: {
                            viewModel.deleteAddress()
                            onDismiss()
                            dismiss()
                        }) {
                            Text("Delete Address")
                                .font(.headline)
                                .foregroundColor(.red)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.white)
                                .clipShape(RoundedRectangle(cornerRadius: 30))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 30)
                                        .stroke(Color.red, lineWidth: 2)
                                )
                                .padding(.horizontal)
                        }
                    } else {
                        Button(action: {
                            viewModel.addAddress()
                            dismiss()
                        }) {
                            Text("Add Address")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.blue)
                                .clipShape(RoundedRectangle(cornerRadius: 30))
                                .padding(.horizontal)
                        }
                    }
                }
                .padding(.bottom, 20)
            }
            .navigationTitle(viewModel.decider ? "Edit Address" : "Add Address")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

//
//#Preview {
//    AddressManipulationView()
//}
