# IONOS Developer API and CLI

![CI](https://github.com/adamayoung/ionos-developer-cli/workflows/CI/badge.svg)

A Swift Package for IONOS Developer API <https://developer.hosting.ionos.com>, with CLI.

## Requirements

* Swift 5.6

## Installation

### [Swift Package Manager](https://github.com/apple/swift-package-manager)

Add the IONOSDeveloperCore package as a dependency to your `Package.swift` file, and add it as a dependency to your target.

```swift
// swift-tools-version:5.6

import PackageDescription

let package = Package(
  name: "MyPackage",
  dependencies: [
    .package(url: "https://github.com/adamayoung/ionos-developer-cli.git", branch: "main")
  ],
  targets: [
    .target(name: "MyPackage", dependencies: ["IONOSDeveloperCore"])
  ]
)
```

### CLI

```bash
git clone https://github.com/adamayoung/ionos-developer-cli.git
cd ionos-developer-cli
swift run ionos <command>
```

## Setup

### Get an API Key

Create an API key from The IONOS Developer API web site [https://developer.hosting.ionos.com/keys](https://developer.hosting.ionos.com/keys).

### Set API key with a command

Use this method to store you API key so other commands can be used without specifying it.

```bash
swift run ionos auth <api-key>
```

### Set API key with Environment variable

```
export IONOS_API_KEY=<api-key>
```

## API Areas

For a full set of commands,

```bash
swift run ionos --help
```

### DNS

* Zones
  * List

## References

* [https://developer.hosting.ionos.com](https://developer.hosting.ionos.com)

## License

This library is licensed under the Apache License 2.0. See [LICENSE](https://github.com/adamayoung/ionos-developer-cli/blob/main/LICENSE) for details.
