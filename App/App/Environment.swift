//
//  Environment.swift
//  App
//
//  Created by Paulo Ferreira de Jesus - PFR on 23/11/19.
//  Copyright © 2019 Paulo Ferreira. All rights reserved.
//

import Foundation

class Environment {

    static let baseUrl = URL(string: Bundle.main.object(forInfoDictionaryKey: "BASE_URL") as! String)!

    static let imageBaseUrl = URL(string: Bundle.main.object(forInfoDictionaryKey: "IMAGE_BASE_URL") as! String)!
}
