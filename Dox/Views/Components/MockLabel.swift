//
//  MockLabel.swift
//  Dox
//
//  Created by Bia Plutarco on 24/05/19.
//  Copyright © 2019 Bia Plutarco. All rights reserved.
//

import UIKit

class MockLabel: UILabel {
    convenience init(text: String, type: MockLabelType) {
        self.init(frame: CGRect.zero)
        configLabel(text: text, type: type)
    }
}
//AttributedTextProtocol
extension MockLabel: AttributedTextProtocol {
    private func configLabel(text: String, type: MockLabelType) {
        self.translatesAutoresizingMaskIntoConstraints = false
        switch type {
        case .insideCard:
            self.attributedText = configText(text, size: 12, color: UIColor.AppColors.debtsFontColor, isBold: false)
        case .largeTitle:
            self.attributedText = configText(text, size: 36, color: UIColor.AppColors.debtsFontColor, isBold: true)
        case .darkLargeTitle:
            self.attributedText = configText(text, size: 36, color: UIColor.AppColors.newDebtFontColor, isBold: true)
        case .insideNewDebt:
            self.attributedText = configText(text, size: 16, color: UIColor.AppColors.newDebtFontColor, isBold: true)
        }
    }
}
