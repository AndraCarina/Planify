//
//  PlanifyApp.swift
//  Planify
//
//  Created by Andra Bejan on 19.02.2024.
//

import SwiftUI
import Firebase

@main
    struct PlanifyApp: App {
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            RootView()
        }
    }
}
