//
//  Validation.swift
//  itunes_lookup
//
//  Created by Michael Nienaber on 9/21/16.
//  Copyright © 2016 Michael Nienaber. All rights reserved.
//

import Foundation

class Validation {
    static func isStringNumerical(string : String) -> Bool {
        // Only allow numbers. Look for anything not a number.
        let range = string.rangeOfCharacter(from: NSCharacterSet.decimalDigits.inverted)
        return (range == nil)
    }
}
