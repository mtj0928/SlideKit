// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SlideKit",
    platforms: [.iOS(.v15), .macOS(.v12)],
    products: [
        .library(name: "SlideKit", targets: ["SlideKit"]),
    ],
    dependencies: [],
    targets: [
        .target(name: "SlideKit", dependencies: []),
        .testTarget(name: "SlideKitTests", dependencies: ["SlideKit"]),
    ]
)
