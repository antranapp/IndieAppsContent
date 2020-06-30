//
//  Copyright © 2020 An Tran. All rights reserved.
//

import CodableExtensions
import Foundation

class DateDecodableTransformer: DecodingContainerTransformer {
    
    typealias Input = String
    typealias Output = Date
    
    init() {}
    
    func transform(_ decoded: Input) throws -> Output {
        let dateFormatter = DateFormatter.yyyyMMdd
        guard let date = dateFormatter.date(from: decoded) else {
            throw DecodingError.invalidDate
        }
        
        return date
    }
    
}


class DateEncodableTransformer: EncodingContainerTransformer {

    typealias Input = String
    typealias Output = Date

    init() {}

    func transform(_ encoded: Date) throws -> String {
        let dateFormatter = DateFormatter.yyyyMMdd
        return dateFormatter.string(from: encoded)
    }

}

