//
//  InputFieldView.swift
//  Planify
//
//  Created by Andra Bejan on 21.02.2024.
//

import SwiftUI

struct InputFieldView: View {
    @Binding var text: String
    let placeholder: String
    let systemImage: String
    var isSecureField = false
    
    var body: some View {
        HStack {
            Image(systemName: systemImage)
                .resizable()
                .scaledToFit()
                .frame(width: 20, height: 20)
                .padding(.leading, 5)
            
            if isSecureField {
                SecureField(placeholder, text: $text)
            }
            else
            {
                TextField(placeholder, text: $text).font(.system(.body, design: .rounded))
            }
        }
        .frame(width: UIScreen.main.bounds.width - 32, height: 40)
        .overlay(RoundedRectangle(cornerRadius: 8).stroke(lineWidth: 2).foregroundColor(Color.black))
    }
}

#Preview {
    InputFieldView(text: .constant(""), placeholder: "name@example.com", systemImage: "envelope.fill")
}
