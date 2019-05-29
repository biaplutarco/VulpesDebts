//
//  ValueDebtCell.swift
//  Dox
//
//  Created by Bia Plutarco on 28/05/19.
//  Copyright © 2019 Bia Plutarco. All rights reserved.
//

import UIKit

class ValueDebtCell: UITableViewCell {

    lazy var mockLabel: MockLabel = {
        let mockLabel = MockLabel(text: mockLabelTitle, type: .viewNewDebt)
        mockLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(mockLabel)
        return mockLabel
    }()
    
    lazy var symbolTextField: CardTextField = {
        let textField = CardTextField(backgroundColor: UIColor.AppColors.lightGray)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = NSLocalizedString("$", comment: "$")
        self.addSubview(textField)
        return textField
    }()
    
    lazy var valueTextField: CardTextField = {
        let textField = CardTextField(backgroundColor: UIColor.AppColors.lightGray)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "00,00"
        textField.textAlignment = .right
        self.addSubview(textField)
        return textField
    }()
    
    lazy var mockLabelTitle: MockLabelText = {
        let mockLabelTitle = MockLabelText.error
        return mockLabelTitle
    }()
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.selectionStyle = .none
    }
    
    func setupCell(title: MockLabelText, for viewController: UIViewController) {
        self.contentView.backgroundColor = UIColor.AppColors.orange
        self.mockLabelTitle = title
        self.valueTextField.delegate = viewController as? UITextFieldDelegate
        self.symbolTextField.delegate = viewController as? UITextFieldDelegate
        configConstraints()
    }
}

extension ValueDebtCell {
    private func configConstraints() {
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
    }
}
