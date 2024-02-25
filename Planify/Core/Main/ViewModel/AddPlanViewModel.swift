//
//  AddPlanViewModel.swift
//  Planify
//
//  Created by Andra Bejan on 24.02.2024.
//

import Foundation
import SwiftUI
import FirebaseFirestore

class AddPlanViewModel: ObservableObject {
    @ObservedObject private var authManager = AuthManager.shared
    @ObservedObject private var tripManager = TripManager.shared
    
    func addTrip() {
        Task {
            do {
                let uniqueID = Firestore.firestore().collection("trips").document().documentID
                let startDate = DateFormatter.localizedString(from: Date(), dateStyle: .short, timeStyle: .none)
                let endDate = DateFormatter.localizedString(from: Calendar.current.date(byAdding: .hour, value: 2, to: Date())!, dateStyle: .short, timeStyle: .none)
                
                let trip = TripModel(id: uniqueID, userId: authManager.firebaseUser!.uid, name: "Barcelona", location: "Barcelona", photoURL: "https://hips.hearstapps.com/hmg-prod/images/gettyimages-1467072114-656f160a0a37b.jpg?crop=1.00xw:1.00xh;0,0&resize=1200:*", startDate: startDate, endDate: endDate, isFinished: "false")
                
                let encodedTrip = try Firestore.Encoder().encode(trip)
                
                /* Upload encoded user to Firestore. */
                try await Firestore.firestore().collection("trips").document(uniqueID).setData(encodedTrip)
                tripManager.addTrip(trip: trip)
            } catch {
            }
        }
    }
}
