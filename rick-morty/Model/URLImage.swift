//
//  URLImageModel.swift
//  rick&morty
//
//  Created by Nataniel Marmucki on 17/02/2024.
//

import SwiftUI

struct URLImage: View {
    let url: String
    @State private var imageData: Data?
    
    var body: some View {
        VStack{
            if let data = imageData, let uiImage = UIImage(data: data) {
                Image(uiImage: uiImage)
                    .resizable()
            } else {
                Image(systemName: "person.crop.circle.dashed")
                    .resizable()
            }
        }
        .onAppear {
            loadImage()
        }
    }
    
    private func loadImage() {
        guard let url = URL(string: url) else { return }
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else { return }
            DispatchQueue.main.async {
                self.imageData = data
            }
        }.resume()
    }
}
