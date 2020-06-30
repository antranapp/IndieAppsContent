//
//  Copyright © 2020 An Tran. All rights reserved.
//

import Foundation

extension String {
    
    var toID: String {
        self.replacingOccurrences(of: "_", with: ".")
    }

    var asValidPath: String {
        var invalidCharacters = CharacterSet(charactersIn: ":/.")
        invalidCharacters.formUnion(.newlines)
        invalidCharacters.formUnion(.illegalCharacters)
        invalidCharacters.formUnion(.controlCharacters)

        let newString = components(separatedBy: invalidCharacters)
            .joined(separator: "_")

        return newString
    }
}
