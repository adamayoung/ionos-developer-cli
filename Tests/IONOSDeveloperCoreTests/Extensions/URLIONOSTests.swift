@testable import IONOSDeveloperCore
import XCTest

final class URLIONOSTests: XCTestCase {

    func testIONOSAPIBaseURLReturnsCorrectURL() {
        let expectedResult = URL(string: "https://api.hosting.ionos.com")!

        let result = URL.ionosAPIBaseURL

        XCTAssertEqual(result, expectedResult)
    }

}
