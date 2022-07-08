import ArgumentParser
import Foundation
import IONOSDeveloperCLIUtils
import IONOSDeveloperCore

struct AuthCommand: AsyncParsableCommand {

    static var configuration = CommandConfiguration(
        commandName: "auth",
        abstract: "Sets your IONOS Developer API key."
    )

    @Argument(
        help: "IONOS Developer API key."
    )
    var apiKey: String

    func run() async throws {
        try APIKeyStore.set(apiKey: apiKey)
    }

}
