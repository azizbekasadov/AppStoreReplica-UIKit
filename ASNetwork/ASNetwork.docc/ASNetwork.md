# ``ASNetwork``

- contains tools for working with Client API.

# APIClientService

`APIClientService` is a lightweight, asynchronous network client built on top of Swift’s modern **actors** and **async/await**.  
It provides a generic and type-safe way to fetch and decode JSON data from HTTP endpoints, with built-in error handling.

---

## Features

- ✅ Actor-based: safe for concurrent use.  
- ✅ Generic decoding into any `Decodable` type.  
- ✅ Automatic snake_case → camelCase key decoding.  
- ✅ Built-in error handling for HTTP, decoding, and request issues.  
- ✅ Flexible configuration for HTTP method, headers, body, and timeout.  
- ✅ Handles empty responses gracefully with `EmptyResponse`.

---

## APIClientServiceError

Custom error enum representing possible failures:

```swift
public enum APIClientServiceError: Error {
    case invalidURL
    case invalidHTTPResponse
    case requestFailure
    case httpStatus(Int, Data?)
    case decoding(Error)
}
