//
//  LoginView.swift
//  Planify
//
//  Created by Andra Bejan on 21.02.2024.
//

import SwiftUI

struct WelcomeView: View {
    @State private var path = NavigationPath()
    var body: some View {
        NavigationStack(path: $path) {
            ZStack {
                Color("AppBackgroundColor").ignoresSafeArea()
                
                VStack {
                    HStack {
                        Image(systemName: "house.fill")
                            .foregroundStyle(.white)
                        
                        Text("Planify")
                            .foregroundStyle(.white)
                            .font(.system(size: 30))
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    }
                    .padding(.vertical, 20)
                    
                    Image(systemName: "house.fill")
                        .resizable()
                        .frame(width: 300, height: 400)
                        .foregroundStyle(.white)
                    
                    Text("Welcome to Planify")
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .foregroundStyle(.white)
                        .font(.system(size: 30))
                        .padding(.vertical, 20)
                    
                    Text("Embark on a journey of seamless planning and endless discoveries with Planify!")
                        .foregroundStyle(Color(UIColor.lightGray))
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
        .accentColor(.white)
    }
}

#Preview {
    WelcomeView()
}
