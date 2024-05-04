//
//  ProgressView.swift
//  Planify
//
//  Created by Andra Bejan on 21.02.2024.
//

import SwiftUI

struct LoadingView: View {
    @State var moveAlongCirclePath = false
    @State private var progress: Double = 0
    let timer = Timer.publish(every: 0.02, on: .main, in: .common).autoconnect()
    let totalTime = 2.0
    
    var body: some View {
        VStack {
            ZStack {
                Image(systemName: "globe.europe.africa.fill")
                    .resizable()
                    .frame(width: UIScreen.main.bounds.width - 100, height: UIScreen.main.bounds.width - 100)
                    .foregroundStyle(Color(.blue))
                
                Image(systemName: "airplane")
                    .scaleEffect(2)
                    .foregroundStyle(Color(.blue))
                    .offset(y: -150)
                    .shadow(color: Color(.black), radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                    
                .font(.largeTitle)
                .rotationEffect(.degrees(moveAlongCirclePath ? 0 : -360))
                .animation(.linear(duration: 5).repeatForever(autoreverses: false), value: moveAlongCirclePath)
                .onAppear {
                    self.moveAlongCirclePath.toggle()
                }
            }
            
            Text(String(format: "%.0f%%", progress * 100))
                .font(.largeTitle)
                .bold()
            
            ProgressView(value: progress, total: 1.0)
                .progressViewStyle(LinearProgressViewStyle(tint: Color.blue))
                .frame(width: 200)
        }
        .onReceive(timer) { time in
            let increment = 0.02 / totalTime
            if progress + increment > 1.0 {
                progress = 1.0
                timer.upstream.connect().cancel()
            } else {
                progress += increment
            }
        }
        .onAppear {
            progress = 0
        }
    }
}

#Preview {
    LoadingView()
}
