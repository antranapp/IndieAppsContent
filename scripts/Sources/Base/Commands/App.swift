//
//  Copyright © 2019 An Tran. All rights reserved.
//

import ArgumentParser
import Foundation

extension ContentTools {
    
    struct App: ParsableCommand {
        
        static let configuration = CommandConfiguration(
            abstract: "Subcommands to manage an app",
            subcommands: [
                Validate.self,
                Parse.self
            ]
        )
    }
}
