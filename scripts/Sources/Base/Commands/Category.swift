//
//  Copyright © 2019 An Tran. All rights reserved.
//

import ArgumentParser
import Foundation

extension ContentTools {
    
    struct Category: ParsableCommand {
        
        static let configuration = CommandConfiguration(
            abstract: "Subcommands to manage a category",
            subcommands: [
                Category.Validate.self
            ]
        )
    }
}
