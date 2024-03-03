//
//  AuthManager.swift
//  Planify
//
//  Created by Andra Bejan on 19.02.2024.
//

import Foundation
import SwiftUI
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
    @ObservedObject private var tripManager = TripManager.shared
    @ObservedObject private var planManager = PlanManager.shared
    
    private init() {
        Task {
            /* Fetch user data. */
            await fetchUser()
        }
    }
    
    func signInWithEmail(email: String, password: String) async {
        /* Perform sign in with email. */
        do {
            /* Call sign in with email. */
            try await Auth.auth().signIn(withEmail: email, password: password)
            /* Fetch user data. */
            await fetchUser()
        } catch {
            print("DEBUG: Failed to log in with error \(error.localizedDescription)")
            errorMessage = error.localizedDescription
        }
    }
    
    func signUp(email: String, password: String, fullname: String) async {
        do {
            /* Call create user. */
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            /* Get current date. */
            let formattedDate = DateFormatter.localizedString(from: Date(), dateStyle: .short, timeStyle: .none)
            /* Create user to be encoded. */
            let user = UserModel(id: result.user.uid, email: email, joinDate: formattedDate, fullname: fullname)
            /* Encode user. */
            let encodedUser = try Firestore.Encoder().encode(user)
            /* Upload encoded user to Firestore. */
            try await Firestore.firestore().collection("users").document(result.user.uid).setData(encodedUser)
            /* Fetch user data. */
            await fetchUser()
        } catch {
            print("DEBUG: Failed to create user with error \(error.localizedDescription)")
            errorMessage = error.localizedDescription
        }
    }
    
    func signInWithGoogle() async {
        do {
            /* Get AuthCredential from Google. */
            guard let credential = try await GoogleHelper.getCredential() else { return }
            /* Call sign in with Google. */
            let result = try await Auth.auth().signIn(with: credential)
            /* Check if user already exists. */
            let docRef = Firestore.firestore().collection("users").document(result.user.uid)
            do {
                let document = try await docRef.getDocument()
                if !document.exists {
                    /* Get current date. */
                    let formattedDate = DateFormatter.localizedString(from: Date(), dateStyle: .short, timeStyle: .none)
                    /* Create user to be encoded. */
                    let currentUser = UserModel(id: result.user.uid, email: result.user.email!, joinDate: formattedDate, fullname: result.user.displayName!)
                    /* Encode user. */
                    let encodedUser = try Firestore.Encoder().encode(currentUser)
                    /* Upload encoded user to Firestore. */
                    try await Firestore.firestore().collection("users").document(result.user.uid).setData(encodedUser)
                }
            } catch {
                print(error.localizedDescription)
                self.errorMessage = error.localizedDescription
            }

            /* Fetch user data. */
            await fetchUser()
        }
        catch {
            print(error.localizedDescription)
            self.errorMessage = error.localizedDescription
        }
    }
    
    func signInAnonymously() async {
        do {
            /* Call sign in anonymously. */
            let result = try await Auth.auth().signInAnonymously()
            /* Get current date. */
            let formattedDate = DateFormatter.localizedString(from: Date(), dateStyle: .short, timeStyle: .none)
            /* Create user to be encoded. */
            let user = UserModel(id: result.user.uid, email: "", joinDate: formattedDate, fullname: "")
            /* Encode user. */
            let encodedUser = try Firestore.Encoder().encode(user)
            /* Upload encoded user to Firestore. */
            try await Firestore.firestore().collection("users").document(result.user.uid).setData(encodedUser)
            /* Fetch user data. */
            await fetchUser()
        } catch {
            print(error.localizedDescription)
            self.errorMessage = error.localizedDescription
        }
    }
    
    func signOut() async {
        do {
            /* Call sign out. */
            try Auth.auth().signOut()
            /* Fetch user data. */
            await fetchUser()
        } catch {
            print("DEBUG: Failed to sign out with error \(error.localizedDescription)")
            errorMessage = error.localizedDescription
        }
    }
    
    func resetPassword(email: String) async {
        do {
            try await Auth.auth().sendPasswordReset(withEmail: email)
        } catch {
            print("DEBUG: Failed to sign out with error \(error.localizedDescription)")
            errorMessage = error.localizedDescription
        }
    }
    
    func fetchUser() async {
        /* Get FirebaseUser, if not logged in, return. */
        guard let firebaseUser = Auth.auth().currentUser else {
            /* No user, reinitialize everything. */
            self.firebaseUser = nil
            self.appUser = nil
            authState = .NOT_SIGNED_IN
            return
        }
        
        /* Change authState to SIGNING_IN while fetching data from the database. */
        authState = .SIGNING_IN
        
        /* Get database data for AppUser, if not available, return. */
        guard let snapshot = try? await Firestore.firestore().collection("users").document(firebaseUser.uid).getDocument() else { return }
        
        /* Set local FirebaseUser and AppUser. */
        self.firebaseUser = firebaseUser
        self.appUser = try? snapshot.data(as: UserModel.self)
        
        await tripManager.fetchTrips(userId: firebaseUser.uid)
        await planManager.fetchPlans(userId: firebaseUser.uid)
        
        /* Set authState depending on the provider. */
        guard let providerID = firebaseUser.providerData.first?.providerID else {
            authState = .GUEST_SIGN_IN
            return
        }
        
        if providerID == "password" {
            authState = .EMAIL_SIGN_IN
        } else if providerID == "google.com" {
            authState = .GOOGLE_SIGN_IN
        }
    }
}
