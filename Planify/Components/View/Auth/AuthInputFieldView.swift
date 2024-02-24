//
//  InputFieldView.swift
//  Planify
//
//  Created by Andra Bejan on 21.02.2024.
//

import SwiftUI

struct AuthInputFieldView: View {
    @Environment(\.colorScheme) var colorScheme
    @Binding var text: String
    var placeholder: String
    var isSecureField = false
    
    var body: some View {
        VStack {
            if isSecureField {
                SecureField("", text: $text, prompt: Text(placeholder).foregroundStyle(colorScheme == .dark ? Color(UIColor.lightGray) : Color(UIColor.darkGray)))
                    .padding(.leading, 6)
                    .foregroundColor(colorScheme == .dark ? Color(UIColor.white) : Color(UIColor.black))
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
            }
            else {
                TextField("", text: $text, prompt: Text(placeholder).foregroundStyle(colorScheme == .dark ? Color(UIColor.lightGray) : Color(UIColor.darkGray)))
                    .padding(.leading, 6)
                    .foregroundColor(colorScheme == .dark ? Color(UIColor.white) : Color(UIColor.black))
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
            }

        }
        .frame(width: UIScreen.main.bounds.width - 32, height: 40)
        .background((colorScheme == .dark ? Color(UIColor.darkGray) : Color(UIColor.lightGray)).clipShape(RoundedRectangle(cornerRadius:5)))
    }
}

#Preview {
    AuthInputFieldView(text: .constant(""), placeholder: "email")
}
