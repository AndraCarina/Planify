//
//  LoginViewModel.swift
//  Planify
//
//  Created by Andra Bejan on 23.02.2024.
//

import Foundation
import SwiftUI

class LoginViewModel: ObservableObject {
    @ObservedObject private var authManager = AuthManager.shared
    
    func signInWithEmail(email: String, password: String) {
        Task{
            await authManager.signInWithEmail(email: email, password: password)
        }
    }
    
    func signInWithGoogle() {
        Task {
            await authManager.signInWithGoogle()
        }
    }
    
    func signInAnonymously() {
        Task {
            await authManager.signInAnonymously()
        }
    }
    
    func resetPassword(email: String) {
        Task {
            await authManager.resetPassword(email: email)
        }
    }
    
    func validateFields(email: String, password: String) -> Bool {
        guard !email.isEmpty else { return false }
        guard password.count >= 6 else { return false }
        return true
    }
}

