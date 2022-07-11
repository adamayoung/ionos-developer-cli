import ArgumentParser
import Foundation
import IONOSDeveloperCLIUtils

struct GlobalOptions: ParsableArguments {

    @Option(
        name: [.customShort("k"), .customLong("apikey")],
        help: "IONOS Developer API Key. Use IONOS_API_KEY environment variable or ionos auth command to set key"
    )
    var apiKey: String = Environment.apiKey ?? APIKeyStore.getAPIKey() ?? ""

}
