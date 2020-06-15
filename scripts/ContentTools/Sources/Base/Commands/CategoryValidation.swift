//
//  Copyright © 2019 An Tran. All rights reserved.
//

import Yams
import Files
import ArgumentParser
import ColorizeSwift
import Foundation

extension ContentTools.Category {
    
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
        
        @Option(name: .shortAndLong, help: "Root folder of the content")
        private var root: String?
        
        // MARK: APIs
        
        func run() throws {
            let rootPath = root ?? "."
            let rootFolder = try Folder(path: rootPath)
            let rootAppsFolder = try rootFolder.subfolder(named: "apps")
            let categoryFolder = try rootAppsFolder.subfolder(named: category)
            let validator = CategoryValidator(folder: categoryFolder)
            try validator.validate()
            
            print("🥳 Apps in \(category) are valid".green())
        }
    }
}
