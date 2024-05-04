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
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject private var viewModel = PlanViewModel()
    var body: some View {
        VStack {
            Image(systemName: plan.type.systemImage)
                .resizable()
                .scaledToFit()
                .foregroundStyle(plan.type.imageColor)
                .frame(width: 50, height: 50)
                .padding()
            
            HStack {
                Text("Name")
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .foregroundStyle(colorScheme == .dark ? Color(UIColor.lightGray) : Color(UIColor.darkGray))
                    .font(.system(size: 14))
                    .padding(.leading, 16)
                Spacer()
            }
            
            HStack {
                Text(plan.name)
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .padding(.leading, 16)
                Spacer()
            }
            .padding(.bottom, 1)
            
            HStack {
                Text("Location")
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .foregroundStyle(colorScheme == .dark ? Color(UIColor.lightGray) : Color(UIColor.darkGray))
                    .font(.system(size: 14))
                    .padding(.leading, 16)
                Spacer()
            }
            
            HStack {
                Text(plan.location)
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .padding(.leading, 16)
                Spacer()
            }
            .padding(.bottom, 1)
            
            HStack {
                Text("Time")
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .foregroundStyle(colorScheme == .dark ? Color(UIColor.lightGray) : Color(UIColor.darkGray))
                    .font(.system(size: 14))
                    .padding(.leading, 16)
                Spacer()
            }
            
            HStack {
                Text(DateFormatter.localizedString(from: plan.startDate, dateStyle: .short, timeStyle: .short))
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    .padding(.leading, 16)
                Spacer()
            }
            
            if plan.photoURL != "" {
                Button {
                    path.append("FullScreenImageView")
                } label: {
                    RemoteImageView(url: plan.photoURL)
                        .scaledToFill()
                        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width)
                        .clipped()
                }
            }
            
            Spacer()
        }
        .navigationBarBackButtonHidden()
        .navigationBarTitleDisplayMode(.inline)
        .navigationDestination(for: String.self) { value in
            switch value {
            case "FullScreenImageView": FullScreenImageView(photoURL: plan.photoURL, path: $path)
                default: Text("View not found")
            }
        }
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
    PlanView(plan: PlanModel(id: "123", userId: "123", tripId: "123", name: "Restaurant", location: "RestaurantLocation", photoURL: "https://media.cntraveler.com/photos/591f1c7d1f187a2af3dedef0/16:9/w_2580,c_limit/barcelona-park-guell-GettyImages-512152500.jpg", startDate: Date.now, type: PlanType.food), path: .constant(NavigationPath()))
}
