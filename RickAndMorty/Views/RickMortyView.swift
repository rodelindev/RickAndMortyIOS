//
//  ContentView.swift
//  RickAndMorty
//
//  Created by Rodelin Dipre on 11/27/24.
//

import SwiftUI

struct RickMortyView: View {
    @Environment(RickMortyListVM.self) var vm
    @Environment(FavoritesVM.self) var fvVM
    
    @State private var timer: Timer?
    @Namespace private var namespace
    
    var body: some View {
        @Bindable var bvm = vm
        NavigationStack {
            VStack {
                switch vm.viewListStatus {
                case .loading:
                    ProgressView()
                case .error:
                    CustomErrorView(
                        errorTitle: "Something went wrong",
                        errorMessage: vm.errorMessage,
                        retryAction: {
                            Task {
                                await vm.loadCharacters()
                            }
                        }
                    )
                case .loaded:
                    listSearch
                }
            }
            .navigationTitle("Rick Characters")
            .navigationDestination(for: CharacterModel.self) { character in
                DetailViewRickAndMorty(character: character)
            }
            .searchable(text: $bvm.searchedName, prompt: "Search character")
            .animation(.easeInOut, value: vm.characters)
            .onChange(of: vm.searchedName) {
                timer?.invalidate()
                timer = .scheduledTimer(withTimeInterval: 0.6, repeats: false) { _ in
                    Task { @MainActor in
                        vm.searchCharacter()
                    }
                }
            }
            .onChange(of: vm.characterStatus) {
                vm.resetInitialValue()
                Task {
                    await vm.loadCharacters()
                }
            }
            .task {
                await vm.loadCharacters()
            }
            .customToolBar(charStatus: $bvm.characterStatus)
        }
        
    }
    
    @ViewBuilder
    var listSearch: some View {
        if vm.characters.isEmpty {
            ContentUnavailableView(
                "No character found",
                systemImage: "person",
                description: Text(
                    "No character found with name '\(vm.searchedName)'"
                )
            )
        } else {
            List(vm.characters) { character in
                NavigationLink(value: character) {
                    CharacterCell(character: character)
                }
            }
            .overlay(alignment: .bottom) {
                if vm.newPageLoading {
                    ProgressView()
                }
            }
        }
    }
}

#Preview {
    RickMortyView()
        .environment(RickMortyListVM.preview)
        .environment(FavoritesVM())
}
