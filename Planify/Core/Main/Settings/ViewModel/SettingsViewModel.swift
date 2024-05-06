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
    @ObservedObject private var tripManager = TripManager.shared
    @ObservedObject private var planManager = PlanManager.shared
    func signOut() {
        Task {
            await authManager.signOut()
        }
    }
    
    func deleteUser() {
        Task {
            await authManager.deleteUser()
        }
    }
    
    func getInitials() -> String {
        if authManager.authState == .GUEST_SIGN_IN {
            return "G"
        }
        
        let formatter = PersonNameComponentsFormatter()
        if let components = formatter.personNameComponents(from: authManager.appUser!.fullname) {
            formatter.style = .abbreviated
            return formatter.string(from: components)
        }
        
        return ""
    }
    
    func getFullname() -> String {
        if authManager.authState == .GUEST_SIGN_IN {
            return "Guest"
        }
        
        return authManager.appUser!.fullname
    }
    
    func getSignInMethod() -> String {
        if authManager.authState == .EMAIL_SIGN_IN {
            return "Signed in with email: \(authManager.appUser!.email)"
        } else if authManager.authState == .GOOGLE_SIGN_IN {
            return "Signed in with Google"
        } else if authManager.authState == .GUEST_SIGN_IN {
            return "Signed in as guest"
        }
        
        return ""
    }
    
    func getNumberOfTrips() -> String {
        return "\(tripManager.trips.count)"
    }
    
    func getNumberOfPlans() -> String {
        return "\(planManager.plans.count)"
    }
}
