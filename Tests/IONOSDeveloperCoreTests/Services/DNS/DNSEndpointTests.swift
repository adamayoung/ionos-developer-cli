@testable import IONOSDeveloperCore
import XCTest

final class DNSEndpointTests: XCTestCase {

    func testZonesEndpointReturnsURL() {
        let expectedPath = URL(string: "/dns/v1/zones")!

        let path = DNSEndpoint.zones.path

        XCTAssertEqual(path, expectedPath)
    }

}
