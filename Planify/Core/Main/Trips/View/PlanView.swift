//
//  PlanDetailView.swift
//  Planify
//
//  Created by Andra Bejan on 03.03.2024.
//

import SwiftUI

struct PlanView: View {
    let plan: PlanModel
    @Binding var path: NavigationPath
    @ObservedObject private var viewModel = PlanViewModel()
    var body: some View {
        VStack {
            Text(plan.name)
            RemoteImageView(url: plan.photoURL)
        }
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading){
                Button {
                    path.removeLast()
                } label: {
                    ToolbarButtonView(imageName: "arrow.backward")
                }
            }
            ToolbarItem(placement: .topBarTrailing){
                Menu {
                    VStack {
                        Button(role: .destructive){
                            viewModel.deletePlan(plan: plan)
                            path.removeLast()
                        } label: {
                            Text("Delete plan")
                        }
                    }
                } label: {
                    ToolbarButtonView(imageName: "ellipsis")
                }
            }
        }
    }
}

#Preview {
    PlanView(plan: PlanModel(id: "123", userId: "123", tripId: "123", name: "Resturant", location: "RestaurantLocation", photoURL: "", startDate: Date.now, type: PlanType.food), path: .constant(NavigationPath()))
}
