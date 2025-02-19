//
//  DetailViewRickAndMorty.swift
//  RickAndMorty
//
//  Created by Rodelin Dipre on 2/19/25.
//


import SwiftUI

struct DetailCharacterView: View {
    let character: CharacterModel
    @Environment(FavoritesVM.self) var favVM
    
    var body: some View {
        ScrollView {
            VStack(alignment: .center) {
                CharacterPoster(imageURL: character.image)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .frame(width: 450, height: 350)
                Text(character.name)
                    .font(.title2)
                    .bold()
                Spacer()
                Text("Status: \(character.status)")
                    .font(.footnote)
                Spacer()
                HStack {
                    Text("Specie: \(character.species)")
                        .font(.footnote)
                    Spacer()
                    Text("Gender: \(character.gender)")
                        .font(.footnote)
                }.padding(.horizontal, 90)
            }
            .padding(.horizontal, 100)
            .toolbar {
                Button {
                    favVM.saveFavorite(character: character)
                } label: {
                    Label("", systemImage: favVM.checkFavorite(character: character) ? "star.fill" : "star")
                }
            }
        }
    }
}

#Preview {
    DetailCharacterView(character: CharacterModel.preview)
        .environment(FavoritesVM())
}
