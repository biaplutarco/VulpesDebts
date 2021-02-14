//
//  NewDebtDataSource.swift
//  Dox
//
//  Created by Bia Plutarco on 14/02/21.
//  Copyright © 2021 Bia Plutarco. All rights reserved.
//

import UIKit

class NewDebtDataSource: NSObject, UITableViewDataSource {
    
    // MARK: Constants

    enum Constants: CGFloat {
        case heightForRow = 96
    }
    
    // MARK: Private Properties
    
    private let cellIdentifier = "cell"
    
    private var inputCells = [InputCell]()
    private var labelsTitles: [String]
    private var cellTypes: [InputCellType]
    
    private var textFieldHelper: NewDebtTextFieldHelper? {
        didSet {
            textFieldHelper?.addObservers()
            textFieldHelper?.hideKeyboardWhenTappedAround()
        }
    }
    
    // MARK: Initializer
    
    init(labelsTitles: [String], cellTypes: [InputCellType], textFieldHelper: NewDebtTextFieldHelper?) {
        self.labelsTitles = labelsTitles
        self.cellTypes = cellTypes
        self.textFieldHelper = textFieldHelper
    }
    
    // MARK: Methods
    
    func getTextFrom(cellType: InputCellType) -> String {
        return inputCells[cellType.rawValue].getTextFieldTextFor(cellType: cellType)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return labelsTitles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? InputCell else { return UITableViewCell() }

        cell.configCellWith(
            title: labelsTitles[indexPath.row],
            andType: cellTypes[indexPath.row]
        )
        
        cell.delegate = self
        
        inputCells.append(cell)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.heightForRow.rawValue
    }

}

// MARK: Delegate

//  TextField Delegate
extension NewDebtDataSource: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textFieldHelper?.textFieldShouldReturn(textField) ?? false
    }
}
