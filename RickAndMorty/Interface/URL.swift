//
//  URL.swift
//  RickAndMorty
//
//  Created by Rodelin Dipre on 11/27/24.
//

import Foundation

let mainURL = URL(string: "https://rickandmortyapi.com/api")!

extension URL {
    static func getCharacters(page: String, name: String, status: CharacterStatus) -> URL {
        mainURL
            .appending(path: "character")
            .appending(
                queryItems: [
                    .pageQuery(page: page),
                    .nameQuery(name: name),
                    .statusQuery(status: status)
                ]
            )
    }
    static func getCharacter(id: Int) -> URL {
        mainURL.appending(path: "character/\(id)")
    }
}

extension URLQueryItem {
    static func pageQuery(page: String) -> URLQueryItem {
        URLQueryItem(name: "page", value: page)
    }
    
    static func nameQuery(name: String) -> URLQueryItem {
        URLQueryItem(name: "name", value: name)
    }
    
    static func statusQuery(status: CharacterStatus) -> URLQueryItem {
        let statusString = switch status {
            case .all: ""
            case .alive: status.rawValue
            case .dead: status.rawValue
            case .unknown: status.rawValue
        }
        
        return URLQueryItem(name: "status", value: statusString)
    }
}
