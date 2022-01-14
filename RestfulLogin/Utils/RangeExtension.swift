//
//  RangeExtension.swift
//  RestfulLogin
//
//  Created by Michael Angelo Zafra on 1/14/22.
//

import Foundation

extension Range where Bound == String.Index {
    var nsRange:NSRange {
        return NSRange(location: self.lowerBound.encodedOffset,
                   length: self.upperBound.encodedOffset -
                    self.lowerBound.encodedOffset)
    }
}
