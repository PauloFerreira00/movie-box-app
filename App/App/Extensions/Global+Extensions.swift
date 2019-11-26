//
//  Global+Extensions.swift
//  App
//
//  Created by Paulo Ferreira de Jesus - PFR on 25/11/19.
//  Copyright © 2019 Paulo Ferreira. All rights reserved.
//

import Foundation

extension DateFormatter {
    func formatWith(dateString: String, patternInput: String, patternOutput: String) -> String {
        self.dateFormat = patternInput
        guard let date = self.date(from: dateString) else { return String() }
        self.dateFormat = patternOutput
        return self.string(from: date)
    }
}
