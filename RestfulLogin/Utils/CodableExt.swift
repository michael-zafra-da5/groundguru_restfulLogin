//
//  CodableExt.swift
//  RestfulLogin
//
//  Created by Michael Angelo Zafra on 1/20/22.
//

import Foundation

extension Encodable {
    func asDictionary() -> [String: Any] {
        do {
            //Testing.asDictionary()
            let data = try JSONEncoder().encode(self)
            guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
                return [:]
            }
            return dictionary
        } catch {
            return [:]
        }
    }
}
