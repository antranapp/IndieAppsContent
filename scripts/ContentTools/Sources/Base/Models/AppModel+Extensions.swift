//
//  Copyright © 2020 An Tran. All rights reserved.
//

import Yams
import Files
import Foundation

extension App {
    
    static func folder(rootFolder: Folder, category: Category, appID: String, creating: Bool = false) throws -> Folder {
        let appFolderName = appID.lowercased().asValidPath
        let rootAppsFolder = try rootFolder.subfolder(named: "apps")
        let categoryFolder = try rootAppsFolder.subfolder(named: category.rawValue)
        if creating {
            try categoryFolder.createSubfolderIfNeeded(withName: appFolderName)
        }
        let appFolder = try categoryFolder.subfolder(named: appFolderName)
        return appFolder
    }

    func write(to rootFolder: Folder, iconURL: URL?) throws {
        let appFolder = try App.folder(
            rootFolder: rootFolder,
            category: self.category,
            appID: self.id,
            creating: true
        )
        let encoder = YAMLEncoder()        
        let data = try encoder.encode(self)
        try appFolder.createFile(named: "app.yml", contents: data)

        if let iconURL = iconURL {
            let iconData = try Data(contentsOf: iconURL)
            try appFolder.createFile(named: "icon.png", contents: iconData)
        }

        print("👍 \(self.name) is exported succesfully.")
    }
}
