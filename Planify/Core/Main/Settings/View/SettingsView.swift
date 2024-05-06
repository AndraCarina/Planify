//
//  SettingsView.swift
//  Planify
//
//  Created by Andra Bejan on 24.02.2024.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject private var tripManager = TripManager.shared
    @ObservedObject private var planManager = PlanManager.shared
    @ObservedObject var viewModel = SettingsViewModel()
    var body: some View {
        VStack {
            List {
                Section {
                    HStack {
                        Text(viewModel.getInitials())
                            .font(.title)
                            .fontWeight(.semibold)
                            .foregroundStyle(Color(.white))
                            .frame(width: 72, height: 72)
                            .background(colorScheme == .dark ? Color(UIColor.lightGray) : Color(UIColor.darkGray))
                            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text(viewModel.getFullname())
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .padding(.top, 4)
                            
                            Text(viewModel.getSignInMethod())
                                .font(.footnote)
                                .accentColor(.gray)
                        }
                    }
                }
                
                Section("General") {
                    HStack {
                        SettingsRowView(imageName: "gear", title: "Version", tintColor: Color(.systemGray))
                        Spacer()
                        Text("1.0.0")
                            .font(.subheadline)
                    }
                }
                
                Section("Statistics")
                {
                    HStack {
                        SettingsRowView(imageName: "paperplane", title: "Total trips", tintColor: Color(.systemGray))
                        Spacer()
                        Text(viewModel.getNumberOfTrips())
                            .font(.subheadline)
                    }
                    
                    HStack {
                        SettingsRowView(imageName: "map", title: "Total plans", tintColor: Color(.systemGray))
                        Spacer()
                        Text(viewModel.getNumberOfPlans())
                            .font(.subheadline)
                    }
                }
                
                Section("Account") {
                    Button {
                        viewModel.signOut()
                    } label: {
                        SettingsRowView(imageName: "arrow.left.circle.fill", title: "Sign out", tintColor: Color(.red))
                            .foregroundColor(colorScheme == .dark ? Color(UIColor.white) : Color(UIColor.black))
                    }
                    
                    Button {
                        viewModel.deleteUser()
                    } label: {
                        SettingsRowView(imageName: "xmark.circle.fill", title: "Delete account", tintColor: Color(.red))
                            .foregroundColor(colorScheme == .dark ? Color(UIColor.white) : Color(UIColor.black))
                    }
                }
            }
        }
    }
}

#Preview {
    SettingsView()
}
