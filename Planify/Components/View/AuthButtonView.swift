//
//  AuthButtonView.swift
//  Planify
//
//  Created by Andra Bejan on 21.02.2024.
//

import SwiftUI

struct AuthButtonView: View {
    var text: String
    var icon: String
    var color: Color
    var clicked: (() -> Void)
    var body: some View {
        Button(action: clicked) {
            HStack {
                Text(text)
                    .fontWeight(.semibold)
                Image(systemName: icon)
            }
            .foregroundColor(.white)
            .frame(width: UIScreen.main.bounds.width - 32, height: 48)
        }
        .background(color)
        .cornerRadius(10)
        .padding(.top, 8)
    }
}

#Preview {
    AuthButtonView(text: "SIGN IN WITH EMAIL", icon: "arrow.right", color: Color(.systemBlue), clicked: {})
}
