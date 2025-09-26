import Foundation

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
        }(),
        {
            let bestApps = AppCategory(
                name: "Top in Switzerland",
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
                        name: "Lorem Ipsum Lorem Ipsum Lorem Ipsum",
                        imageName: "frozen",
                        category: "Games",
                        price: 0
                    )
                ]
            )
            
            return bestApps
        }(),
    ]
}
