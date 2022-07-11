import ArgumentParser
import Foundation

@main
struct IONOSDeveloperCLI: AsyncParsableCommand {

    static let configuration = CommandConfiguration(
        abstract: "A command-line tool for IONOS Developer APIs.",
        subcommands: [
            AuthCommand.self,
            DNSCommand.self
        ]
    )
}
