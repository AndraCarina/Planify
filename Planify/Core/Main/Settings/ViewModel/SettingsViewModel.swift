//
//  SettingsViewModel.swift
//  Planify
//
//  Created by Andra Bejan on 24.02.2024.
//

import Foundation
import SwiftUI

class SettingsViewModel: ObservableObject {
    @ObservedObject private var authManager = AuthManager.shared
    func signOut() {
        Task {
            await authManager.signOut()
        }
    }
}
