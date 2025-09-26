import Foundation

protocol AppCategoriesProvider {
    func fetchAppCategories() async throws -> [AppCategory]
}

enum AppCategoriesProviderError: Error {
    case emptyList
    // ...
}


