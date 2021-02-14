//
//  NewDebtViewModel.swift
//  Dox
//
//  Created by Bia Plutarco on 14/02/21.
//  Copyright © 2021 Bia Plutarco. All rights reserved.
//

import Foundation

struct NewDebtViewModel {
    
    // MARK: Private Properties
    
    private let inputCellTypes: [InputCellType] = [.name, .reason, .value]
    private let labelsTitles = [
        Strings.name.localize,
        Strings.reason.localize,
        Strings.value.localize,
    ]
    
    // MARK: Properties
    
    let screenTitle = Strings.newDebt.localize
    let saveButtonTitle = Strings.save.localize
    
    let segmentedTitles = [
        Strings.toReceive.localize,
        Strings.toPay.localize,
    ]
    
    var dataSource: NewDebtDataSource {
        return NewDebtDataSource(labelsTitles: labelsTitles, cellTypes: inputCellTypes, textFieldHelper: textFieldHelper)
    }
    
    var textFieldHelper: NewDebtTextFieldHelper?
    
    // MARK: Methods

    func createNewDebt(ofType type: DebtType) -> Debt {
        return CoreDataManager.sharedManager.saveDebt(
            name: dataSource.getTextFrom(cellType: .name),
            reason: dataSource.getTextFrom(cellType: .reason),
            value: dataSource.getTextFrom(cellType: .value),
            type: type
        )
    }
}
