//
//  CheckboxView.swift
//  DummyAddressBookNew
//
//  Created by ZopSmart on 12/03/25.
//

import SwiftUI

struct CheckboxView: View {
    @Binding var isChecked: Bool

    var body: some View {
        HStack {
            Image(systemName: isChecked ? "checkmark.square.fill" : "square")
                .font(.system(size: 20))

            Text("Make this my default mailing address")
                .font(.headline)

            Spacer()
        }
        .padding()
        .onTapGesture {
            isChecked.toggle()
        }
    }
}


//#Preview {
//    CheckboxView()
//}
