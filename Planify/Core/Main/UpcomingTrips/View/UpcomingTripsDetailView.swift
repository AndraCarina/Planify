//
//  DetailPlanView.swift
//  Planify
//
//  Created by Andra Bejan on 02.03.2024.
//

import SwiftUI

struct TripHeaderView: View {
    let trip: TripModel
    var body: some View {
        RemoteImageView(url: trip.photoURL)
            .scaledToFill()
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width)
            .clipped()
            .brightness(-0.2)
            .blur(radius: 5.0, opaque: true)
            .overlay {
                VStack {
                    Spacer()
                    Text(trip.name)
                        .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .foregroundStyle(Color.white)
                        .shadow(color: .black, radius: 1)
                    
                    Text(trip.location)
                        .font(.subheadline)
                        .foregroundStyle(Color.white)
                        .shadow(color: .black, radius: 1)
                    
                    Text(DateFormatter.localizedString(from: trip.startDate, dateStyle: .short, timeStyle: .none) + "-" + DateFormatter.localizedString(from: trip.endDate, dateStyle: .short, timeStyle: .none))
                        .font(.subheadline)
                        .foregroundStyle(Color.white)
                        .shadow(color: .black, radius: 1)
                        .padding(.bottom, 20)
                }
            }
    }
}

struct UpcomingTripsDetailView: View {
    let trip: TripModel
    @Binding var path: NavigationPath
    @ObservedObject var viewModel = UpcomingTripsDetailViewModel()
    @ObservedObject private var planManager = PlanManager.shared
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack {
            TripHeaderView(trip: trip)
            List {
                let uniqueStartDates = viewModel.getSetOfStartDates(trip: trip)
                ForEach(uniqueStartDates, id: \.self) { uniqueStartDate in
                    Section(header: Text("\(uniqueStartDate)")) {
                        ForEach(viewModel.filteredPlansByDate(trip: trip, date: uniqueStartDate)) { plan in
                            NavigationLink(value: plan) {
                                HStack {
                                    Image(systemName: plan.type.systemImage)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 20, height: 20)
                                    Text(plan.name)
                                    Spacer()
                                    Text(viewModel.convertDateToTime(date: plan.startDate))
                                }
                            }
                            .listRowInsets(EdgeInsets(top: 0, leading: 15, bottom: 0, trailing: 15))
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .listStyle(.plain)
            Spacer()
        }
        .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading){
                Button {
                    path = NavigationPath()
                } label: {
                    ToolbarButtonView(imageName: "arrow.backward")
                }
            }
            ToolbarItem(placement: .topBarTrailing){
                Menu {
                    VStack {
                        NavigationLink(value: 1) {
                            Text("Add new plan")
                        }
                        Button {
                            viewModel.markTripFinished(trip: trip)
                            path = NavigationPath()
                        } label: {
                            Text("Mark as finished")
                        }
                        
                        Button(role: .destructive){
                            viewModel.deleteTrip(trip: trip)
                            path = NavigationPath()
                        } label: {
                            Text("Delete trip")
                        }
                    }
                } label: {
                    ToolbarButtonView(imageName: "ellipsis")
                }
            }
        }
        .navigationDestination(for: Int.self) {value in
            AddPlanView(trip: trip, path: $path)
        }
        .navigationDestination(for: PlanModel.self) {plan in
            PlanDetailView(plan: plan, path: $path)
        }
    }
}

#Preview {
    UpcomingTripsDetailView(trip: TripModel(id: "123", userId: "123", name: "Barcelona Fun", location: "Barcelona, Spain", photoURL: "https://media.cntraveler.com/photos/591f1c7d1f187a2af3dedef0/16:9/w_2580,c_limit/barcelona-park-guell-GettyImages-512152500.jpg", startDate: Date.now, endDate: Date.now, isFinished: "false"), path: .constant(NavigationPath()))
}
