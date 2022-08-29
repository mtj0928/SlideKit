//
//  SlideGenerator.swift
//  
//
//  Created by Junnosuke Matsumoto on 2022/08/28.
//

import ArgumentParser
import Foundation
import Logging
import Stencil
import PathKit
import ProjectSpec
import Version
import XcodeGenKit

let logger = Logger(label: "net.matsuji.SlideKit")

@main
struct SlideGenerator: ParsableCommand {
    @Argument var productName: String

    @Option(name: .shortAndLong, help: "A project platform")
    var platform: SupportedPlatform = .iOS

    mutating func run() throws {
        guard platform == .iOS else {
            logger.error("macOS isn't supported now. It's a good chance to contribute SlideKit!")
            return
        }
        guard !FileManager.default.fileExists(atPath: productName) else {
            logger.error("\(productName) exist.")
            return
        }
        try FileManager.default.createDirectory(atPath: productName + "/" + productName, withIntermediateDirectories: true)
        try copySwiftFiles()
        try copyFile(templateName: "Info.plist")
        try copyFile(templateName: "project.yml", filePath: URL(fileURLWithPath: "./\(productName)/project.yml"))
        try makeXcodeProj()
        logger.info("Creating \(productName) has been succeeded.")
    }

    private func copySwiftFiles() throws {
        try copySwiftFile(templateName: "AppDelegate")
        try copySwiftFile(templateName: "SceneDelegate")
        try copySwiftFile(templateName: "App", fileName: productName + "_App")
        try copySwiftFile(templateName: "SampleSlide")
    }

    private func copySwiftFile(templateName: String, fileName: String? = nil) throws {
        try copyFile(
            templateName: templateName,
            filePath: URL(fileURLWithPath: "./\(productName)/\(productName)/\(fileName ?? templateName).swift")
        )
    }

    private func copyFile(templateName: String, filePath: URL? = nil) throws {
        let fileSystemLoader = FileSystemLoader(bundle: [Bundle.main, Bundle.module])
        let environment = Environment(loader: fileSystemLoader)

        let context = ["productName": productName]
        let content = try environment.renderTemplate(name: templateName + ".stencil", context: context)
        let url = filePath ?? URL(fileURLWithPath: "./\(productName)/\(productName)/\(templateName)")
        logger.debug("Writing to \(url.absoluteString)")
        try content.write(to: url, atomically: true, encoding: .utf8)
    }

    private func makeXcodeProj() throws {
        let xcodeGenVersion = Version("2.32.0")

        let specLoader = SpecLoader(version: xcodeGenVersion)
        let project = try specLoader.loadProject(path: Path("./\(productName)/project.yml"))
        try specLoader.validateProjectDictionaryWarnings()

        let projectPath = "./\(project.name)/\(productName).xcodeproj"
        try project.validateMinimumXcodeGenVersion(xcodeGenVersion)
        try project.validate()
        let fileWriter = FileWriter(project: project)
        try fileWriter.writePlists()
        let projectGenerator = ProjectGenerator(project: project)
        let xcodeProject = try projectGenerator.generateXcodeProject(in: Path("./\(project.name)/"))
        try fileWriter.writeXcodeProject(xcodeProject, to: Path(projectPath))
    }
}

enum SupportedPlatform: String, Codable, ExpressibleByArgument {
    case mac
    case iOS
}
