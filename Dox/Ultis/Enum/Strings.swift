//
//  Strings.swift
//  Dox
//
//  Created by Bia Plutarco on 14/02/21.
//  Copyright © 2021 Bia Plutarco. All rights reserved.
//

import Foundation

enum Strings: String {
    case debts
    case newDebt
    case toReceive
    case toPay
    case name
    case reason
    case value
    case type
    case save
    case edit
    case cancel
    case empytLabel
    
    var localize: String {
        return NSLocalizedString(rawValue, comment: rawValue)
    }
}
