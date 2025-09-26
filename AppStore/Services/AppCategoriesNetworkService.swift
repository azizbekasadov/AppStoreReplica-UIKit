//
//  AppCategoriesNetworkService.swift
//  AppStore
//
//  Created by Azizbek Asadov on 26.09.2025.
//

import Foundation
import ASNetwork

final actor AppCategoriesNetworkService {
    private let apiClientService: APIClientService
    
    init(apiClientService: APIClientService = .init()) {
        self.apiClientService = apiClientService
    }
    
    func fetchAppCategories() async throws -> [AppCategory] {
        let categories: [AppCategory] = try await apiClientService.fetchData(
            from: "http://www.statsallday.com/appstore",
            pathComponent: "featured",
            httpMethod: .get
        )
        
        return categories
    }
}
