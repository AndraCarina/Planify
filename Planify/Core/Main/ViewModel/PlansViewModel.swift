//
//  PlansViewModel.swift
//  Planify
//
//  Created by Andra Bejan on 25.02.2024.
//

import Foundation
import SwiftUI

class PlansViewModel: ObservableObject {
    @ObservedObject private var tripManager = TripManager.shared
    
    func filteredTrips(searchTerm: String) -> [TripModel] {
        guard !searchTerm.isEmpty else {return tripManager.trips}
        return tripManager.trips.filter { $0.name.localizedCaseInsensitiveContains(searchTerm) }
    }
}
