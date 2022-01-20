//
//  DictionaryExt.swift
//  RestfulLogin
//
//  Created by Michael Angelo Zafra on 1/20/22.
//

import Foundation

extension Dictionary {
    func asMessage() -> Message? {
        do {
            let json = try JSONSerialization.data(withJSONObject: self)
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let decoded = try decoder.decode(Message.self, from: json)
            print("firebase to object \(decoded)")
            return decoded
        } catch {
            print(error)
            return nil
        }
    }
}
