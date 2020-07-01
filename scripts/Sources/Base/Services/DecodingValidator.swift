//
//  Copyright © 2020 An Tran. All rights reserved.
//

import Foundation

protocol DecodingValidator {
    associatedtype DataType: Decodable
    func validate(data: Data, type: DataType.Type) throws -> Bool
}
