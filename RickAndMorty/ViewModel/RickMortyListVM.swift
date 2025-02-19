//
//  RickAndMortyListVM.swift
//  RickAndMorty
//
//  Created by Rodelin Dipre on 12/2/24.
//

import Foundation

enum ViewListStatus {
    case loading, error, loaded
}

@Observable
final class RickMortyListVM {
    let repository: ProtocolMorty
    var characters = [CharacterModel]()
    var rickInfo: RickMortyModel?
    private var searchTask: Task<Void, Never>?
    
    private var page: Int = 1
    var searchedName: String = ""
    
    var errorMessage = ""
    var showAlert = false
    
    var characterStatus: CharacterStatus = .all
    var viewListStatus: ViewListStatus = .loading
    var newPageLoading: Bool = false
    
    init(repository: ProtocolMorty = RepositoryMortyAPI()) {
        self.repository = repository
    }
    
    func resetInitialValue() {
        page = 1
        characters.removeAll()
    }
    
}

@MainActor
extension RickMortyListVM {
    
    func loadCharacters() async {
        do {
            let rickInfo = try await repository.getCharacterList(page: String(page), name: searchedName, status: characterStatus)
            self.rickInfo = rickInfo
            characters += rickInfo.results
            newPageLoading = false
            viewListStatus = .loaded
        } catch {
            if searchedName.isEmpty {
                errorMessage = error.errorDescription
                viewListStatus = .error
            } else {
                viewListStatus = .loaded
            }
        }
    }
    
    private func isLastItem(character: CharacterModel) -> Bool {
        characters.last?.id == character.id
    }
    
    func loadNextPage(character: CharacterModel) {
        guard let info = rickInfo,
              let _ = info.info.next else { return }
        if isLastItem(character: character) {
            page += 1
            Task {
                await loadCharacters()
            }
        }
    }
    
    func searchCharacter() {
        characters.removeAll()
        viewListStatus = .loading
        Task {
            await loadCharacters()
        }
    }
    
}

