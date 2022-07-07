import Foundation

public protocol ZoneDNSService {

    func zones() async throws -> [Zone]

}
