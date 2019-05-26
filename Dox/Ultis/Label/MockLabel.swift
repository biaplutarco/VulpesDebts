//
//  MockLabel.swift
//  Dox
//
//  Created by Bia Plutarco on 24/05/19.
//  Copyright © 2019 Bia Plutarco. All rights reserved.
//

import UIKit

enum MockLabelText: String {
    case name = "Name"
    case value = "Value"
    case reason = "Reason"
    case type = "Type"
    case save = "Save"
    case debts = "Debts"
    case newDebt = "New Debt"
}

enum MockLabelType {
    case cardDebt
    case viewNewDebt
    case button
    case title
}

class MockLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(text: MockLabelText, type: MockLabelType) {
        self.init(frame: CGRect.zero)
        configLabel(text: text.rawValue, type: type)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MockLabel {
    private func configLabel(text: String, type: MockLabelType) {
        switch type {
        case .cardDebt:
            self.attributedText = configText(text, size: 12, color: UIColor.AppColors.gray, isBold: false)
        case .button:
            self.attributedText = configText(text, size: 18, color: UIColor.AppColors.lightGray, isBold: true)
        case .title:
            self.attributedText = configText(text, size: 34, color: UIColor.AppColors.lightGray, isBold: true)
        default:
            self.attributedText = configText(text, size: 20, color: UIColor.AppColors.darkGray, isBold: false)
        }
    }
    
    private func configText(_ text: String, size: CGFloat, color: UIColor, isBold: Bool) -> NSMutableAttributedString {
        var font = UIFont()
        if isBold == true {
            font = UIFont.boldSystemFont(ofSize: size)
        } else {
            font = UIFont.systemFont(ofSize: size)
        }
        let attributes = [NSAttributedString.Key.font: font,
                          NSAttributedString.Key.foregroundColor: color]
        return NSMutableAttributedString(string: text, attributes: attributes)
    }
}
