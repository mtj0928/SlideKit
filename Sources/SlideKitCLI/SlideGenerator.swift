//
//  SlideGenerator.swift
//  
//
//  Created by Junnosuke Matsumoto on 2022/08/28.
//

import ArgumentParser
import Foundation
import Stencil

@main
struct SlideGenerator: ParsableCommand {
    @Argument var productName: String

    @Option(name: .shortAndLong, help: "A project platform")
    var platform: SupportedPlatform = .iOS

    mutating func run() throws {
        guard !FileManager.default.fileExists(atPath: productName) else {
            print("file exist")
            return
        }
        try FileManager.default.createDirectory(atPath: productName + "/" + productName, withIntermediateDirectories: true)
        try copySwiftFiles()
    }

    private func copySwiftFiles() throws {
        try copySwiftFile(templateName: "AppDelegate")
        try copySwiftFile(templateName: "SceneDelegate")
        try copySwiftFile(templateName: "App", fileName: productName + "_App")
        try copySwiftFile(templateName: "SampleSlide")
    }

    private func copySwiftFile(templateName: String, fileName: String? = nil) throws {
        let fileSystemLoader = FileSystemLoader(bundle: [Bundle.main, Bundle.module])
        let environment = Environment(loader: fileSystemLoader)

        let context = ["productName": productName]
        let content = try environment.renderTemplate(name: templateName + ".stencil", context: context)
        let url = URL(fileURLWithPath: "./\(productName)/\(productName)/\(fileName ?? templateName).swift")
        print("write to \(url.absoluteString)")
        try content.write(to: url, atomically: true, encoding: .utf8)
    }
}

enum SupportedPlatform: String, Codable, ExpressibleByArgument {
    case mac
    case iOS
}
