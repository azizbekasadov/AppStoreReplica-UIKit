//
//  ASNetworkTests.swift
//  ASNetworkTests
//
//  Created by Azizbek Asadov on 26.09.2025.
//

import XCTest

@testable import ASNetwork

final class APIClientServiceTests: XCTestCase {
    
    // MARK: - Setup
    
    private func makeService() -> APIClientService {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        
        let session = URLSession(configuration: config)
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        return APIClientService(session: session, decoder: decoder)
    }

    private func respond(
        statusCode: Int,
        jsonObject: Any? = nil,
        data: Data? = nil,
        headers: [String: String]? = ["Content-Type": "application/json"]
    ) {
        MockURLProtocol.requestHandler = { request in
            let url = try XCTUnwrap(request.url)
            let http = HTTPURLResponse(url: url, statusCode: statusCode, httpVersion: nil, headerFields: headers)!
            if let data = data {
                return (http, data)
            } else if let obj = jsonObject {
                let raw = try JSONSerialization.data(withJSONObject: obj, options: [])
                return (http, raw)
            } else {
                return (http, Data())
            }
        }
    }

    // MARK: - Tests
    
    func test_appendsPathComponent_and_decodes() async throws {
        let sut = makeService()
        let base = "https://google.com/api"
        let path = "apps"

        MockURLProtocol.requestHandler = { request in
            let url = try XCTUnwrap(request.url)
            XCTAssertEqual(url.absoluteString, "\(base)/\(path)")
            
            let http = HTTPURLResponse(
                url: url,
                statusCode: 200,
                httpVersion: nil,
                headerFields: ["Content-Type":"application/json"]
            )!
            
            let json = ["id": 1, "name": "Test App"]
            let data = try JSONSerialization.data(withJSONObject: json)
            return (http, data)
        }

        let dto: DummyDTO = try await sut.fetchData(
            from: base,
            pathComponent: path,
            httpMethod: .get
        )

        XCTAssertEqual(dto, DummyDTO(id: 1, name: "Test App"))
    }

    func test_nonHTTPResponse_throwsInvalidHTTPResponse() async {
        let sut = makeService()
        
        MockURLProtocol.requestHandler = { request in
            let url = try XCTUnwrap(request.url)
            let response = URLResponse(
                url: url,
                mimeType: nil,
                expectedContentLength: 0,
                textEncodingName: nil
            )
            
            return (response, Data())
        }

        do {
            let _: DummyDTO = try await sut.fetchData(
                from: "https://google.com",
                httpMethod: .get
            )
            XCTFail("Expected to throw")
        } catch let error as APIClientServiceError {
            switch error {
            case .invalidHTTPResponse:
                break
            default:
                XCTFail("Expected .invalidHTTPResponse, got \(error)")
            }
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }

    func test_httpStatusError_includesStatusAndData() async {
        let sut = makeService()
        let message = "Not Found"
        respond(
            statusCode: 404,
            data: message.data(using: .utf8),
            headers: ["Content-Type":"text/plain"]
        )

        do {
            let _: DummyDTO = try await sut.fetchData(
                from: "https://google.com/missing",
                httpMethod: .get
            )
            XCTFail("Expected to throw")
        } catch let error as APIClientServiceError {
            switch error {
            case .httpStatus(let code, let data):
                XCTAssertEqual(code, 404)
                XCTAssertEqual(
                    String(
                        data: data ?? Data(),
                        encoding: .utf8
                    ),
                    message
                )
            default:
                XCTFail("Expected .httpStatus, got \(error)")
            }
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }

    func test_decodingSuccess_returnsDecodedModel() async throws {
        let sut = makeService()
        respond(
            statusCode: 200,
            jsonObject: ["id": 42, "name": "Decoded"]
        )

        let dto: DummyDTO = try await sut.fetchData(
            from: "https://google.com/ok",
            httpMethod: .get
        )

        XCTAssertEqual(dto, DummyDTO(id: 42, name: "Decoded"))
    }

    func test_decodingFailure_wrappedInDecodingError() async {
        let sut = makeService()
        
        respond(statusCode: 200, jsonObject: ["unexpected": "shape"])

        do {
            let _: DummyDTO = try await sut.fetchData(
                from: "https://google.com/bad-json",
                httpMethod: .get
            )
            XCTFail("Expected to throw")
        } catch let error as APIClientServiceError {
            switch error {
            case .decoding(let underlying):
                XCTAssertTrue(underlying is DecodingError)
            default:
                XCTFail("Expected .decoding, got \(error)")
            }
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
    }

    func test_emptyBodyForEmptyResponseType_returnsEmptyResponse() async throws {
        let sut = makeService()
        
        respond(statusCode: 200, data: Data())

        let empty: EmptyResponse = try await sut.fetchData(
            from: "https://google.com/no-content",
            httpMethod: .get
        )
        
        _ = empty
    }
}
