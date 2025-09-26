//
//  AppCategoriesProviderImplementaiton.swift
//  AppStore
//
//  Created by Azizbek Asadov on 26.09.2025.
//

import Foundation

enum AppCategoriesProviderSource {
    case local
    case server
}

extension AppCategory {
    static let mock: [AppCategory] = [
        {
            let bestApps = AppCategory(
                name: "Best Apps",
                app: [
                    AppModel(
                        id: 0,
                        name: "Frozen",
                        imageName: "frozen",
                        category: "Entertainment",
                        price: 3.99
                    )
                ]
            )
            
            return bestApps
        }(),
        {
            let bestApps = AppCategory(
                name: "Best New Games",
                app: [
                    AppModel(
                        id: 0,
                        name: "Telepaint",
                        imageName: "frozen",
                        category: "Games",
                        price: 2.99
                    ),
                    AppModel(
                        id: 0,
                        name: "Dirac",
                        imageName: "frozen",
                        category: "Games",
                        price: 3.99
                    ),
                    AppModel(
                        id: 0,
                        name: "Clash Royale",
                        imageName: "frozen",
                        category: "Games",
                        price: 0
                    )
                ]
            )
            
            return bestApps
        }()
    ]
}

final actor AppCategoriesProviderImplementation: AppCategoriesProvider {
    private let source: AppCategoriesProviderSource
    private let networkService = AppCategoriesNetworkService()
    
    init(source: AppCategoriesProviderSource = .server) {
        self.source = source
    }
    
    func fetchAppCategories() async throws -> [AppCategory] {
        switch source {
        case .local:
            guard !AppCategory.mock.isEmpty else {
                throw AppCategoriesProviderError.emptyList
            }
            return AppCategory.mock
            
        case .server:
            let result = try await networkService.fetchAppCategories()
            return result
        }
    }
}
