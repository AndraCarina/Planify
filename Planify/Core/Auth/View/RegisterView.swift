//
//  RegisterView.swift
//  Planify
//
//  Created by Andra Bejan on 21.02.2024.
//

import SwiftUI

struct RegisterView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var fullname = ""
    @Binding var path: NavigationPath
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var viewModel =  RegisterViewModel()
    
    var body: some View {
        ZStack {
            VStack {
                Text("Register account")
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .font(.system(size: 30))
                    .padding(.top, 20)
                    .padding(.bottom, 1)
                
                Text("Please enter the account information below.")
                    .foregroundStyle(colorScheme == .dark ? Color(UIColor.lightGray) : Color(UIColor.darkGray))
                    .multilineTextAlignment(.center)
                    .font(.system(size: 14))
                    .padding(.bottom, 20)
                
                HStack {
                    Text("Account Information")
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .foregroundStyle(colorScheme == .dark ? Color(UIColor.lightGray) : Color(UIColor.darkGray))
                        .font(.system(size: 14))
                        .padding(.leading, 16)
                    Spacer()
                }
                
                AuthInputFieldView(text: $email, placeholder: "email")
                
                AuthInputFieldView(text: $fullname, placeholder: "full name")
                
                AuthInputFieldView(text: $password, placeholder: "password", isSecureField: true)
                
                AuthInputFieldView(text: $confirmPassword, placeholder: "confirm password", isSecureField: true)
                
                
                AuthButtonView(text: "Register account", icon: "plus.app") {
                    viewModel.signUp(email: email, password: password, fullname: fullname)
                }
                .padding(.top, 10)
                
                Spacer()
                
                AuthBottomNavLinkView(value: "LogInView", normalText: "Already have an account?", boldedText: "Log in")
            }
        }
        .navigationBarBackButtonHidden()
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
    RegisterView(path: .constant(NavigationPath()))
}
