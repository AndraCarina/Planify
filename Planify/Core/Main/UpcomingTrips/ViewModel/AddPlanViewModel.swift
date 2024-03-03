//
//  AddPlanViewModel.swift
//  Planify
//
//  Created by Andra Bejan on 03.03.2024.
//


import Foundation
import SwiftUI

class AddPlanViewModel: ObservableObject {
    @ObservedObject private var planManager = PlanManager.shared

    func addPlan(name: String, location: String, photoURL: String, startDate: Date, trip: TripModel, type: PlanType) {
        Task {
            await planManager.addPlan(name: name, location: location, photoURL: photoURL,startDate: startDate, trip: trip, type: type)
        }
    }
}
