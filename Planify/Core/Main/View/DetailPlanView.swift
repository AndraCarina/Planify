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
                    
                    Text(trip.startDate + "-" + trip.endDate)
                        .font(.subheadline)
                        .foregroundStyle(Color.white)
                        .shadow(color: .black, radius: 1)
                        .padding(.bottom, 20)
                }
            }
    }
}

struct DetailPlanView: View {
    let trip: TripModel
    @Binding var path: NavigationPath
    @ObservedObject var viewModel = DetailPlanViewModel()
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack {
            TripHeaderView(trip: trip)
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
                        Button {
                            viewModel.markTripFinished(trip: trip)
                            path = NavigationPath()
                        } label: {
                            Text("Mark as finished")
                        }
                        
                        Button(role: .destructive){
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
    }
}

#Preview {
    DetailPlanView(trip: TripModel(id: "123", userId: "123", name: "Barcelona Fun", location: "Barcelona, Spain", photoURL: "https://media.cntraveler.com/photos/591f1c7d1f187a2af3dedef0/16:9/w_2580,c_limit/barcelona-park-guell-GettyImages-512152500.jpg", startDate: "02.03.2024", endDate: "03.03.2024", isFinished: "false"), path: .constant(NavigationPath()))
}
