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
    @State private var showingValidationAlert = false
    @Binding var path: NavigationPath
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var viewModel =  LoginViewModel()
    
    var body: some View {
        ZStack {
            VStack {
                Text("Welcome back!")
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .font(.system(size: 30))
                    .padding(.top, 20)
                
                Text("We're excited to see you again!")
                    .foregroundStyle(colorScheme == .dark ? Color(UIColor.lightGray) : Color(UIColor.darkGray))
                    .multilineTextAlignment(.center)
                    .font(.system(size: 14))
                
                HStack {
                    Text("Account Information")
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .foregroundStyle(colorScheme == .dark ? Color(UIColor.lightGray) : Color(UIColor.darkGray))
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
                    if viewModel.validateFields(email: email, password: password) {
                        viewModel.signInWithEmail(email: email, password: password)
                    }
                    else {
                        showingValidationAlert = true
                    }
                }
                
                Text("---- or ----")
                    .foregroundStyle(colorScheme == .dark ? Color(UIColor.lightGray) : Color(UIColor.darkGray))
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
        .alert("Validation Error", isPresented: $showingValidationAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text("Please check your inputs. Make sure all fields are filled and dates are correct.")
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading){
                Button {
                    path = NavigationPath()
                } label: {
                    Image(systemName: "arrow.backward")
                        .foregroundStyle(colorScheme == .dark ? Color(UIColor.white) : Color(UIColor.black))
                }
            }
        }
    }
}

#Preview {
    LoginView(path: .constant(NavigationPath()))
}
