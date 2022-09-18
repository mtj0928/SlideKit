// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SlideKit",
    platforms: [.iOS(.v15), .macOS(.v12)],
    products: [
        .library(name: "SlideKit", targets: ["SlideKit"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-docc-plugin", from: "1.0.0"),
        .package(url: "https://github.com/JohnSundell/Splash", from: "0.1.0"),
    ],
    targets: [
        .target(name: "SlideKit", dependencies: ["Splash"]),
        .testTarget(name: "SlideKitTests", dependencies: ["SlideKit"]),
    ]
)
