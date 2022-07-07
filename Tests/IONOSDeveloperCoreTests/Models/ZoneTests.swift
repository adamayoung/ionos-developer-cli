@testable import IONOSDeveloperCore
import XCTest

final class ZoneTests: XCTestCase {

    func testDecodeReturnsZone() throws {
        let expectedResult = Zone(
            id: UUID(uuidString: "11af3414-ebba-11e9-8df5-66fbe8a334b4")!,
            name: "test.com",
            type: .native
        )

        let result = try JSONDecoder.ionos.decode(Zone.self, fromResource: "zone")

        XCTAssertEqual(result.id, expectedResult.id)
        XCTAssertEqual(result.name, expectedResult.name)
        XCTAssertEqual(result.type, expectedResult.type)
    }

}
