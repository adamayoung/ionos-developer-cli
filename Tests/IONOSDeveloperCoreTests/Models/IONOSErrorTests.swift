@testable import IONOSDeveloperCore
import XCTest

final class IONOSErrorTests: XCTestCase {

    func testNetworkReturnsErrorDescription() {
        let urlError = URLError(.badURL)
        let expectedResult = urlError.localizedDescription

        let result = IONOSError.network(urlError).localizedDescription

        XCTAssertEqual(result, expectedResult)
    }

    func testUnauthorizedReturnsErrorDescription() {
        XCTAssertEqual(IONOSError.unauthorized.localizedDescription, "Unauthorised")
    }

    func testNotFoundReturnsErrorDescription() {
        XCTAssertEqual(IONOSError.notFound.localizedDescription, "Not Found")
    }

    func testInternalServiceErrorReturnsErrorDescription() {
        XCTAssertEqual(IONOSError.internalServerError.localizedDescription, "Internal Server Error")
    }

    func testUnknownReturnsErrorDescription() {
        XCTAssertEqual(IONOSError.unknown.localizedDescription, "Unknown Error")
    }

    func testDecodeReturnsErrorDescription() {
        let error = URLError(.badURL)

        let result = IONOSError.decode(error).localizedDescription

        XCTAssertEqual(result, "Data Decode Error")
    }

}
