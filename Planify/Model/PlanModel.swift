//
//  PlanModel.swift
//  Planify
//
//  Created by Andra Bejan on 24.02.2024.
//

import Foundation

struct PlanModel: Identifiable, Codable {
    let id: String
    let taskId: String
    let name: String
    let location: String
    let photoURL: String
    let startDate: String
    let endDate: String
}
