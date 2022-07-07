import ArgumentParser
import Foundation
import IONOSDeveloperCore
import Table

struct DNSZonesListCommand: AsyncParsableCommand {

    static var configuration = CommandConfiguration(
        commandName: "list",
        abstract: "List all DNS Zones."
    )

    @OptionGroup
    var global: GlobalOptions

    func validate() throws {
        guard !global.apiKey.isEmpty else {
            throw ValidationError("Missing API Key.")
        }
    }

    func run() async throws {
        let ionos = IONOS(apiKey: global.apiKey)
        let zones = try await ionos.dns.zones()

        print(zones.renderTable())
    }

}
