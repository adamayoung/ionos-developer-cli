import Foundation

public struct IONOS {

    public let dns: DNSService

    public init(apiKey: String) {
        let client = IONOSAPIClient(apiKey: apiKey, baseURL: .ionosAPIBaseURL, urlSession: .shared,
                                    serialiser: Serialiser(decoder: .ionos))

        self.init(dnsService: DNSIONOSService(client: client))
    }

    init(dnsService: DNSService) {
        self.dns = dnsService
    }

}
