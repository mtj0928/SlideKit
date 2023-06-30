// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription
import CompilerPluginSupport

let package = Package(
    name: "SlideKit",
    platforms: [.iOS(.v15), .macOS(.v12)],
    products: [
        .library(name: "SlideKit", targets: ["SlideKit"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-docc-plugin", from: "1.0.0"),
        .package(url: "https://github.com/JohnSundell/Splash", from: "0.1.0"),
        .package(url: "https://github.com/apple/swift-syntax.git", from: "509.0.0-swift-5.9-DEVELOPMENT-SNAPSHOT-2023-04-25-b"),
    ],
    targets: [
        .target(
            name: "SlideKit",
            dependencies: [
                "SlideKitMacros",
                "Splash"
            ]
        ),
        .macro(
            name: "SlideKitMacros",
            dependencies: [
                .product(name: "SwiftSyntaxMacros", package: "swift-syntax"),
                .product(name: "SwiftCompilerPlugin", package: "swift-syntax")
            ]
        ),
        .testTarget(name: "SlideKitTests", dependencies: ["SlideKit"]),
    ]
)
