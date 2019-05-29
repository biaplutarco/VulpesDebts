//
//  MockLabel.swift
//  Dox
//
//  Created by Bia Plutarco on 24/05/19.
//  Copyright © 2019 Bia Plutarco. All rights reserved.
//

import UIKit

enum MockLabelText: String {
    case name
    case value
    case reason
    case type
    case debts
    case newDebt
    case error
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
        uptadeString(text: text, type: type)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MockLabel: AttributedTextProtocol {
    private func uptadeString(text: MockLabelText, type: MockLabelType) {
        let string = translateString(text)
        configLabel(text: string, type: type)
    }
    
    private func configLabel(text: String, type: MockLabelType) {
        switch type {
        case .cardDebt:
            self.attributedText = configText(text, size: 12, color: UIColor.AppColors.gray, isBold: false)
        case .title:
            self.attributedText = configText(text, size: 34, color: UIColor.AppColors.lightGray, isBold: true)
        case .titleDark:
            self.attributedText = configText(text, size: 34, color: UIColor.AppColors.darkGray, isBold: true)
        case .viewNewDebt:
            self.attributedText = configText(text, size: 18, color: UIColor.AppColors.darkGray, isBold: false)
        }
    }
    
    private func translateString(_ mockLabelText: MockLabelText) -> String {
        switch mockLabelText {
        case .debts:
            return NSLocalizedString("Debts", comment: "Debts")
        case .newDebt:
            return NSLocalizedString("New Debt", comment: "New Debt")
        case .name:
            return NSLocalizedString("Name", comment: "Name")
        case .value:
            return NSLocalizedString("Value", comment: "Value")
        case .reason:
            return NSLocalizedString("Reason", comment: "Reason")
        case .type:
            return NSLocalizedString("Type", comment: "Type")
        case .error:
            return "error"
        }
    }
}
