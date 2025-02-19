//
//  NetworkInteractor.swift
//  RickAndMorty
//
//  Created by Rodelin Dipre on 11/28/24.
//

import Foundation

protocol NetworkInteractor {}

extension NetworkInteractor {
    func getJSON<Model>(request: URLRequest, model: Model.Type) async throws(NetworkError) -> Model where Model: Codable {
        let (data, response) = try await URLSession.shared.getData(urlRequest: request)
            
        do {
            if response.statusCode == 200 {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .formatted(.customDateFormatter())
                return try decoder.decode(model, from: data)
            } else {
                throw NetworkError.badStatusCode(response.statusCode)
            }
        } catch {
            throw .badURLRequest(error)
        }
    }
}
