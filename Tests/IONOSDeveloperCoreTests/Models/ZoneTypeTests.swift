@testable import IONOSDeveloperCore
import XCTest

final class ZoneTypeTests: XCTestCase {

    func testNativeRawTypeReturnsNative() {
        let expectedResult = "NATIVE"

        let result = ZoneType.native.rawValue

        XCTAssertEqual(result, expectedResult)
    }

    func testSlaveRawTypeReturnsSlave() {
        let expectedResult = "SLAVE"

        let result = ZoneType.slave.rawValue

        XCTAssertEqual(result, expectedResult)
    }

}
