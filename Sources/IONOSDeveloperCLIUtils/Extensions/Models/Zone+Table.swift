import Foundation
import IONOSDeveloperCore

extension Array: TextTableRepresentable where Element == Zone {

    public var columns: [String] {
        ["id", "name", "type"]
    }

    public var rows: [[CustomStringConvertible]] {
        self.map { zone in
            [zone.id.uuidString, zone.name, zone.type.rawValue]
        }
    }

}
