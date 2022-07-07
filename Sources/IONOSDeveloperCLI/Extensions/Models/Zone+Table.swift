import Foundation
import IONOSDeveloperCore

extension Array: TextTableRepresentable where Element == Zone {

    var columns: [String] {
        ["id", "name", "type"]
    }

    var rows: [[CustomStringConvertible]] {
        self.map { zone in
            [zone.id.uuidString, zone.name, zone.type.rawValue]
        }
    }

}
