//
//  SignedInView.swift
//  Planify
//
//  Created by Andra Bejan on 19.02.2024.
//

import SwiftUI

class SignedInViewModel: ObservableObject {
    @ObservedObject private var authManager = AuthManager.shared
    func signOut() {
        Task {
            await authManager.signOut()
        }
    }
}

struct SignedInView: View {
    @ObservedObject var viewModel = SignedInViewModel()
    
    var body: some View {
        Text("Signed in with UID:\(AuthManager.shared.firebaseUser!.uid).")
        if AuthManager.shared.authState == .EMAIL_SIGN_IN {
            Text("Signed in with Email.")
        }
        else {
            Text("Signed in with Google.")
        }
        
        
        Button {
            viewModel.signOut()
        } label : {
            Text("Sign out")
        }
    }
}

#Preview {
    SignedInView(viewModel: SignedInViewModel())
}
