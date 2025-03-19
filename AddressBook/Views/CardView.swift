//
//  CardView.swift
//  DummyAddressBookNew
//
//  Created by ZopSmart on 12/03/25.
//

import SwiftUI

struct CardView: View {
    @Environment(\.colorScheme) var colorScheme

    var address: AddressModel
    var viewSelector: Bool = false
    var decider: Bool = false
    var editAction: () -> Void

    var body: some View {
        Button(action: editAction) {
            HStack {
                VStack(alignment: .leading, spacing: 6) {
                    // Display "Mailing Address" Tag Only If isChecked is True
                    if !viewSelector{
                        if address.isMailingAddress {
                            HStack(spacing: 5) {
                                Image(systemName: "envelope")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 14, height: 14)
                                    .foregroundColor(.blue)
                                
                                Text("Mailing Address")
                                    .font(.caption2)
                                    .foregroundColor(.blue)
                            }
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(Color.blue.opacity(0.1))
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                        }
                    }
                    
                    // Address Text
                    Text("\(address.street), \(address.city)")
                        .font(.headline)

                    Text("\(address.state), \(address.postalcode)")
                        .font(.subheadline)
                }
                
                Spacer()

                if decider && !viewSelector {
                    Button(action: editAction) {
                        Text("Edit")
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundColor(.blue)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 6)
                            .background(Color.blue.opacity(0.1))
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                }
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color(UIColor.secondarySystemBackground))
                    .shadow(color: Color.primary.opacity(0.3), radius: 4, x: 0, y: 2)
            )
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
        }
        .buttonStyle(PlainButtonStyle())
    }
}


//#Preview {
//    CardView()
//}
