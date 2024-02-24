//
//  AuthBottomNavLinkView.swift
//  Planify
//
//  Created by Andra Bejan on 23.02.2024.
//

import SwiftUI

struct AuthBottomNavLinkView: View {
    var value: String
    var normalText: String
    var boldedText: String
    var body: some View {
        NavigationLink(value: value) {
            HStack(spacing: 3){
                Text(normalText)
                Text(boldedText)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
            }
            .foregroundStyle(Color(.systemBlue))
            .font(.system(size: 14))
        }
    }
}

#Preview {
    AuthBottomNavLinkView(value: "LogInView", normalText: "Already have an account?", boldedText: "Log in")
}
