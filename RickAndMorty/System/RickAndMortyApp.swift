//
//  RickAndMortyApp.swift
//  RickAndMorty
//
//  Created by Rodelin Dipre on 11/27/24.
//

import SwiftUI

@main
struct RickAndMortyApp: App {
    @State var vm = RickMortyListVM()
    @State var favVM = FavoritesVM()
    
    var body: some Scene {
        WindowGroup {
            HomeView()
                .environment(vm)
                .environment(favVM)
        }
    }
}
