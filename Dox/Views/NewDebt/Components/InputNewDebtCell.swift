//
//  NewDebtCell.swift
//  Dox
//
//  Created by Bia Plutarco on 26/05/19.
//  Copyright © 2019 Bia Plutarco. All rights reserved.
//

import UIKit

class InputNewDebtCell: UITableViewCell {
    lazy var mockLabel: MockLabel = {
        let mockLabel = MockLabel(text: mockLabelTitle, type: .insideNewDebtVC)
        mockLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(mockLabel)
        return mockLabel
    }()

    lazy var textField: CardTextField = {
        let textField = CardTextField(backgroundColor: UIColor.AppColors.lightGray)
        textField.translatesAutoresizingMaskIntoConstraints = false
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
    
    private func configPlaceholderWith(title: MockLabelText) {
        if title == .name {
            textField.placeholder = NSLocalizedString("Name", comment: "Name")
        } else if title == .reason {
            textField.placeholder = NSLocalizedString("Reason", comment: "Reason")
        }
    }
    
    func configCellWith(title: MockLabelText, to viewController: UIViewController) {
        self.contentView.backgroundColor = UIColor.AppColors.orange
        self.mockLabelTitle = title
        self.textField.delegate = viewController as? UITextFieldDelegate
        configPlaceholderWith(title: title)
        configConstraints()
    }
    
    func getTextFieldInputText() -> String {
        guard let text = textField.text else { return "error" }
        return text
    }
}
//Constraints
extension InputNewDebtCell {
    private func configConstraints() {
        NSLayoutConstraint.activate([
            mockLabel.topAnchor.constraint(equalTo: self.topAnchor),
            mockLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.4),
            mockLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16)
        ])
        
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: mockLabel.bottomAnchor, constant: 10),
            textField.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            textField.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16),
            textField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}
