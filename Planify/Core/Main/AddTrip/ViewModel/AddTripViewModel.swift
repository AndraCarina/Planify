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
        let startDateString = DateFormatter.localizedString(from: startDate, dateStyle: .short, timeStyle: .none)
        let endDateString = DateFormatter.localizedString(from: endDate, dateStyle: .short, timeStyle: .none)
        Task {
            await tripManager.addTrip(name: tripName, location: location, photoURL: photoURL, startDate: startDateString, endDate: endDateString)
        }
    }
}
