import Foundation

struct AppCategory: Equatable, Codable {
    let name: String?
    let app: [AppModel]
    
    static func == (lhs: AppCategory, rhs: AppCategory) -> Bool {
        lhs.name == rhs.name
    }
}
