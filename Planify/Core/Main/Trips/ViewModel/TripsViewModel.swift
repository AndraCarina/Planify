//
//  PlansViewModel.swift
//  Planify
//
//  Created by Andra Bejan on 25.02.2024.
//

import Foundation
import SwiftUI

class TripsViewModel: ObservableObject {
    @ObservedObject private var tripManager = TripManager.shared
    
    func filteredTrips(searchTerm: String) -> [TripModel] {
        guard !searchTerm.isEmpty else {
            return tripManager.trips.sorted { (firstTrip, secondTrip) -> Bool in
                return firstTrip.isFinished == "false" && secondTrip.isFinished != "false"
            }
        }
        
        return tripManager.trips.filter { $0.name.localizedCaseInsensitiveContains(searchTerm) }
    }
    
    func deleteTrip(trip: TripModel) {
        Task {
            await tripManager.deleteTrip(trip: trip)
        }
    }
}
