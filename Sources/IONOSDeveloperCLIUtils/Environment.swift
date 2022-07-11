import Foundation

public struct Environment {

    public static var apiKey: String? {
        guard let apiKey = ProcessInfo.processInfo.environment["IONOS_API_KEY"], !apiKey.isEmpty else {
            return nil
        }

        return apiKey
    }

}
