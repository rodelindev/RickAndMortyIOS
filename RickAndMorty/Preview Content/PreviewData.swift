//
//  PreviewData.swift
//  RickAndMorty
//
//  Created by Rodelin Dipre on 2/19/25.
//

import Foundation

struct RepositoryMortyPreview: ProtocolMorty {
    func getCharacterList(page: String, name: String, status: CharacterStatus) async throws(NetworkError) -> RickMortyModel {
        do {
            let url = Bundle.main.url(forResource: "RickMortyMockData", withExtension: "json")!
            let data = try Data(contentsOf: url)
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .formatted(.customDateFormatter())
            return try decoder.decode(RickMortyModelDTO.self, from: data).mapToModel
        } catch {
            throw .generalError(error)
        }
    }
}

extension CharacterModel {
    static let preview = CharacterModel(
        id: 1,
        name: "Abadango Cluster Princess",
        status: .unknown,
        species: "Alien",
        gender: "Female",
        image: URL(string: "https://rickandmortyapi.com/api/character/avatar/6.jpeg")!,
        created: .now,
        origin: CharacterOriginModel(name: "Tierra"),
        isFavorite: false
    )
}

@MainActor
extension RickMortyListVM {
    static let preview = RickMortyListVM(repository: RepositoryMortyPreview())
}
