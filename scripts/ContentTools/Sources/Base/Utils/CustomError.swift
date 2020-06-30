//
//  Copyright © 2020 An Tran. All rights reserved.
//

import Foundation

struct CustomError: Error, CustomStringConvertible {
    var description: String

    init(_ description: String) {
        self.description = description
    }
}
