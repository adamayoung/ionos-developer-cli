import Foundation

/// A DNS zone.
public struct Zone: Identifiable, Equatable, Hashable, Decodable {

    /// The zone identifier.
    public let id: UUID
    /// The zone name.
    public let name: String
    /// The zone type.
    public let type: ZoneType

    /// Creates a new `Zone`.
    ///
    /// - Parameters:
    ///    - id: The zone identifier
    ///    - name: The zone name.
    ///    - type: The zone type.
    ///
    public init(id: UUID, name: String, type: ZoneType) {
        self.id = id
        self.name = name
        self.type = type
    }

}
