@testable import IONOSDeveloperCore
import XCTest

final class DNSIONOSServiceTests: XCTestCase {

    var service: DNSIONOSService!
    var client: MockAPIClient!

    override func setUp() {
        super.setUp()
        client = MockAPIClient()
        service = DNSIONOSService(client: client)
    }

    override func tearDown() {
        service = nil
        client = nil
        super.tearDown()
    }

    func testZones() async throws {
        let expectedResult = Zone.mocks
        client.result = .success(expectedResult)

        let result = try await service.zones()

        XCTAssertEqual(result, expectedResult)
    }

}
