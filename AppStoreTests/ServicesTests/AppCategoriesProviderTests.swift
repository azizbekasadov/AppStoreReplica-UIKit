//
//  AppCategoriesProviderTests.swift
//  AppStoreTests
//
//  Created by Azizbek Asadov on 26.09.2025.
//

import XCTest

@_exported @testable import AppStore

final class AppCategoriesProviderTests: XCTestCase {
    var sut: AppCategoriesProvider!
    
    override func setUp() async throws {
        try await super.setUp()
        
        sut = AppCategoriesProviderImplementation()
    }
    
    override func tearDown() async throws {
        sut = nil
        
        try await super.tearDown()
    }
    
    func testFetchAppCategories() async throws {
        // given
        if sut == nil {
            sut = AppCategoriesProviderImplementation()
        }
        
        let categories = try await sut.fetchAppCategories()
        
        XCTAssertNotEqual(categories.count, 0)
    }
}

