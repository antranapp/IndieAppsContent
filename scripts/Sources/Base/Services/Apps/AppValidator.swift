//
//  Copyright © 2020 An Tran. All rights reserved.
//

import Files
import Yams

struct AppValidator {
    
    let folder: Folder
    
    func validate() throws {
        let appFile = try folder.file(named: "app.yml")
        
        let content = try appFile.readAsString()
        let decoder = YAMLDecoder()
        let app = try decoder.decode(App.self, from: content, userInfo: [:])
        
        guard app.id.lowercased() == folder.name.toID else {
            throw ValidateError.idNotMatched(app.id)
        }

        guard app.category.rawValue == folder.parent?.name else {
            throw ValidateError.categoryNotMatched(app.category.rawValue)
        }
    }
    
    enum ValidateError: Error {
        case idNotMatched(String)
        case categoryNotMatched(String)
    }
}
