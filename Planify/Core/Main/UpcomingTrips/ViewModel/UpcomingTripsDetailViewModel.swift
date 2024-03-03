//
//  DetailPlanViewModel.swift
//  Planify
//
//  Created by Andra Bejan on 02.03.2024.
//

import Foundation
import SwiftUI

class UpcomingTripsDetailViewModel: ObservableObject {
    @ObservedObject private var tripManager = TripManager.shared
    @ObservedObject private var planManager = PlanManager.shared

    func markTripFinished(trip: TripModel) {
        var modifiedTrip = trip
        modifiedTrip.isFinished = "true"
        
        Task {
            await tripManager.updateTrip(modifiedTrip: modifiedTrip)
        }
    }
    
    func filteredPlans(trip: TripModel) -> [PlanModel] {
        guard !trip.id.isEmpty else {
            return planManager.plans
        }
        
        return planManager.plans.filter { $0.tripId.localizedCaseInsensitiveContains(trip.id) }
    }
    
    func deleteTrip(trip: TripModel) {
        Task {
            await tripManager.deleteTrip(trip: trip)
        }
    }
}
