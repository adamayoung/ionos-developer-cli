import Foundation

final actor IONOSAPIClient: APIClient {

    private let apiKey: String
    private let baseURL: URL
    private let urlSession: URLSession
    private let serialiser: Serialiser

    init(apiKey: String, baseURL: URL, urlSession: URLSession, serialiser: Serialiser) {
        self.apiKey = apiKey
        self.baseURL = baseURL
        self.urlSession = urlSession
        self.serialiser = serialiser
    }

    func get<Response: Decodable>(path: URL) async throws -> Response {
        let urlRequest = buildURLRequest(for: path)

        let data: Data
        let response: URLResponse

        do {
            (data, response) = try await urlSession.data(for: urlRequest)
        } catch {
            throw IONOSError.network(error)
        }

        try validate(response: response)
        return try await serialiser.decode(data)
    }

}

extension IONOSAPIClient {

    private func buildURLRequest(for path: URL) -> URLRequest {
        let url = urlFromPath(path)
        var urlRequest = URLRequest(url: url)
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        urlRequest.addValue(apiKey, forHTTPHeaderField: "X-API-Key")
        return urlRequest
    }

    private func urlFromPath(_ path: URL) -> URL {
        guard var urlComponents = URLComponents(url: path, resolvingAgainstBaseURL: true) else {
            return path
        }

        urlComponents.scheme = baseURL.scheme
        urlComponents.host = baseURL.host
        urlComponents.path = "\(baseURL.path)\(urlComponents.path)"

        return urlComponents.url!
    }

    private func validate(response: URLResponse) throws {
        if let ionosError = IONOSError(response: response) {
            throw ionosError
        }
    }

}

private extension IONOSError {

    init?(response: URLResponse) {
        let statusCode = (response as? HTTPURLResponse)?.statusCode ?? -1
        guard statusCode != 200 else {
            return nil
        }

        switch statusCode {
        case 401:
            self = .unauthorized

        case 404:
            self = .notFound

        case 500:
            self = .internalServerError

        default:
            self = .unknown
        }
    }

}
