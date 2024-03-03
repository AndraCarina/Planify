//
//  GoogleHelper.swift
//  Planify
//
//  Created by Andra Bejan on 20.02.2024.
//

import Foundation
import SwiftUI
import GoogleSignIn
import GoogleSignInSwift
import Firebase

@MainActor
final class GoogleHelper {
    static func configureClientID() {
        /* Get Client ID from Firebase configuration. */
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        /* Create GIDConfiguration objects needed for GIDSignIn. */
        let config = GIDConfiguration(clientID: clientID)
        /* Set the configuration. */
        GIDSignIn.sharedInstance.configuration = config
    }
    
    static func getRootViewController() -> UIViewController? {
        /* Retrieve the active window scene. */
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return nil }
        /* Retrieve the window from the window scene. */
        guard let window = windowScene.windows.first else { return nil }
        /* Retrieve the root view controller from the window. */
        guard let rootViewController = window.rootViewController else { return nil }
        /* Return the root view controller. */
        return rootViewController
    }
    
    static func getCredential() async throws -> AuthCredential? {
        /* Configure the Google Client ID. */
        GoogleHelper.configureClientID()
        /* Get the root view controller. */
        guard let rootViewController = GoogleHelper.getRootViewController() else { return nil}
        /* Sign in with Google and retrieve authentication details. */
        let userAuthentication = try await GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController)
        /* Extract user details from authentication. */
        let idToken = userAuthentication.user.idToken
        let accessToken = userAuthentication.user.accessToken
        /* Create a credential using the obtained tokens. */
        let credential = GoogleAuthProvider.credential(withIDToken: idToken!.tokenString,
                                                       accessToken: accessToken.tokenString)
        /* Return credential. */
        return credential
    }
}
