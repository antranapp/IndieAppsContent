//
//  Copyright © 2019 An Tran. All rights reserved.
//

import Yams
import Foundation

class YAMLValidator<T: Decodable>: DecodingValidator {
    
    func validate(data: Data) throws -> Bool {
        return try validate(data: data, type: T.self)
    }
    
    func validate(data: Data, type: T.Type) throws -> Bool {
        let decoder = YAMLDecoder()
        guard let string = String(data: data, encoding: .utf8) else {
            throw YAMLValidatorError.invalidInput
        }
        _ = try decoder.decode(type, from: string)
        return true
    }
}

enum YAMLValidatorError: Error {
    case invalidInput
}
