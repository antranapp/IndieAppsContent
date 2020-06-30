//
//  Copyright © 2019 An Tran. All rights reserved.
//

import Yams
import Files
import ArgumentParser
import ColorizeSwift
import Foundation

extension ContentTools.App {

    /// A command to parse information from an app from App Store
    ///
    /// Command: ContentTools apps parse  appStoreID
    struct Parse: ParsableCommand {

        static let configuration = CommandConfiguration(
            abstract: "Parse information of an app from remote"
        )

        // MARK: Properties

        @Argument(help: "The `ID` of the app.")
        private var appStoreID: String

        @Option(name: .shortAndLong, help: "Root folder of the content")
        private var root: String?


        // MARK: APIs

        func run() throws {
            let rootPath = root ?? "."
            let rootFolder = try Folder(path: rootPath)

            let lookupURLString = "https://itunes.apple.com/lookup?id=\(appStoreID)"
            guard let lookupURL = URL(string: lookupURLString) else {
                throw CustomError("invalid lookup url")
            }
            let data = try Data(contentsOf: lookupURL)
            let jsonDecoder = JSONDecoder()
            let lookupApps = try jsonDecoder.decode(LookupAppsModel.self, from: data)
            guard let lookupApp = lookupApps.results.first else {
                throw CustomError("no app found")
            }

            let app = App(
                version: LATEST_APP_YAML_VERSION,
                id: lookupApp.bundleId,
                name: lookupApp.trackName,
                shortDescription: "",
                description: "",
                category: try Category.from(rawValue: lookupApp.primaryGenreName),
                links: [
                    Link(value: "https://apps.apple.com/app/a-shell/id\(appStoreID)", type: .appstore)
                ],
                previews: [
                    Preview(type: .iOS, links: lookupApp.screenshotUrls.compactMap { URL(string: $0) })
                ],
                releaseNotes: [
                    ReleaseNote(version: lookupApp.version, note: lookupApp.releaseNotes)
                ]
            )

            try app.write(
                to: rootFolder,
                iconURL: URL(string: lookupApp.artworkUrl512)
            )
        }
    }
}

private struct LookupAppsModel: Decodable {
    var resultCount: Int
    var results: [LookupAppModel]
}

private struct LookupAppModel: Decodable {
    var bundleId: String
    var trackName: String
    var artworkUrl512: String
    var screenshotUrls: [String]
    var primaryGenreName: String
    var releaseNotes: String
    var version: String
}
