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
    var clicked: (() -> Void)
    var body: some View {
        VStack {
            Button {
                clicked()
            } label: {
                Image(systemName: icon)
                    .foregroundColor(Color.white)
                Text(text)
                    .foregroundStyle(.white)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .font(.system(size: 14))
            }
        }
        .frame(width: UIScreen.main.bounds.width - 32, height: 40)
        .background(Color(.systemBlue).clipShape(RoundedRectangle(cornerRadius:5)))
    }
}

#Preview {
    AuthButtonView(text: "SIGN IN WITH EMAIL", icon: "arrow.right", clicked: {})
}
