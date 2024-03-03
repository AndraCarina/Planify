//
//  AddPlanView.swift
//  Planify
//
//  Created by Andra Bejan on 03.03.2024.
//

import SwiftUI

struct AddPlanView: View {
    let trip: TripModel
    @State private var planName = ""
    @State private var location = ""
    @State private var startDate = Date()
    @State private var endDate = Date().addingTimeInterval(86400)
    @State private var photoURL = ""
    @Binding var path: NavigationPath
    @ObservedObject private var viewModel = AddPlanViewModel()
    var body: some View {
        VStack {
            TextField("Plan Name", text: $planName)
                .padding()
                .font(.title)
            
            TextField("Location", text: $location)
                .padding()
                .font(.subheadline)
            
            DatePicker("Select start date", selection: $startDate, in: trip.startDate...trip.endDate)
                .padding()
            
            AuthButtonView(text: "Add plan", icon: "plus") {
                viewModel.addPlan(name: planName, location: location, photoURL: "", startDate: startDate, trip: trip)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                    path.removeLast()
                }
            }
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
        }
    }
}

#Preview {
    AddPlanView(trip: TripModel(id: "123", userId: "123", name: "Barcelona Fun", location: "Barcelona, Spain", photoURL: "https://media.cntraveler.com/photos/591f1c7d1f187a2af3dedef0/16:9/w_2580,c_limit/barcelona-park-guell-GettyImages-512152500.jpg", startDate: Date.now, endDate: Date.now, isFinished: "false"), path: .constant(NavigationPath()))
}
