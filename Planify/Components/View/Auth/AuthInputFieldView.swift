//
//  InputFieldView.swift
//  Planify
//
//  Created by Andra Bejan on 21.02.2024.
//

import SwiftUI

struct AuthInputFieldView: View {
    @Binding var text: String
    var placeholder: String
    var isSecureField = false
    
    var body: some View {
        VStack {
            if isSecureField {
                SecureField("", text: $text, prompt: Text(placeholder).foregroundStyle(Color(.systemGray2)))
                    .padding(.leading, 6)
                    .foregroundColor(.white)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
            }
            else {
                TextField("", text: $text, prompt: Text(placeholder).foregroundStyle(Color(.systemGray2)))
                    .padding(.leading, 6)
                    .foregroundColor(.white)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
            }

        }
        .frame(width: UIScreen.main.bounds.width - 32, height: 40)
        .background(Color(UIColor.darkGray).clipShape(RoundedRectangle(cornerRadius:5)))
    }
}

#Preview {
    AuthInputFieldView(text: .constant(""), placeholder: "email")
}
