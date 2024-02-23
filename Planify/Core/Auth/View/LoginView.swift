//
//  LogInView.swift
//  Planify
//
//  Created by Andra Bejan on 21.02.2024.
//

import SwiftUI

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @Binding var path: NavigationPath
    @ObservedObject var viewModel =  LoginViewModel()
    
    var body: some View {
        ZStack {
            Color("AppBackgroundColor").ignoresSafeArea()
            VStack {
                Text("Welcome back!")
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .foregroundStyle(.white)
                    .font(.system(size: 30))
                    .padding(.top, 20)
                
                Text("We're excited to see you again!")
                    .foregroundStyle(Color(UIColor.lightGray))
                    .multilineTextAlignment(.center)
                    .font(.system(size: 14))
                
                HStack {
                    Text("Account Information")
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .foregroundStyle(Color(UIColor.lightGray))
                        .font(.system(size: 14))
                        .padding(.leading, 16)
                    Spacer()
                }
                .padding(.top, 20)

                AuthInputFieldView(text: $email, placeholder: "email")
                
                AuthInputFieldView(text: $password, placeholder: "password", isSecureField: true)

                Button {
                    viewModel.resetPassword(email: email)
                } label: {
                    HStack {
                        Text("Forgot password?")
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            .foregroundStyle(Color(.systemBlue))
                        Spacer()
                    }
                }
                .font(.system(size: 10))
                .padding(.top, 4)
                .padding(.leading, 16)
                
                AuthButtonView(text: "Log in with Email", icon: "envelope.fill") {
                    viewModel.signInWithEmail(email: email, password: password)
                }
                
                Text("---- or ----")
                    .foregroundStyle(Color(UIColor.lightGray))
                    .multilineTextAlignment(.center)
                    .font(.system(size: 14))
                    .padding(.vertical, 20)
                
                AuthButtonView(text: "Continue with Google", icon: "g.circle.fill") {
                    viewModel.signInWithGoogle()
                }
                
                AuthButtonView(text: "Continue with Apple", icon: "apple.logo") {
                    
                }
                .padding(.top, 10)
                
                AuthButtonView(text: "Continue as a guest", icon: "person.fill") {
                    viewModel.signInAnonymously()
                }
                .padding(.top, 10)

                Spacer()
                
                AuthBottomNavLinkView(value: "RegisterView", normalText: "Don't have an account?", boldedText: "Register now")
            }
        }
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading){
                Button {
                    path = NavigationPath()
                } label: {
                    Image(systemName: "arrow.backward")
                        .foregroundColor(Color.white)
                }
            }
        }
    }
}

#Preview {
    LoginView(path: .constant(NavigationPath()))
}
