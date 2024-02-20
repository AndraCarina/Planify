//
//  AuthManager.swift
//  Planify
//
//  Created by Andra Bejan on 19.02.2024.
//

import Foundation
import FirebaseAuth
import Firebase
import FirebaseFirestoreSwift

enum AuthState {
    case NOT_SIGNED_IN
    case SIGNING_IN
    case GUEST_SIGN_IN
    case EMAIL_SIGN_IN
    case GOOGLE_SIGN_IN
    case APPLE_SIGN_IN
}

@MainActor
class AuthManager: ObservableObject {
    static let shared = AuthManager()
    @Published var authState: AuthState = .NOT_SIGNED_IN
    @Published var errorMessage: String = ""
    @Published var firebaseUser: FirebaseAuth.User?
    @Published var appUser: UserModel?
    
    private init() {
        self.firebaseUser = Auth.auth().currentUser
        Task {
            await fetchUser()
        }
    }
    
    func signInWithEmail(email: String, password: String) {
        /* Perform sign in with email. */
        Task {
            do {
                /* Set state to SIGNING_IN. */
                authState = .SIGNING_IN
                let result = try await Auth.auth().signIn(withEmail: email, password: password)
                self.firebaseUser = result.user
                await fetchUser()
                /* Set state to EMAIL_SIGN_IN. */
                authState = .EMAIL_SIGN_IN
            } catch {
                print("DEBUG: Failed to log in with error \(error.localizedDescription)")
                errorMessage = error.localizedDescription
                authState = .NOT_SIGNED_IN
            }
        }
    }
    
    func signUp(email: String, password: String) {
        Task {
            do {
                let result = try await Auth.auth().createUser(withEmail: email, password: password)
                self.firebaseUser = result.user
                let user = UserModel(id: result.user.uid, email: email)
                let encodedUser = try Firestore.Encoder().encode(user)
                try await Firestore.firestore().collection("users").document(user.id).setData(encodedUser)
                await fetchUser()
                authState = .EMAIL_SIGN_IN
            } catch {
                print("DEBUG: Failed to create user with error \(error.localizedDescription)")
                errorMessage = error.localizedDescription
                authState = .NOT_SIGNED_IN
            }
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            self.firebaseUser = nil
            self.appUser = nil
            authState = .NOT_SIGNED_IN
        } catch {
            print("DEBUG: Failed to sign out with error \(error.localizedDescription)")
            errorMessage = error.localizedDescription
        }
    }
    
    func fetchUser() async {
        guard let uid = Auth.auth().currentUser?.uid else {return }
        guard let snapshot = try? await Firestore.firestore().collection("users").document(uid).getDocument() else {return }
        self.appUser = try? snapshot.data(as: UserModel.self)
        authState = .EMAIL_SIGN_IN
    }
}
