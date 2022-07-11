// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ionos-developer-cli",

    platforms: [
        .macOS(.v12), .iOS(.v15), .tvOS(.v15), .watchOS(.v8)
    ],

    products: [
        .executable(
            name: "ionos",
            targets: ["IONOSDeveloperCLI"]
        ),
        .library(
            name: "IONOSDeveloperCore",
            targets: ["IONOSDeveloperCore"]
        )
    ],

    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser.git", from: "1.1.3")
    ],

    targets: [
        .executableTarget(
            name: "IONOSDeveloperCLI",
            dependencies: [
                "IONOSDeveloperCLIUtils",
                "IONOSDeveloperCore",
                .product(name: "ArgumentParser", package: "swift-argument-parser")
            ]
        ),

        .target(
            name: "IONOSDeveloperCore",
            dependencies: []
        ),
        .testTarget(
            name: "IONOSDeveloperCoreTests",
            dependencies: ["IONOSDeveloperCore"],
            resources: [
                .process("Resources")
            ]
        ),

        .target(
            name: "IONOSDeveloperCLIUtils",
            dependencies: [
                "IONOSDeveloperCore"
            ]
        )
    ]
)
