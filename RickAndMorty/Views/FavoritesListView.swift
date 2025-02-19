//
//  FavoritesListView.swift
//  RickAndMorty
//
//  Created by Rodelin Dipre on 12/2/24.
//

import SwiftUI

struct FavoritesListView: View {
    @Environment(FavoritesVM.self) var vm
    
    var body: some View {
        NavigationStack {
            listFavorites
            .navigationTitle("Favorites")
            .navigationDestination(for: CharacterModel.self) { character in
                DetailCharacterView(character: character)
            }
        }
    }
    
    @ViewBuilder
    var listFavorites: some View {
        if vm.favChars.isEmpty {
            VStack {
                Image(systemName: "star.slash.fill")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.gray)
                Text("No favorites yet")
                    .font(.headline)
            }
        } else {
            List(vm.favChars) { character in
                NavigationLink(value: character) {
                    CharacterCell(character: character)
                }
            }
        }
    }
}

#Preview {
    FavoritesListView()
        .environment(FavoritesVM())
}
