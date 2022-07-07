import ArgumentParser
import Foundation

struct DNSCommand: AsyncParsableCommand {

    static var configuration = CommandConfiguration(
        commandName: "dns",
        abstract: "Interact with DNS settings.",
        subcommands: [
            DNSZonesCommand.self
        ]
    )

}
