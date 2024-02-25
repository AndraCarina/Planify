//
//  ImageLoader.swift
//  Planify
//
//  Created by Andra Bejan on 25.02.2024.
//

import Foundation
import SwiftUI

class ImageLoader: ObservableObject {
    @Published var image: UIImage?

    private var url: String
    private var task: URLSessionDataTask?

    init(url: String) {
        self.url = url
        loadImage()
    }

    private func loadImage() {
        if let cachedImage = ImageCache.shared.get(forKey: url) {
            self.image = cachedImage
            return
        }

        guard let url = URL(string: url) else { return }

        task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else { return }

            DispatchQueue.main.async {
                let image = UIImage(data: data)
                self.image = image
                ImageCache.shared.set(image!, forKey: self.url)
            }
        }
        task?.resume()
    }
}
