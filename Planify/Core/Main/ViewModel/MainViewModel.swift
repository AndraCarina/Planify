//
//  MainViewModel.swift
//  Planify
//
//  Created by Andra Bejan on 21.02.2024.
//

import Foundation
import SwiftUI

class MainViewModel: ObservableObject {
    @ObservedObject private var authManager = AuthManager.shared
    func signOut() {
        Task {
            await authManager.signOut()
        }
    }
}
