//
//  DetailPlanViewModel.swift
//  Planify
//
//  Created by Andra Bejan on 02.03.2024.
//

import Foundation
import SwiftUI

class TripViewModel: ObservableObject {
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
        
        let filterPlans = planManager.plans.filter { $0.tripId.localizedCaseInsensitiveContains(trip.id) }
        let sortedPlans = filterPlans.sorted { $0.startDate < $1.startDate }
        
        return sortedPlans
    }
    
    func deleteTrip(trip: TripModel) {
        Task {
            await tripManager.deleteTrip(trip: trip)
        }
    }
    
    func deletePlan(plan: PlanModel) {
        Task {
            await planManager.deletePlan(plan: plan)
        }
    }
    
    func getSetOfStartDates(trip: TripModel) -> [String] {
        var uniqueStartDates: Set<String> = Set()
        
        for plan in filteredPlans(trip: trip) {
            uniqueStartDates.insert(convertDateToString(date: plan.startDate))
        }
        
        let sortedUniqueStartDates = uniqueStartDates.sorted { $0 < $1 }
        
        return sortedUniqueStartDates
    }
    
    func convertDateToString(date: Date) -> String {
        return DateFormatter.localizedString(from: date, dateStyle: .short, timeStyle: .none)
    }
    
    func filteredPlansByDate(trip: TripModel, date: String) -> [PlanModel] {
        // Filter plans based on trip ID and date
        let filteredPlans = planManager.plans.filter {
            $0.tripId.localizedCaseInsensitiveContains(trip.id) &&
            convertDateToString(date: $0.startDate) == date
        }
        
        // Sort the filtered plans by startDate
        let sortedPlans = filteredPlans.sorted { $0.startDate < $1.startDate }
        
        return sortedPlans
    }
    
    func convertDateToTime(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: date)
    }
}
