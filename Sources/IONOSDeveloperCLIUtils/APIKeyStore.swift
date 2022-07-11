import Foundation

@available(macOS 12.0, *)
public struct APIKeyStore {

    public static func set(apiKey: String) throws {
        try createIONOSSettingsDirectory()
        try apiKey.write(toFile: apiKeyFilePath, atomically: true, encoding: .utf8)
    }

    public static func getAPIKey() -> String? {
        guard fileManager.isReadableFile(atPath: apiKeyFilePath) else {
            return nil
        }

        return try? String(contentsOfFile: apiKeyFilePath)
    }

}

extension APIKeyStore {

    private static let ionosSettingsDirectoryName = ".ionos"
    private static let ionosAPIKeyFileName = "key"

    private static var fileManager: FileManager {
        .default
    }

    private static var ionosSettingsDirectoryURL: URL {
        fileManager.homeDirectoryForCurrentUser.appendingPathComponent(ionosSettingsDirectoryName)
    }

    private static var ionosSettingsDirectoryPath: String {
        ionosSettingsDirectoryURL.path
    }

    private static var apiKeyFilePath: String {
        ionosSettingsDirectoryURL.appendingPathComponent(ionosAPIKeyFileName).path
    }

    private static func createIONOSSettingsDirectory() throws {
        guard !fileManager.fileExists(atPath: ionosSettingsDirectoryPath) else {
            return
        }

        try fileManager.createDirectory(atPath: ionosSettingsDirectoryPath, withIntermediateDirectories: true)
    }

}
