//
//  SettingsView.swift
//  Planify
//
//  Created by Andra Bejan on 24.02.2024.
//

import SwiftUI

struct SettingsView: View {
    @ObservedObject var viewModel = SettingsViewModel()
    var body: some View {
        VStack {
            Text("SettingsView")
            AuthButtonView(text: "Sign out", icon: "arrow.left") {
                viewModel.signOut()
            }
        }
    }
}

#Preview {
    SettingsView()
}
