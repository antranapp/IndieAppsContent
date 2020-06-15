//
//  Copyright © 2020 An Tran. All rights reserved.
//

import Files
import Yams

struct CategoryValidator {
    
    let folder: Folder
    
    func validate() throws {
        for appFolder in folder.subfolders {
            let validator = AppValidator(folder: appFolder)
            try validator.validate()
        }
    }    
}
