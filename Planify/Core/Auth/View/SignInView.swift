//
//  SignInView.swift
//  Planify
//
//  Created by Andra Bejan on 19.02.2024.
//

import SwiftUI

struct SignInView: View {
    @State private var email = ""
    @State private var password = ""
    @ObservedObject var viewModel =  SignInViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                Image(systemName: "house")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 120)
                    .padding(.vertical, 100)
                
                InputFieldView(text: $email, placeholder: "name@example.com", systemImage: "envelope.fill")
                    .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                
                InputFieldView(text: $password, placeholder: "password", systemImage: "lock.fill", isSecureField: true)
                
                Button {
                    viewModel.resetPassword(email: email)
                } label: {
                    HStack {
                        Spacer()
                        Text("Forgot password?")
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    }
                }
                .font(.system(size: 14))
                .padding(.top, 14)
                .padding(.trailing, 14)
                
                /* Sign in with email. */
                AuthButtonView(text: "SIGN IN WITH EMAIL", icon: "arrow.right", color: Color(.systemBlue), clicked: { viewModel.signInWithEmail(email: email, password: password) }
                )
                
                AuthButtonView(text: "SIGN IN WITH GOOGLE", icon: "g.circle.fill", color: Color(.green), clicked: { viewModel.signInWithGoogle() }
                )
                
                AuthButtonView(text: "SIGN IN WITH APPLE", icon: "apple.logo", color: Color(.black), clicked: { }
                )
                
                AuthButtonView(text: "SIGN IN AS A GUEST", icon: "person.fill", color: Color(.orange), clicked: { viewModel.signInAnonymously() }
                )
                
                Spacer()
                
                NavigationLink {
                    SignUpView()
                        .navigationBarBackButtonHidden()
                } label: {
                    HStack(spacing: 3){
                        Text("Don't have an account?")
                        Text("Sign up")
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    }
                    .font(.system(size: 14))
                }
            }
        }
    }
}

#Preview {
    SignInView(viewModel: SignInViewModel())
}
