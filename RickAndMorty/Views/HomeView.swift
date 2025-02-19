//
//  HomeView.swift
//  RickAndMorty
//
//  Created by Rodelin Dipre on 12/2/24.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        TabView {
            Tab {
                RickMortyView()
            } label: {
                Label("Characters", systemImage: "person")
            }
            Tab {
                FavoritesListView()
            } label: {
                Label("Favorites", systemImage: "star")
            }
        }
    }
}

#Preview {
    HomeView()
        .environment(RickMortyListVM.preview)
        .environment(FavoritesVM())
}
