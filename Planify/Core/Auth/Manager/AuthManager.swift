//
//  AuthManager.swift
//  Planify
//
//  Created by Andra Bejan on 19.02.2024.
//

import Foundation

enum AuthState {
    case NOT_SIGNED_IN
    case SIGNING_IN
    case GUEST_SIGN_IN
    case EMAIL_SIGN_IN
    case GOOGLE_SIGN_IN
    case APPLE_SIGN_IN
}

class AuthManager: ObservableObject {
    static let shared = AuthManager()
    @Published var authState: AuthState = .NOT_SIGNED_IN
    @Published var errorMessage: String = ""
    
    private init() {
        
    }
    
    func signInWithEmail()
    {
        /* Set state to SIGNING_IN. */
        authState = .SIGNING_IN
        
        /* Perform sign in with email. */
        
        
        /* Set state to EMAIL_SIGN_IN. */
        authState = .EMAIL_SIGN_IN
    }
    
    func signOut()
    {
        authState = .NOT_SIGNED_IN
    }
}
