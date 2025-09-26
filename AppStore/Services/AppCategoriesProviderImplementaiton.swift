import Foundation

final actor AppCategoriesProviderImplementation: AppCategoriesProvider {
    private let source: AppCategoriesProviderSource
    private let networkService = AppCategoriesNetworkService()
    
    init(source: AppCategoriesProviderSource = .local) {
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
