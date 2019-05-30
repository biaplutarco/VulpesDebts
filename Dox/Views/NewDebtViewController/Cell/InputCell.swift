//
//  NewDebtCell.swift
//  Dox
//
//  Created by Bia Plutarco on 26/05/19.
//  Copyright © 2019 Bia Plutarco. All rights reserved.
//

import UIKit

enum InputCellType {
    case name
    case reason
    case value
}

class InputCell: UITableViewCell {
//    Label
    lazy var mockLabel: MockLabel = {
        let mockLabel = MockLabel(text: "error", type: .insideNewDebt)
        mockLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(mockLabel)
        return mockLabel
    }()
//    TextField
    lazy var textField: CardTextField = {
        let textField = CardTextField(backgroundColor: UIColor.AppColors.lightGray)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    lazy var symbolTextField: CardTextField = {
        let textField = CardTextField(backgroundColor: UIColor.AppColors.lightGray)
        textField.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(textField)
        return textField
    }()
    
    lazy var valueTextField: CardTextField = {
        let textField = CardTextField(backgroundColor: UIColor.AppColors.lightGray)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textAlignment = .right
        self.addSubview(textField)
        return textField
    }()
//    Method
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.selectionStyle = .none
    }
    
    override func draw(_ rect: CGRect) {
        self.contentView.backgroundColor = UIColor.AppColors.orange
    }
    
    func configCellWith(title: String, andType cellType: InputCellType, to viewController: UIViewController) {
        self.mockLabel.text = title
        self.textField.delegate = viewController as? UITextFieldDelegate
        configPlaceholderTo(cellType: cellType)
        configConstraintsTo(cellType: cellType)
    }
    
    func getTextFieldTextFor(cellType: InputCellType) -> String {
        switch cellType {
        case .value:
            guard let valueText = valueTextField.text,
                  let symbolText = symbolTextField.text else { return "error" }
            let text = "\(symbolText)\(valueText)"
            return text
        default:
            guard let text = textField.text else { return "error" }
            return text
        }
    }
    
    private func configPlaceholderTo(cellType: InputCellType) {
        switch cellType {
        case .name:
            textField.placeholder = NSLocalizedString("Name", comment: "Name")
        case .reason:
            textField.placeholder = NSLocalizedString("Reason", comment: "Reason")
        case .value:
            symbolTextField.placeholder = NSLocalizedString("$", comment: "$")
            valueTextField.placeholder = "00,00"
        }
    }
}
//Constraints
extension InputCell {
    private func configConstraintsTo(cellType: InputCellType) {
        switch cellType {
        case .value:
            NSLayoutConstraint.activate([
                mockLabel.topAnchor.constraint(equalTo: self.topAnchor),
                mockLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.4),
                mockLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16)
            ])
            
            NSLayoutConstraint.activate([
                symbolTextField.topAnchor.constraint(equalTo: mockLabel.bottomAnchor, constant: 10),
                symbolTextField.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
                symbolTextField.rightAnchor.constraint(equalTo: valueTextField.leftAnchor, constant: -12),
                symbolTextField.widthAnchor.constraint(equalToConstant: 68),
                symbolTextField.heightAnchor.constraint(equalToConstant: 40)
            ])
            
            NSLayoutConstraint.activate([
                valueTextField.topAnchor.constraint(equalTo: mockLabel.bottomAnchor, constant: 10),
                valueTextField.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16),
                valueTextField.heightAnchor.constraint(equalToConstant: 40)
            ])
        default:
            NSLayoutConstraint.activate([
                mockLabel.topAnchor.constraint(equalTo: self.topAnchor),
                mockLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.4),
                mockLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16)
            ])
            
            self.addSubview(textField)
            NSLayoutConstraint.activate([
                textField.topAnchor.constraint(equalTo: mockLabel.bottomAnchor, constant: 10),
                textField.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
                textField.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16),
                textField.heightAnchor.constraint(equalToConstant: 40)
            ])
        } 
    }
}
