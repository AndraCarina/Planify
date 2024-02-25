//
//  AddPlanViewModel.swift
//  Planify
//
//  Created by Andra Bejan on 24.02.2024.
//

import Foundation
import SwiftUI
import FirebaseFirestore

class AddPlanViewModel: ObservableObject {
    @ObservedObject private var authManager = AuthManager.shared
    @ObservedObject private var tripManager = TripManager.shared
    
    func addTrip() {
        Task {
            await tripManager.addTrip()
        }
    }
}
