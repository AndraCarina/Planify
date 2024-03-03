//
//  PlanModel.swift
//  Planify
//
//  Created by Andra Bejan on 24.02.2024.
//

import Foundation

struct PlanModel: Identifiable, Codable, Hashable {
    let id: String
    let userId: String
    let tripId: String
    let name: String
    let location: String
    let photoURL: String
    let startDate: Date
}
