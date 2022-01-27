//
//  Message.swift
//  RestfulLogin
//
//  Created by Michael Angelo Zafra on 1/20/22.
//

import Foundation

struct Message : Codable {
    let message: String
    let sender: String
    let testData : String
    let maskQuantity : String
    
    enum CodingKeys: String, CodingKey {
        case testData = "firebase key"
        case maskQuantity = "Mask Quantity"
        
        case message
        case sender
    }
}
