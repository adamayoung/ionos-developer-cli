import ArgumentParser
import Foundation

struct GlobalOptions: ParsableArguments {

    @Option(
        name: [.customShort("k"), .customLong("apikey")],
        help: "IONOS Developer API Key."
    )
    var apiKey: String

}
