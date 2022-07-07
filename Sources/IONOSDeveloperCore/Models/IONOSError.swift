import Foundation

/// An IONOS error.
public enum IONOSError: Error {

    /// Network error.
    case network(Error)
    /// Unauthorised.
    case unauthorized
    /// Not found.
    case notFound
    /// Internal server error.
    case internalServerError
    /// Data decode error.
    case decode(Error)
    /// Unknown error.
    case unknown

}

extension IONOSError: LocalizedError {

    public var errorDescription: String? {
        switch self {
        case .network(let error):
            return error.localizedDescription

        case .unauthorized:
            return "Unauthorised"

        case .notFound:
            return "Not Found"

        case .internalServerError:
            return "Internal Server Error"

        case .decode:
            return "Data Decode Error"

        case .unknown:
            return "Unknown Error"
        }
    }

}
