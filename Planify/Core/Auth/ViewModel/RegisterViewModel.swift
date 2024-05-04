//
//  RegisterViewModel.swift
//  Planify
//
//  Created by Andra Bejan on 23.02.2024.
//

import Foundation
import SwiftUI

class RegisterViewModel: ObservableObject {
    @ObservedObject private var authManager = AuthManager.shared
    func signUp(email: String, password: String, fullname: String) {
        Task {
            await authManager.signUp(email: email, password: password, fullname: fullname)
        }
    }
    
    func validateFields(email: String, password: String, fullname: String, confirmPassword: String) -> Bool {
        guard !email.isEmpty else { return false }
        guard password.count >= 6 else { return false }
        guard !fullname.isEmpty else { return false }
        guard password == confirmPassword else {return false }
        return true
    }
}
