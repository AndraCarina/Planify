//
//  TripModel.swift
//  Planify
//
//  Created by Andra Bejan on 24.02.2024.
//

import Foundation

struct TripModel: Identifiable, Codable, Hashable {
    let id: String
    let userId: String
    let name: String
    let location: String
    let photoURL: String
    let startDate: Date
    let endDate: Date
    var isFinished: String
}
