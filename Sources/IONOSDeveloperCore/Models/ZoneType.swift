import Foundation

/// Represents the possible zone types.
public enum ZoneType: String, Decodable, CaseIterable {

    /// Native.
    case native = "NATIVE"
    /// Slave.
    case slave = "SLAVE"

}
