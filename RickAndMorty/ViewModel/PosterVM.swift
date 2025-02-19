//
//  PosterVM.swift
//  RickAndMorty
//
//  Created by Rodelin Dipre on 2/19/25.
//
import Foundation
import SwiftUI

@Observable @MainActor
final class PosterVM {
    var rickImage: UIImage?
    
    func getImage(url: URL) {
        let urlCache = URL.cachesDirectory.appending(path: url.lastPathComponent)
        if FileManager.default.fileExists(atPath: urlCache.path()) {
            if let data = try? Data(contentsOf: urlCache) {
                rickImage = UIImage(data: data)
            }
        } else {
            Task {
                await getNetworkImage(url: url)
            }
        }
    }
    
    
    private func getNetworkImage(url: URL) async {
        do {
           rickImage = try await ImageDownloader.shared.getImage(url: url)
        } catch {
            //
        }
    }
}
