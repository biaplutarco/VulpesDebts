//
//  NewDebtCell.swift
//  Dox
//
//  Created by Bia Plutarco on 26/05/19.
//  Copyright © 2019 Bia Plutarco. All rights reserved.
//

import UIKit

class NewDebtCell: UITableViewCell {
    lazy var mockLabel: MockLabel = {
        let mockLabel = MockLabel(text: mockLabelTitle, type: .viewNewDebt)
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
    
    func setupCell(title: MockLabelText) {
        self.contentView.backgroundColor = UIColor.AppColors.orange
        self.mockLabelTitle = title
        configConstraints()
    }
}

extension NewDebtCell {
    private func configConstraints() {
        NSLayoutConstraint.activate([
            mockLabel.topAnchor.constraint(equalTo: self.topAnchor),
            mockLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.4),
            mockLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16)
        ])
        
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: mockLabel.bottomAnchor, constant: 8),
            textField.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            textField.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16),
            textField.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
}
