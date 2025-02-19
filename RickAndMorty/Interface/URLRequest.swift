//
//  URLRequest.swift
//  RickAndMorty
//
//  Created by Rodelin Dipre on 11/28/24.
//

import Foundation

extension URLRequest {
    static func get(url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        return request
    }
}
