//
//  SlideGenerator.swift
//  
//
//  Created by Junnosuke Matsumoto on 2022/08/28.
//

import Foundation
import ArgumentParser

@main
struct SlideGenerator: ParsableCommand {
    @Argument var productName: String

    @Option(name: .shortAndLong, help: "A project platform")
    var platform: SupportedPlatform = .iOS

    mutating func run() throws {
        print(productName)
    }
}

enum SupportedPlatform: String, Codable, ExpressibleByArgument {
    case mac
    case iOS
}
