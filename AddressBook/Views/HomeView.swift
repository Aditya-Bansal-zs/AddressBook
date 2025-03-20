//
//  HomeView.swift
//  DummyAddressBookNew
//
//  Created by ZopSmart on 12/03/25.
//

import SwiftUI


struct HomeView: View {
    @StateObject var viewModel: AddressListViewModel = AddressListViewModel(manager: AddressManager.shared,section: false)
    @State private var showAddAddressSheet = false

    var body: some View {
        NavigationStack {
            VStack {
                SelectorView()
                AddressListView(viewModel: viewModel, decider: true)
            }
            .padding()
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showAddAddressSheet.toggle()
                    } label: {
                        Text("Add")
                    }
                }
            }
            .navigationTitle("Address Book")
            .navigationBarTitleDisplayMode(.inline)
            .background(Color(UIColor.secondarySystemGroupedBackground))
        }
        .sheet(isPresented: $showAddAddressSheet) {
            NavigationStack { // Wrap inside NavigationStack
                VStack {
                    let viewModel = AddressManipulationViewModel(manager: AddressManager.shared, decider: false)
                    AddressManipulationView(viewModel: viewModel)
                        .padding(.top, 20)
                        .background(Color(UIColor.systemBackground))
                        .clipShape(RoundedRectangle(cornerRadius: 25))
                        .presentationDetents([.large])
                        .presentationCornerRadius(20)
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            showAddAddressSheet = false
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

//#Preview {
//    HomeView()
//}
