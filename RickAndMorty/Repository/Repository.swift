//
//  Repository.swift
//  RickAndMorty
//
//  Created by Rodelin Dipre on 11/28/24.
//

import Foundation

protocol ProtocolMorty: Sendable {
    func getCharacterList(page: String, name: String, status: CharacterStatus) async throws(NetworkError) -> RickMortyModel
}

struct RepositoryMortyAPI: ProtocolMorty, NetworkInteractor {
    func getCharacterList(page: String, name: String, status: CharacterStatus) async throws(NetworkError) -> RickMortyModel {
        try await getJSON(request: .get(url: .getCharacters(page: page, name: name, status: status)), model: RickMortyModelDTO.self).mapToModel
    }
}
