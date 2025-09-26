//
//  AppCategory.swift
//  AppStore
//
//  Created by Azizbek Asadov on 26.09.2025.
//

import Foundation

struct AppCategory: Equatable, Codable {
    let name: String?
    let app: [AppModel]
    
    static func == (lhs: AppCategory, rhs: AppCategory) -> Bool {
        lhs.name == rhs.name
    }
}
