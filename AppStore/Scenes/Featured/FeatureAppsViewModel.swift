import Foundation

final class FeatureAppsViewModel {
    private(set) var appCategories: [AppCategory] = []
    
    private let appCategoriesProvider: AppCategoriesProvider
    
    init(_ provider: some AppCategoriesProvider) {
        self.appCategoriesProvider = provider
    }
    
    func fetchCategories() async -> Result<[AppCategory], Error> {
        do {
            self.appCategories = try await appCategoriesProvider.fetchAppCategories()
            return .success(self.appCategories)
        } catch {
            return .failure(error)
        }
    }
}
