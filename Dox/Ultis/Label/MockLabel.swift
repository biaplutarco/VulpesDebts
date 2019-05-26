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
    case debts = "Debts"
    case newDebt = "New Debt"
    case error = "error"
}

enum MockLabelType {
    case cardDebt
    case viewNewDebt
    case title
    case titleDark
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

extension MockLabel: AttributedTextProtocol {
    private func configLabel(text: String, type: MockLabelType) {
        switch type {
        case .cardDebt:
            self.attributedText = configText(text, size: 12, color: UIColor.AppColors.gray, isBold: false)
        case .title:
            self.attributedText = configText(text, size: 34, color: UIColor.AppColors.lightGray, isBold: true)
        case .titleDark:
            self.attributedText = configText(text, size: 34, color: UIColor.AppColors.darkGray, isBold: true)
        default:
            self.attributedText = configText(text, size: 20, color: UIColor.AppColors.darkGray, isBold: false)
        }
    }
}
