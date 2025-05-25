// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription
import CompilerPluginSupport

let package = Package(
    name: "SlideKit",
    platforms: [.iOS(.v17), .macOS(.v14), .visionOS(.v1), .tvOS(.v17)],
    products: [
        .library(name: "SlideKit", targets: ["SlideKit"]),
    ],
    dependencies: [
        .package(url: "https://github.com/swiftlang/swift-docc-plugin", from: "1.0.0"),
        .package(url: "https://github.com/swiftlang/swift-syntax", from: "601.0.0"),
        .package(url: "https://github.com/mtj0928/SyntaxInk", from: "0.0.2"),
    ],
    targets: [
        .target(
            name: "SlideKit",
            dependencies: [
                "SlideKitMacros",
                .product(name: "SwiftSyntaxInk", package: "SyntaxInk"),
                .product(name: "SyntaxInk", package: "SyntaxInk")
            ]
        ),
        .macro(
            name: "SlideKitMacros",
            dependencies: [
                .product(name: "SwiftSyntaxMacros", package: "swift-syntax"),
                .product(name: "SwiftCompilerPlugin", package: "swift-syntax")
            ]
        ),
        .testTarget(
            name: "SlideKitTests",
            dependencies: [
                "SlideKit",
                .product(name: "SwiftSyntaxMacrosTestSupport", package: "swift-syntax")
            ]
        )
    ]
)
