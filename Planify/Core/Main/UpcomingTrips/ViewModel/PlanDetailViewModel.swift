//
//  PlanDetailViewModel.swift
//  Planify
//
//  Created by Andra Bejan on 03.03.2024.
//

import Foundation
import SwiftUI

class PlanDetailViewModel: ObservableObject {
    @ObservedObject private var planManager = PlanManager.shared
    
    func deletePlan(plan: PlanModel) {
        Task {
            await planManager.deletePlan(plan: plan)
        }
    }
}
