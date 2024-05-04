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
    @State private var showingValidationAlert = false

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
                    .onChange(of: startDate) {
                        let calendar = Calendar.current
                        let components = calendar.dateComponents([.year, .month, .day], from: startDate)
                        if let startOfDay = calendar.date(from: components) {
                            startDate = startOfDay
                        }
                    }
                    .padding()
                
                DatePicker("Select end date", selection: $endDate, in: startDate..., displayedComponents: .date)
                    .onChange(of: endDate) {
                        let calendar = Calendar.current
                        var components = calendar.dateComponents([.year, .month, .day], from: endDate)
                        components.hour = 23
                        components.minute = 59
                        components.second = 59
                        if let endOfDay = calendar.date(from: components) {
                            endDate = endOfDay
                        }
                    }
                    .padding()
                
                AuthButtonView(text: "Add trip", icon: "plus") {
                    if viewModel.validateFields(tripName: tripName, location: location, photoURL: photoURL) {
                        viewModel.addTrip(tripName: tripName, location: location, photoURL: photoURL, startDate: startDate, endDate: endDate)
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
                            selectedTabIndex = 0
                            tripName = ""
                            location = ""
                            startDate = Date()
                            endDate = Date().addingTimeInterval(86400)
                            photoURL = ""
                        }
                    }
                    else {
                        showingValidationAlert = true
                    }
                }
                
                Spacer()
            }
            .alert("Validation Error", isPresented: $showingValidationAlert) {
                Button("OK", role: .cancel) { }
            } message: {
                Text("Please check your inputs. Make sure all fields are filled and dates are correct.")
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
