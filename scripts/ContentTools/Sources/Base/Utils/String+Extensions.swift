//
//  Copyright © 2020 An Tran. All rights reserved.
//

import Foundation

extension String {
    
    var toID: String {
        self.replacingOccurrences(of: "_", with: ".")
    }
}
