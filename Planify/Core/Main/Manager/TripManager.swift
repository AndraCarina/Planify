//
//  TripManager.swift
//  Planify
//
//  Created by Andra Bejan on 24.02.2024.
//

import Foundation
import SwiftUI
import FirebaseFirestore
import URLImage

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
    
    func addTrip(name: String, location: String, photoURL: String, startDate: String, endDate: String) async {
        do {
            let uniqueID = Firestore.firestore().collection("trips").document().documentID
            
            let trip = TripModel(id: uniqueID, userId: AuthManager.shared.firebaseUser!.uid, name: name, location: location, photoURL: photoURL, startDate: startDate, endDate: endDate, isFinished: "false")
            
            let encodedTrip = try Firestore.Encoder().encode(trip)
            
            /* Upload encoded user to Firestore. */
            try await Firestore.firestore().collection("trips").document(uniqueID).setData(encodedTrip)
            trips.append(trip)
        } catch {
            
        }
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
            
            for trip in self.trips {
                let _ = RemoteImageView(url: trip.photoURL)
            }
        } catch {
            
        }
    }
    
    func deleteTrip(trip: TripModel) async {
        do {
            try await Firestore.firestore().collection("trips").document(trip.id).delete()
            if let index = trips.firstIndex(where: { $0.id == trip.id }) {
                trips.remove(at: index)
            }
        } catch {
            
        }
    }
}
