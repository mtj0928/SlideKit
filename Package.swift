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
        // Waiting for officially release of SwiftLint
        .package(url: "https://github.com/realm/SwiftLint", revision: "5c3d4c1dab5cf94cc57e539955e472d23adb7fb7")
    ],
    targets: [
        .target(
            name: "SlideKit",
            dependencies: ["Splash"],
            plugins: [.plugin(name: "SwiftLintPlugin", package: "SwiftLint")]
        ),
        .testTarget(name: "SlideKitTests", dependencies: ["SlideKit"]),
    ]
)
