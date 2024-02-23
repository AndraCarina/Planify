//
//  WelcomeNavLinkView.swift
//  Planify
//
//  Created by Andra Bejan on 23.02.2024.
//

import SwiftUI

struct AuthNavLinkView: View {
    let value: String
    let text: String
    var body: some View {
        NavigationLink(value: value){
            HStack {
                Text(text)
                    .foregroundStyle(.white)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .font(.system(size: 14))
            }
            .frame(width: UIScreen.main.bounds.width - 32, height: 40)
            .background(Color(.systemBlue).clipShape(RoundedRectangle(cornerRadius:5)))
        }
    }
}

#Preview {
    AuthNavLinkView(value: "LogInView", text: "Log in")
}
