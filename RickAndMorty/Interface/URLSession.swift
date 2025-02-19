//
//  URLSession.swift
//  RickAndMorty
//
//  Created by Rodelin Dipre on 11/28/24.
//

import Foundation

extension URLSession {
    func getData(urlRequest: URLRequest) async throws(NetworkError) -> (data: Data, response: HTTPURLResponse) {
        do {
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            guard let response = response as? HTTPURLResponse else {
                throw NetworkError.nonHTTP
            }
            return (data, response)
        } catch {
            throw .badURLRequest(error)
        }
    }
}
