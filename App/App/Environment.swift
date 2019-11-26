//
//  Environment.swift
//  App
//
//  Created by Paulo Ferreira de Jesus - PFR on 23/11/19.
//  Copyright © 2019 Paulo Ferreira. All rights reserved.
//

import Foundation

class Environment {
    // swiftlint:disable all
    static let baseUrl = URL(string: Bundle.main.object(forInfoDictionaryKey: "BASE_URL") as! String)!

    static let imageBaseUrl = URL(string: Bundle.main.object(forInfoDictionaryKey: "IMAGE_BASE_URL") as! String)!

    static let apiKey = URL(string: Bundle.main.object(forInfoDictionaryKey: "API_KEY") as! String)!
}

enum Language: String {
    case pt_BR = "pt_BR"
    case en_US = "en_US"
}
