//
//  SignUpView.swift
//  Planify
//
//  Created by Andra Bejan on 20.02.2024.
//

import SwiftUI

class SignUpViewModel: ObservableObject {
    @ObservedObject private var authManager = AuthManager.shared
    func signUp(email: String, password: String) {
        Task {
            await authManager.signUp(email: email, password: password)
        }
    }
}

struct SignUpView: View {
    @State private var email = ""
    @State private var password = ""
    @ObservedObject var viewModel =  SignUpViewModel()
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        Text("Sign up.")
        
        InputView(text: $email,
                  title: "Email Address",
                  placeholder: "name@example.com")
        .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
        
        InputView(text: $password,
                  title: "Password",
                  placeholder: "Enter your password",
                  isSecureField: true)
        
        Button {
            viewModel.signUp(email: email, password: password)
        } label: {
            Text("Sign up")
        }
        
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
