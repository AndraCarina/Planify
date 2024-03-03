//
//  ImagePickerView.swift
//  Planify
//
//  Created by Andra Bejan on 02.03.2024.
//

import SwiftUI

struct AddTripHeaderPhotoView: View {
    @Binding var path: NavigationPath
    @Binding var photoURL: String
    @ObservedObject var viewModel = AddTripHeaderPhotoViewModel()

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        VStack {
            TextField("Search Images", text: $viewModel.searchText, onCommit: viewModel.searchImages)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())

            ScrollView {
                LazyVGrid(columns: columns, spacing: 0) {
                    ForEach(viewModel.imageResults, id: \.id) { image in
                        Button(action: {
                            photoURL = image.urls.regular
                            path = NavigationPath()
                        }) {
                            RemoteImageView(url: image.urls.thumb)
                                .scaledToFill()
                                .frame(width: UIScreen.main.bounds.width/3, height: UIScreen.main.bounds.width/3)
                                .clipped()
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
            }
            .padding(0)
        }
    }
}


struct SearchResponse: Decodable {
    let results: [UnsplashImage]
}

struct UnsplashImage: Decodable, Identifiable {
    let id: String
    let urls: ImageURLs
}

struct ImageURLs: Decodable {
    let thumb: String
    let regular: String
}

#Preview {
    AddTripHeaderPhotoView(path: .constant(NavigationPath()), photoURL: .constant(""))
}
