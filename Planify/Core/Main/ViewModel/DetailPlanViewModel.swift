//
//  DetailPlanViewModel.swift
//  Planify
//
//  Created by Andra Bejan on 02.03.2024.
//

import Foundation
import SwiftUI

class DetailPlanViewModel: ObservableObject {
    @ObservedObject private var tripManager = TripManager.shared

    func markTripFinished(trip: TripModel) {
        var modifiedTrip = trip
        modifiedTrip.isFinished = "true"
        
        Task {
            await tripManager.updateTrip(modifiedTrip: modifiedTrip)
        }
    }
}
