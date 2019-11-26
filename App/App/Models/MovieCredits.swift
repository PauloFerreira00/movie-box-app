//
//  Credits.swift
//  App
//
//  Created by Paulo Ferreira de Jesus - PFR on 26/11/19.
//  Copyright © 2019 Paulo Ferreira. All rights reserved.
//

import Foundation

struct MovieCredits: Codable {
    let crew: [Crew]
}

struct Crew: Codable {
    let creditID, department: String
    let gender, id: Int
    let job, name: String
    let profilePath: String?

    enum CodingKeys: String, CodingKey {
        case creditID = "credit_id"
        case department, gender, id, job, name
        case profilePath = "profile_path"
    }
}
