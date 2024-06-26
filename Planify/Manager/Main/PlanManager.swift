//
//  PlanManager.swift
//  Planify
//
//  Created by Andra Bejan on 03.03.2024.
//

import Foundation
import SwiftUI
import FirebaseFirestore
import FirebaseStorage

@MainActor
class PlanManager: ObservableObject {
    static let shared = PlanManager()
    var plans: [PlanModel] = [] {
        didSet {
            objectWillChange.send()
        }
    }
    
    private init() {
        
    }
    
    func addPlan(name: String, location: String, startDate: Date, trip: TripModel, type: PlanType, image: UIImage?) async {
        do {
            let uniqueID = Firestore.firestore().collection("plans").document().documentID
            
            var photoURLString = ""
            
            if image != nil {
                let storageRef = Storage.storage().reference().child("\(uniqueID).jpeg")
                let resizedImage = image?.jpegData(compressionQuality: 1.0)
                let metadata = StorageMetadata()
                metadata.contentType = "image/jpg"
                
                let _ = try await storageRef.putDataAsync(resizedImage!, metadata: metadata)
                let photoURL = try await storageRef.downloadURL()
                photoURLString = "\(photoURL)"
            }
            
            let plan = PlanModel(id: uniqueID, userId: AuthManager.shared.firebaseUser!.uid, tripId: trip.id, name: name, location: location, photoURL: photoURLString, startDate: startDate, type: type)
            
            let encodedPlan = try Firestore.Encoder().encode(plan)
            
            /* Upload encoded user to Firestore. */
            try await Firestore.firestore().collection("plans").document(uniqueID).setData(encodedPlan)
            plans.append(plan)
        } catch {
            
        }
    }
    
    func deletePlan(plan: PlanModel) async {
        do {
            if plan.photoURL != "" {
                let storageRef = Storage.storage().reference().child("\(plan.id).jpeg")
                try await storageRef.delete()
            }
            try await Firestore.firestore().collection("plans").document(plan.id).delete()
            if let index = plans.firstIndex(where: { $0.id == plan.id }) {
                plans.remove(at: index)
            }
        } catch {
            
        }
    }
    
    func fetchPlans(userId: String) async {
        do {
            /* Query the database for all the plans for a userId. */
            let snapshot = try await Firestore.firestore().collection("plans").whereField("userId", isEqualTo: userId).getDocuments()
            /* Transform query results to TripModel objects. */
            let plans = snapshot.documents.compactMap { document -> PlanModel? in
                guard let plan = try? document.data(as: PlanModel.self) else {
                    // Handle any decoding errors if necessary
                    return nil
                }
                return plan
            }
            
            /* Update the trips property with the fetched trips. */
            self.plans = plans
            
            for plan in self.plans {
                let _ = RemoteImageView(url: plan.photoURL)
            }
        } catch {
            
        }
    }
}
