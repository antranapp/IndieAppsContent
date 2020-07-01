//
//  Copyright © 2020 An Tran. All rights reserved.
//

import Files
import ArgumentParser

let LATEST_APP_YAML_VERSION = 2

struct ContentTools: ParsableCommand {
    
    static let configuration = CommandConfiguration(
        abstract: "Managing content for the IndieApps app",
        subcommands: [
            App.self,
            Category.self
    ])
    
    @Option(name: .shortAndLong, help: "Root folder of the content")
    private var root: String?
    
    // MARK: APIs
    
    public func run() throws {
        let rootPath = root ?? "."
        let rootFolder = try Folder(path: rootPath)
        let rootAppsFolder = try rootFolder.subfolder(named: "apps")
        for categoryFolder in rootAppsFolder.subfolders {
            let validator = CategoryValidator(folder: categoryFolder)
            try validator.validate()
        }
        
        print("🥳 Content is valid".green())
    }
}
