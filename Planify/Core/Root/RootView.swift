//
//  ContentView.swift
//  Planify
//
//  Created by Andra Bejan on 19.02.2024.
//

import SwiftUI

struct RootView: View {
    @ObservedObject private var authManager = AuthManager.shared
    var body: some View {
        Group {
            if authManager.authState ==  .NOT_SIGNED_IN {
                SignInView()
            } else if authManager.authState == .SIGNING_IN {
                SigningInView()
            } else {
                SignedInView()
            }
        }
    }
}

#Preview {
    RootView()
}
