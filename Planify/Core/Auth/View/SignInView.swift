//
//  SignInView.swift
//  Planify
//
//  Created by Andra Bejan on 19.02.2024.
//

import SwiftUI

class SignInViewModel: ObservableObject {
    @ObservedObject private var authManager = AuthManager.shared
    func signInWithEmail(email: String, password: String) {
        Task{
            await authManager.signInWithEmail(email: email, password: password)
        }
    }
    func signInWithGoogle() {
        Task {
            await authManager.signInWithGoogle()
        }
    }
}

struct SignInView: View {
    @State private var email = ""
    @State private var password = ""
    @ObservedObject var viewModel =  SignInViewModel()
    
    var body: some View {
        NavigationStack {
            Text("Not signed in.")
            
            InputView(text: $email,
                      title: "Email Address",
                      placeholder: "name@example.com")
            .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
            
            InputView(text: $password,
                      title: "Password",
                      placeholder: "Enter your password",
                      isSecureField: true)
            
            Button {
                viewModel.signInWithEmail(email: email, password: password)
            } label: {
                Text("Sign in")
            }
            
            Button() {
                viewModel.signInWithGoogle()
            } label: {
                Text("Sign in with Google")
            }
            
            NavigationLink {
                SignUpView().navigationBarBackButtonHidden()
            } label: {
                Text("Sign up")
            }
        }
    }
}

#Preview {
    SignInView(viewModel: SignInViewModel())
}
