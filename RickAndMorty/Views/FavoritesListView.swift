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
                DetailViewRickAndMorty(character: character)
            }
        }
    }
    
    @ViewBuilder
    var listFavorites: some View {
        if vm.favChars.isEmpty {
            Text("No favorites yet")
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
