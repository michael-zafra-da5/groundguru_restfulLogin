//
//  RegisterResponse.swift
//  RestfulLogin
//
//  Created by Michael Angelo Zafra on 1/13/22.
//

import Foundation

struct RegisterResponse : Codable {
//    var $id: Int
    var code: Int
    var message: String
    var data: DataResponse?
}

struct DataResponse : Codable {
//    var $id: Int
    var Id: Int
    var Name: String
    var Email: String
    var Token: String
}
