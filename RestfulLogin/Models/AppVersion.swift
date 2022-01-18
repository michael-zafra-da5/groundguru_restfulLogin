//
//  AppVersion.swift
//  DA5-APP
//
//  Created by Michael Angelo Zafra on 4/28/21.
//  Copyright © 2021 OA. All rights reserved.
//

import UIKit

// MARK: - AppVersion
struct AppVersion: Codable {
    let platform: Int
    let version: String
    let country: CountryCurrency

    enum CodingKeys: String, CodingKey {
        case platform, version, country
    }
}

struct CountryCurrency: Codable {
    let country: String
    let country_code: String
    let currency_code: String
}
