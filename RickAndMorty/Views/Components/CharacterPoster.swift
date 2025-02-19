//
//  CharacterPoster.swift
//  RickAndMorty
//
//  Created by Rodelin Dipre on 2/19/25.
//

import SwiftUI

struct CharacterPoster: View {
    @State var posterVM = PosterVM()
    let imageURL: URL
    
    var body: some View {
        VStack {
            if let image = posterVM.rickImage {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            } else {
                Image(systemName: "person")
            }
        }
        .onAppear {
            posterVM.getImage(url: imageURL)
        }
    }
}

#Preview {
    CharacterPoster(imageURL: CharacterModel.preview.image)
}
