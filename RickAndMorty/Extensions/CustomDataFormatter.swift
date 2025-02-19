//
//  CustomDataFormatter.swift
//  RickAndMorty
//
//  Created by Rodelin Dipre on 12/2/24.
//

import Foundation

extension DateFormatter {
    static func customDateFormatter() -> DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        return formatter
    }
}
