//
//  Copyright © 2019 An Tran. All rights reserved.
//

import Yams
import Files
import ArgumentParser
import ColorizeSwift
import Foundation

extension ContentTools.App {

    /// A command to validate an app folder.
    ///
    /// Steps:
    ///     - Validate existences of app.yml and icon.png
    ///     - Validate app.yaml is well-formatted
    ///     - Validate the folder's name is the same as the app's id
    ///     - Validate app contains all required fields
    ///
    /// Command: ContentTools apps validate category appId
    struct Validate: ParsableCommand {
        
        static let configuration = CommandConfiguration(
            abstract: "Validate an app folder"
        )
        
        // MARK: Properties
        
        @Argument(help: "The `category` of the app, this is also the folder name.")
        private var category: String

        @Argument(help: "The `ID` of the app, this is also the folder name.")
        private var appID: String

        @Option(name: .shortAndLong, help: "Root folder of the content")
        private var root: String?

                
        // MARK: APIs
        
        func run() throws {
            let rootPath = root ?? "."
            let rootFolder = try Folder(path: rootPath)

            let categoryValue = try Category.from(rawValue: category)
            let appFolder = try App.folder(rootFolder: rootFolder, category: categoryValue, appID: appID)
            let validator = AppValidator(folder: appFolder)
            try validator.validate()

            print("🥳 App definition is valid".green())
        }
    }
}
