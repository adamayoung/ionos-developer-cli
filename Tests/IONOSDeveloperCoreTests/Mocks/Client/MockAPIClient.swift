@testable import IONOSDeveloperCore
import XCTest

final class MockAPIClient: APIClient {

    static var apiKey: String?

    var result: Result<Any, IONOSError>?
    var requestTime: TimeInterval = 0
    private(set) var lastPath: URL?
    private(set) var getCount = 0

    static func setAPIKey(_ apiKey: String) {
        Self.apiKey = apiKey
    }

    func get<Response: Decodable>(path: URL) async throws -> Response {
        self.lastPath = path
        self.getCount += 1

        Thread.sleep(forTimeInterval: requestTime)

        guard let result = result else {
            throw IONOSError.unknown
        }

        do {
            guard let value = try result.get() as? Response else {
                XCTFail("Can't cast response to type \(String(describing: Response.self))")
                throw IONOSError.unknown
            }

            return value
        } catch let error as IONOSError {
            throw error
        } catch {
            throw IONOSError.unknown
        }
    }

    func reset() {
        result = nil
        lastPath = nil
        getCount = 0
    }

}
