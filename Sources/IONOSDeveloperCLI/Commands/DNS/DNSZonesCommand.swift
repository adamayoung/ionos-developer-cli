import ArgumentParser
import Foundation

struct DNSZonesCommand: AsyncParsableCommand {

    static var configuration = CommandConfiguration(
        commandName: "zones",
        abstract: "Interact with DNS Zones settings.",
        subcommands: [
            DNSZonesListCommand.self
        ],
        defaultSubcommand: DNSZonesListCommand.self
    )

}
