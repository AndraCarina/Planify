//
//  AddPlanViewModel.swift
//  Planify
//
//  Created by Andra Bejan on 24.02.2024.
//

import Foundation
import SwiftUI
import FirebaseFirestore

class AddTripViewModel: ObservableObject {
    @ObservedObject private var authManager = AuthManager.shared
    @ObservedObject private var tripManager = TripManager.shared
    
    func addTrip(tripName: String, location: String, photoURL: String, startDate: Date, endDate: Date) {
        Task {
            await tripManager.addTrip(name: tripName, location: location, photoURL: photoURL, startDate: startDate, endDate: endDate)
        }
    }
    
    func validateFields(tripName: String, location: String, photoURL: String) -> Bool {
            guard !tripName.isEmpty else { return false }
            guard !location.isEmpty else { return false }
            guard !photoURL.isEmpty else { return false }
            return true
    }
}
