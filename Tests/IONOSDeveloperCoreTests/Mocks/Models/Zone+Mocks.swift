@testable import IONOSDeveloperCore
import XCTest

extension Zone {

    static var mock: Self {
        .init(id: .init(), name: "adam-young.co.uk", type: .native)
    }

    static var mocks: [Self] {
        [
            .init(id: .init(), name: "adam-young.co.uk", type: .native),
            .init(id: .init(), name: "swithwithadam.com", type: .slave)
        ]
    }

}
