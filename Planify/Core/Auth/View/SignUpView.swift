//
//  SignUpView.swift
//  Planify
//
//  Created by Andra Bejan on 20.02.2024.
//

import SwiftUI

struct SignUpView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var fullname = ""
    @ObservedObject var viewModel =  SignUpViewModel()
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            Image(systemName: "house")
                .resizable()
                .scaledToFill()
                .frame(width: 100, height: 120)
                .padding(.vertical, 100)
            
            InputFieldView(text: $fullname, placeholder: "full name", systemImage: "person.fill")
                .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
            
            InputFieldView(text: $email, placeholder: "name@example.com", systemImage: "envelope.fill")
                .autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
            
            InputFieldView(text: $password, placeholder: "password", systemImage: "lock.fill", isSecureField: true)
            
            InputFieldView(text: $confirmPassword, placeholder: "confirm password", systemImage: "lock.fill", isSecureField: true)
            
            AuthButtonView(text: "SIGN UP WITH EMAIL", icon: "arrow.right", color: Color(.systemBlue), clicked: { viewModel.signUp(email: email, password: password) }
            )
        }
        
        Spacer()
        
        Button {
            dismiss()
        } label: {
            HStack(spacing: 3){
                Text("Already have an account?")
                Text("Sign in")
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
            }
            .font(.system(size: 14))
        }
    }
}

#Preview {
    SignUpView()
}
