//
//  AddPlanView.swift
//  Planify
//
//  Created by Andra Bejan on 03.03.2024.
//

import SwiftUI
import PhotosUI

struct AddPlanView: View {
    let trip: TripModel
    @State private var planName = ""
    @State private var location = ""
    @State private var startDate = Date()
    @State private var endDate = Date().addingTimeInterval(86400)
    @State private var photoPick: PhotosPickerItem?
    @State private var photoImage: UIImage?
    @State private var planType: PlanType = .food
    @State private var categories: [PlanType] = [.food, .transport, .attraction, .event]

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
            
            Picker("Select plan type", selection: $planType) {
                ForEach(categories, id: \.self) { type in
                    HStack {
                        Image(systemName: type.systemImage)
                            .foregroundStyle(type.imageColor)
                    }
                }
            }
            .padding()
            .pickerStyle(SegmentedPickerStyle())
            
            PhotosPicker(selection: $photoPick, matching: .images) {
                if photoImage == nil {
                    HStack {
                        Image(systemName: "photo")
                            .foregroundColor(Color.white)
                        Text("Add image")
                            .foregroundStyle(.white)
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            .font(.system(size: 14))
                    }
                    .frame(width: UIScreen.main.bounds.width - 32, height: 40)
                    .background(Color(.systemBlue).clipShape(RoundedRectangle(cornerRadius:5)))
                }
                else {
                    Image(uiImage: photoImage!)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 300, height: 300)
                }
            }
            .onChange(of: photoPick) {
                Task {
                    do {
                        if let data = try await photoPick?.loadTransferable(type: Data.self) {
                            if let uiImage = UIImage(data: data) {
                                self.photoImage = uiImage
                            }
                        }
                    } catch {
                        print(error.localizedDescription)
                        photoPick = nil
                    }
                }
            }
            
            AuthButtonView(text: "Add plan", icon: "plus") {
                viewModel.addPlan(name: planName, location: location, startDate: startDate, trip: trip, type: planType, image: photoImage)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                    path.removeLast()
                }
            }
            
            Spacer()
        }
        .navigationBarBackButtonHidden()
        .navigationBarTitleDisplayMode(.inline)
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
