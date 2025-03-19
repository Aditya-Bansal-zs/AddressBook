//
//  AddressListView.swift
//  DummyAddressBookNew
//
//  Created by ZopSmart on 12/03/25.
//

import SwiftUI

struct AddressListView: View {
    @ObservedObject var viewModel: AddressListViewModel

    var decider: Bool = false
    @State private var selectedAddress: AddressModel?

    var body: some View {
        VStack {
            if viewModel.addresses.isEmpty {
                Text("No addresses")
                    .font(.headline)
            } else {
                ScrollView {
                    ForEach(viewModel.addresses, id: \.id) { address in
                        CardView(address: address, decider: true, editAction: {
                            selectedAddress = address
                        })
                        .padding(.vertical, 12)
                    }
                }
            }
        }
        .sheet(item: $selectedAddress) { address in
            NavigationStack {
                VStack{
                    let vm = AddressManipulationViewModel(addressToManipulate: address, decider: true)
                    AddressManipulationView(viewModel: vm)
                        .padding(.top, 20)
                        .background(Color(UIColor.systemBackground))
                        .clipShape(RoundedRectangle(cornerRadius: 25))
                        .presentationDetents([.large])
                        .presentationCornerRadius(20)
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            selectedAddress = nil
                        }) {
                            Image(systemName: "xmark.circle.fill") // Cross icon
                                .font(.title2)
                                .foregroundColor(.gray)
                        }
                    }
                }
            }
        }
    }
}

//
//#Preview {
//    AddressListView()
//}
