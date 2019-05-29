//
//  NewDebtVCDelegate.swift
//  Dox
//
//  Created by Bia Plutarco on 29/05/19.
//  Copyright © 2019 Bia Plutarco. All rights reserved.
//

import UIKit

protocol NewDebtVCDelegate: class {
    func addNewDebt(name: String, reason: String, value: String, at: DebtType)
    func didFinishAdd()
}
