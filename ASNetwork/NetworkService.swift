//
//  NetworkService.swift
//  AppStore
//
//  Created by Azizbek Asadov on 26.09.2025.
//

import Foundation

public protocol NetworkService {
    associatedtype T
    
    @discardableResult
    func fetchData<T: Decodable>(
        from urlString: String,
        pathComponent: String?,
        httpMethod: HttpMethod,
        headers: [String: String],
        body: Data?,
        timeout: TimeInterval
    ) async throws -> T
}
