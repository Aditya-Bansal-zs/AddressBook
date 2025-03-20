//
//  SelectorView.swift
//  DummyAddressBookNew
//
//  Created by ZopSmart on 12/03/25.
//

import SwiftUI

struct SelectorView: View {
    @StateObject var viewModel = SectionViewModel(manager: AddressManager.shared)
    let vm = AddressListViewModel(section: true)
    
    @State var isNavigating: Bool = false
    
    var body: some View {
        NavigationStack {
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    Text("Address")
                        .font(.headline)
                        .bold()

                    if let firstAddress = vm.addresses.first, firstAddress.isCurrent {
                        Text("Delivering to \(firstAddress.street), \(firstAddress.city), \(firstAddress.postalcode)")
                            .font(.subheadline)
                    } else {
                        Text("Select an Address")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                }
                Spacer()
                Image(systemName: "chevron.down")
                    .frame(width: 8, height: 8)
                    .padding(16)
                    .background(Color.gray.opacity(0.4))
                    .clipShape(.circle)
            }.onTapGesture {
                isNavigating = true // Update state to trigger navigation
                viewModel.fetchAddresses()
            }
//            .padding(.vertical, 12) // Adds padding inside the box
            Divider()
        }
        .sheet(isPresented: $isNavigating) {
            NavigationStack {
                VStack {
                    SectionView(viewModelSection: viewModel)
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            isNavigating = false // Dismiss the sheet
                        }) {
                            Image(systemName: "xmark.circle.fill") // Cross icon
                                .font(.title2)
                                .foregroundColor(.gray)
                        }
                    }
                }
            }
            .presentationDetents([.large]) // Corrected placement: applies to the entire sheet
            .ignoresSafeArea() // Replaces deprecated .edgesIgnoringSafeArea(.all)
        }
    }
}
//#Preview {
//    SelectorView()
//}
