//
//  SectionView.swift
//  DummyAddressBookNew
//
//  Created by ZopSmart on 12/03/25.
//

import SwiftUI

struct SectionView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var isNavigating: Bool = false
    @StateObject var viewModelSection: SectionViewModel

    var body: some View {
        VStack(spacing: 10) {
            if let firstAddress = viewModelSection.addresses.first, firstAddress.isCurrent == true {
                Section(header: sectionHeader(title: "Current Address")) {
                    addressCardView(for: firstAddress)
                }
                
                if viewModelSection.addresses.count > 1 {
                    Section(header: sectionHeader(title: "Other Addresses")) {
                        ForEach(viewModelSection.addresses.dropFirst(), id: \.self) { address in
                            addressCardView(for: address)
                        }
                    }
                }
            }
            else {
                ScrollView {
                    ForEach(viewModelSection.addresses, id: \.id) { address in
                        addressCardView(for: address)
                    }
                }
            }

            Spacer()

            // Show buttons below the selected address
            if viewModelSection.addressToManipulate != nil {
                VStack(spacing: 20) {
                    Button {
                        confirmSelectedAddress()
                    } label: {
                        Text("Confirm Address")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .clipShape(RoundedRectangle(cornerRadius: 30))
                            .padding(.horizontal)
                    }
    
                    Button {
                        isNavigating = true
                    } label: {
                        Text("Edit")
                            .font(.headline)
                            .foregroundColor(.blue)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 30))
                            .overlay(
                                RoundedRectangle(cornerRadius: 30)
                                    .stroke(Color.blue, lineWidth: 2)
                            )
                            .padding(.horizontal)
                    }
                }
                .padding()
            }
        }
        .sheet(isPresented: $isNavigating, onDismiss: {
            viewModelSection.updateCurrentAfterEdit()
        }) {
            if let address = viewModelSection.addressToManipulate {
                NavigationStack {
                    VStack {
                        AddressManipulationView(viewModel: AddressManipulationViewModel(
                            addressToManipulate: address,
                            decider: true
                        ))
                        
                        .toolbar {
                            ToolbarItem(placement: .navigationBarLeading) {
                                    EmptyView()
                                }
                            ToolbarItem(placement: .navigationBarTrailing) {
                                Button(action: {
                                    isNavigating = false // Close sheet
                                }) {
                                    Image(systemName: "xmark.circle.fill") // Close button
                                        .font(.title2)
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                    }
                }
                .presentationDetents([.large])
                .ignoresSafeArea()
            }
        }
    }

    // Function to display each address card
    private func addressCardView(for address: AddressModel) -> some View {
        CardView(address: address, viewSelector: true, decider: true, editAction: {
            viewModelSection.selectAddress(address)
        })
        .padding(.vertical, 12)
        .onTapGesture {
            viewModelSection.selectAddress(address)
        }
    }

    // Helper function for Section Headers
    private func sectionHeader(title: String) -> some View {
        HStack {
            Text(title)
                .font(.headline)
                .padding(.horizontal)
                .padding(.top, 10)
            Spacer()
        }
    }
    
    // Function to confirm address selection
    private func confirmSelectedAddress() {
        self.viewModelSection.updateCurrent()
        dismiss()
        viewModelSection.addressToManipulate = nil // Hide buttons after confirmation
    }
}
//#Preview {
//    SectionView()
//}
