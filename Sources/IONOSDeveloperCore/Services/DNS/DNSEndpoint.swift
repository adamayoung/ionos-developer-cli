import Foundation

enum DNSEndpoint {

    case zones

}

extension DNSEndpoint: Endpoint {

    private static let basePath = URL(string: "/dns/v1")!

    var path: URL {
        switch self {
        case .zones:
            return Self.basePath
                .appendingPathComponent("zones")
        }
    }

}
