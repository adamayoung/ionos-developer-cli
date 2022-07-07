import Foundation

final class DNSIONOSService: DNSService {

    private let client: APIClient

    init(client: APIClient) {
        self.client = client
    }

}

extension DNSIONOSService {

    func zones() async throws -> [Zone] {
        try await client.get(endpoint: DNSEndpoint.zones)
    }

}
