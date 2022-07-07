@testable import IONOSDeveloperCore
import XCTest

final class IONOSAPIClientTests: XCTestCase {

    var apiClient: IONOSAPIClient!
    var apiKey: String!
    var baseURL: URL!
    var urlSession: URLSession!
    var serialiser: Serialiser!

    override func setUp() {
        super.setUp()
        apiKey = "abc123"
        baseURL = URL(string: "https://some.domain.com/path")

        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [MockURLProtocol.self]
        urlSession = URLSession(configuration: configuration)
        serialiser = Serialiser(decoder: JSONDecoder())
        apiClient = IONOSAPIClient(apiKey: apiKey, baseURL: baseURL, urlSession: urlSession, serialiser: serialiser)
    }

    override func tearDown() {
        apiClient = nil
        serialiser = nil
        baseURL = nil
        apiKey = nil
        MockURLProtocol.reset()
        super.tearDown()
    }

    func testGetWhenRequestFailsThrowsNetworkError() async throws {
        let expectedError = NSError(domain: NSURLErrorDomain, code: URLError.badServerResponse.rawValue)
        MockURLProtocol.failError = expectedError

        do {
           _ = try await apiClient.get(path: URL(string: "/error")!) as String
        } catch let error as IONOSError {
            switch error {
            case .network(let error as NSError):
                XCTAssertEqual(error.code, expectedError.code)
                return
            default:
                break
            }
        }

        XCTFail("Expected error to be thrown")
    }

    func testGetWhenResponseStatusCodeIs401ReturnsUnauthorisedError() async throws {
        MockURLProtocol.responseStatusCode = 401

        do {
           _ = try await apiClient.get(path: URL(string: "/error")!) as String
        } catch let error as IONOSError {
            switch error {
            case .unauthorized:
                XCTAssertTrue(true)
                return
            default:
                break
            }
        }

        XCTFail("Expected unauthorised error to be thrown")
    }

    func testGetWhenResponseStatusCodeIs404ReturnsNotFoundError() async throws {
        MockURLProtocol.responseStatusCode = 404

        do {
           _ = try await apiClient.get(path: URL(string: "/error")!) as String
        } catch let error as IONOSError {
            switch error {
            case .notFound:
                XCTAssertTrue(true)
                return
            default:
                break
            }
        }

        XCTFail("Expected not found error to be thrown")
    }

    func testGetWhenResponseStatusCodeIs500ReturnsInternalServiceError() async throws {
        MockURLProtocol.responseStatusCode = 500

        do {
           _ = try await apiClient.get(path: URL(string: "/error")!) as String
        } catch let error as IONOSError {
            switch error {
            case .internalServerError:
                XCTAssertTrue(true)
                return
            default:
                break
            }
        }

        XCTFail("Expected internal server error to be thrown")
    }

    func testGetWhenResponseStatusCodeIs999ReturnsUnknownError() async throws {
        MockURLProtocol.responseStatusCode = 999

        do {
           _ = try await apiClient.get(path: URL(string: "/error")!) as String
        } catch let error as IONOSError {
            switch error {
            case .unknown:
                XCTAssertTrue(true)
                return
            default:
                break
            }
        }

        XCTFail("Expected unknown error to be thrown")
    }

    func testGetWhenResponseHasValidDataReturnsDecodedObject() async throws {
        let expectedResult = MockObject()
        MockURLProtocol.data = expectedResult.data

        let result: MockObject = try await apiClient.get(path: URL(string: "/object")!)

        XCTAssertEqual(result, expectedResult)
    }

    func testGetURLRequestAcceptHeaderSetToApplicationJSON() async throws {
        let expectedResult = "application/json"

        _ = try? await apiClient.get(path: URL(string: "/object")!) as String

        let result = MockURLProtocol.lastRequest?.value(forHTTPHeaderField: "Accept")

        XCTAssertEqual(result, expectedResult)
    }

    func testGetURLRequestHasCorrectURL() async throws {
        let path = "/object"
        let urlString = "\(baseURL.absoluteURL)\(path)"
        let expectedResult = URL(string: urlString)

        _ = try? await apiClient.get(path: URL(string: path)!) as String

        let result = MockURLProtocol.lastRequest?.url

        XCTAssertEqual(result, expectedResult)
    }

    func testGetAddsXAPIKeyHeader() async throws {
        let path = "/object"
        let expectedResult = apiKey

        _ = try? await apiClient.get(path: URL(string: path)!) as String

        let result = MockURLProtocol.lastRequest?.allHTTPHeaderFields?["X-API-Key"]

        XCTAssertEqual(result, expectedResult)
    }

}

extension IONOSAPIClientTests {

    private struct MockObject: Codable, Equatable {

        let id: UUID

        var data: Data {
            // swiftlint:disable force_try
            try! JSONEncoder().encode(self)
            // swiftlint:enable force_try
        }

        init(id: UUID = .init()) {
            self.id = id
        }
    }

}
