//
//  Copyright © 2020 An Tran. All rights reserved.
//

import Files

extension App {
    
    static func folder(rootFolder: Folder, category: String, appID: String) throws -> Folder {
        let rootAppsFolder = try rootFolder.subfolder(named: "apps")
        let categoryFolder = try rootAppsFolder.subfolder(named: category)
        let appFolder = try categoryFolder.subfolder(named: appID)
        return appFolder
    }
}
