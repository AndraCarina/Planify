//
//  SignUpView.swift
//  Planify
//
//  Created by Andra Bejan on 20.02.2024.
//

import SwiftUI

struct SignUpView: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        Text("Sign up.")
        
        Button {
            dismiss()
        } label: {
            Text("Go back")
        }
    }
}

#Preview {
    SignUpView()
}
