//
//  SignInView.swift
//  Planify
//
//  Created by Andra Bejan on 19.02.2024.
//

import SwiftUI

class SignInViewModel: ObservableObject {
    @ObservedObject private var authManager = AuthManager.shared
    func signInWithEmail() {
        authManager.signInWithEmail()
    }
}

struct SignInView: View {
    @ObservedObject var viewModel =  SignInViewModel()
    
    var body: some View {
        NavigationStack {
            Text("Not signed in.")
            
            Button {
                viewModel.signInWithEmail()
            } label: {
                Text("Sign in")
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
