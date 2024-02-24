//
//  LoginView.swift
//  Planify
//
//  Created by Andra Bejan on 21.02.2024.
//

import SwiftUI

struct WelcomeView: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var path = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $path) {
            ZStack {
                VStack {
                    HStack {
                        Image(systemName: "house.fill")
                        
                        Text("Planify")
                            .font(.system(size: 30))
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    }
                    .padding(.vertical, 20)
                    
                    Image(systemName: "house.fill")
                        .resizable()
                        .frame(width: 300, height: 400)
                    
                    Text("Welcome to Planify")
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .font(.system(size: 30))
                        .padding(.vertical, 20)
                    
                    Text("Embark on a journey of seamless planning and endless discoveries with Planify!")
                        .foregroundStyle(colorScheme == .dark ? Color(UIColor.lightGray) : Color(UIColor.darkGray))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal,50)
                        .font(.system(size: 14))
                    
                    Spacer()
                    
                    AuthNavLinkView(value: "LogInView", text: "Log in")
                    
                    AuthNavLinkView(value: "RegisterView", text: "Register")
                        .padding(.bottom, 20)
                }
                .navigationDestination(for: String.self) { value in
                    switch value {
                        case "LogInView": LoginView(path: $path)
                        case "RegisterView": RegisterView(path: $path)
                        default: Text("View not found")
                    }
                }
            }
        }
    }
}

#Preview {
    WelcomeView()
}
