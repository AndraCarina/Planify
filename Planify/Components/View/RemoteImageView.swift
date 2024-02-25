//
//  RemoteImageView.swift
//  Planify
//
//  Created by Andra Bejan on 25.02.2024.
//

import SwiftUI

struct RemoteImageView: View {
    @ObservedObject var imageLoader: ImageLoader

    init(url: String) {
        imageLoader = ImageLoader(url: url)
    }

    var body: some View {
        if let image = imageLoader.image {
            Image(uiImage: image)
                .resizable()
        } else {
            ProgressView()
        }
    }
}

#Preview {
    RemoteImageView(url: "https://hips.hearstapps.com/hmg-prod/images/gettyimages-1467072114-656f160a0a37b.jpg?crop=1.00xw:1.00xh;0,0&resize=1200:*")
}
