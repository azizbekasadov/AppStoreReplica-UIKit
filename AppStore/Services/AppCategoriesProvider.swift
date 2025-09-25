//
//  AppCategoriesProvider.swift
//  AppStore
//
//  Created by Azizbek Asadov on 26.09.2025.
//

import Foundation

protocol AppCategoriesProvider {
    func fetchAppCategories() async throws -> [AppCategory]
}

enum AppCategoriesProviderError: Error {
    case emptyList
    // ...
}


