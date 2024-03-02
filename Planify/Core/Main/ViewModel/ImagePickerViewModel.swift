//
//  ImagePickerViewModel.swift
//  Planify
//
//  Created by Andra Bejan on 02.03.2024.
//

import Foundation
import SwiftUI

import SwiftUI

class ImagePickerViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published var imageResults: [UnsplashImage] = []

    func searchImages() {
        Task {
            guard let url = URL(string: "https://api.unsplash.com/search/photos?query=\(searchText)&client_id=EtSzveP-6Yj0wNUK7cvKo3bJfh2iI5MsjvLwgJoEKfI&per_page=30") else {
                return
            }

            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                let response = try JSONDecoder().decode(SearchResponse.self, from: data)
                DispatchQueue.main.async {
                    self.imageResults = response.results
                }
            } catch {
                print("Error fetching images: \(error)")
            }
        }
    }
}
