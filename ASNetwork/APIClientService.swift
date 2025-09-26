//
//  APIClientService.swift
//  AppStore
//
//  Created by Azizbek Asadov on 26.09.2025.
//

import Foundation

public enum APIClientServiceError: Error {
    case invalidURL
    case invalidHTTPResponse
    case requestFailure
    case httpStatus(Int, Data?)
    case decoding(Error)
}

public final actor APIClientService: NetworkService {
    public typealias T = Decodable
    
    private let session: URLSession
    private let decoder: JSONDecoder
    
    public init(
        session: URLSession = .shared,
        decoder: JSONDecoder = JSONDecoder()
    ) {
        self.session = session
        self.decoder = decoder
        self.decoder.keyDecodingStrategy = .convertFromSnakeCase
    }
    
    @discardableResult
    public func fetchData<T: Decodable>(
        from urlString: String,
        pathComponent: String? = nil,
        httpMethod: HttpMethod,
        headers: [String: String] = [:],
        body: Data? = nil,
        timeout: TimeInterval = 30
    ) async throws -> T {
        guard var url = URL(string: urlString) else {
            throw APIClientServiceError.invalidURL
        }

        if let pc = pathComponent, !pc.isEmpty {
            url.appendPathComponent(pc, isDirectory: false)
        }

        var request = URLRequest(
            url: url,
            cachePolicy: .useProtocolCachePolicy,
            timeoutInterval: timeout
        )
        request.httpMethod = httpMethod.rawValue
        request.httpBody = body

        var mergedHeaders = headers
        
        if body != nil && mergedHeaders["Content-Type"] == nil {
            mergedHeaders["Content-Type"] = "application/json"
        }
        
        mergedHeaders.forEach { request.setValue($1, forHTTPHeaderField: $0) }

        let (data, response) = try await session.data(for: request)

        guard let http = response as? HTTPURLResponse else {
            throw APIClientServiceError.invalidHTTPResponse
        }

        guard (200...299).contains(http.statusCode) else {
            throw APIClientServiceError.httpStatus(http.statusCode, data.isEmpty ? nil : data)
        }

        if data.isEmpty, T.self == EmptyResponse.self {
            return EmptyResponse() as! T
        }

        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            throw APIClientServiceError.decoding(error)
        }
    }
}

