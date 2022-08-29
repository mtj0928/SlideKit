// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SlideKit",
    platforms: [.iOS(.v15), .macOS(.v12)],
    products: [
        .executable(name: "slidekit-generator", targets: ["SlideKitCLI"]),
        .library(name: "SlideKit", targets: ["SlideKit"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser", from: "1.1.4"),
    ],
    targets: [
        .executableTarget(name: "SlideKitCLI", dependencies: [
            "SlideKit",
            .product(name: "ArgumentParser", package: "swift-argument-parser")
        ]),
        .target(name: "SlideKit", dependencies: []),
        .testTarget(name: "SlideKitTests", dependencies: ["SlideKit"]),
    ]
)
