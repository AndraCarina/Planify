//
//  AddPlanView.swift
//  Planify
//
//  Created by Andra Bejan on 24.02.2024.
//

import SwiftUI

struct AddTripView: View {
    @SceneStorage("selectedTabIndex") var selectedTabIndex: Int = 0
    @ObservedObject var viewModel = AddTripViewModel()
    @State private var path = NavigationPath()
    @State private var tripName = ""
    @State private var location = ""
    @State private var startDate = Date()
    @State private var endDate = Date().addingTimeInterval(86400)
    @State private var photoURL = ""

    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                Button {
                    path.append("ImagePickerView")
                } label: {
                    if photoURL.isEmpty {
                        Image(systemName: "photo")
                            .resizable()
                            .scaledToFit()
                            .scaleEffect(0.8)
                            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width)
                            .clipped()
                    } else {
                        RemoteImageView(url: photoURL)
                            .scaledToFill()
                            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width)
                            .clipped()
                    }
                }
                
                TextField("Trip Name", text: $tripName)
                    .padding()
                    .font(.title)
                
                TextField("Location", text: $location)
                    .padding()
                    .font(.subheadline)
                
                DatePicker("Select start date", selection: $startDate, displayedComponents: .date)
                    .padding()
                
                DatePicker("Select end date", selection: $endDate, in: startDate..., displayedComponents: .date)
                    .padding()
                
                AuthButtonView(text: "Add trip", icon: "plus") {
                    viewModel.addTrip(tripName: tripName, location: location, photoURL: photoURL, startDate: startDate, endDate: endDate)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                        selectedTabIndex = 0
                    }
                }
                
                Spacer()
            }
            .ignoresSafeArea()
            .navigationDestination(for: String.self) { value in
                switch value {
                    case "ImagePickerView": AddTripHeaderPhotoView(path: $path, photoURL: $photoURL)
                    default: Text("View not found")
                }
            }
        }
    }
}

#Preview {
    AddTripView()
}
