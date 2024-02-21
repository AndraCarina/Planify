//
//  SignUpViewModel.swift
//  Planify
//
//  Created by Andra Bejan on 21.02.2024.
//

import Foundation
import SwiftUI

class SignUpViewModel: ObservableObject {
    @ObservedObject private var authManager = AuthManager.shared
    func signUp(email: String, password: String) {
        Task {
            await authManager.signUp(email: email, password: password)
        }
    }
}
