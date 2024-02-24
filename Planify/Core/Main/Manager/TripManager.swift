//
//  TripManager.swift
//  Planify
//
//  Created by Andra Bejan on 24.02.2024.
//

import Foundation
import SwiftUI
import FirebaseFirestore

@MainActor
class TripManager: ObservableObject {
    static let shared = TripManager()
    var trips: [TripModel] = [] {
        didSet {
            objectWillChange.send()
        }
    }
    
    private init() {
        
    }
    
    func addTrip(trip: TripModel) {
        trips.append(trip)
    }
    
    func fetchTrips(userId: String) async {
        do {
            /* Query the database for all the trips for a userId. */
            let snapshot = try await Firestore.firestore().collection("trips").whereField("userId", isEqualTo: userId).getDocuments()
            /* Transform query results to TripModel objects. */
            let trips = snapshot.documents.compactMap { document -> TripModel? in
                guard let trip = try? document.data(as: TripModel.self) else {
                    // Handle any decoding errors if necessary
                    return nil
                }
                return trip
            }
            
            /* Update the trips property with the fetched trips. */
            self.trips = trips
        } catch {
            
        }
    }
}
