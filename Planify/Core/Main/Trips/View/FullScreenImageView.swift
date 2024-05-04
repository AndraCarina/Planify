//
//  FullScreenImageView.swift
//  Planify
//
//  Created by Andra Bejan on 04.05.2024.
//

import SwiftUI

struct FullScreenImageView: View {
    let photoURL: String
    @Binding var path: NavigationPath
    
    var body: some View {
        VStack {
            RemoteImageView(url: photoURL)
                .scaledToFill()
        }
        .navigationBarBackButtonHidden()
        .navigationBarTitleDisplayMode(.inline)
        .ignoresSafeArea()
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
    FullScreenImageView(photoURL: "https://media.cntraveler.com/photos/591f1c7d1f187a2af3dedef0/16:9/w_2580,c_limit/barcelona-park-guell-GettyImages-512152500.jpg", path: .constant(NavigationPath()))
}
