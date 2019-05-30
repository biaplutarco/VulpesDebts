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
        switch type {
        case .insideCard:
            self.attributedText = configText(text, size: 12, color: UIColor.AppColors.gray, isBold: false)
        case .largeTitle:
            self.attributedText = configText(text, size: 34, color: UIColor.AppColors.lightGray, isBold: true)
        case .darkLargeTitle:
            self.attributedText = configText(text, size: 34, color: UIColor.AppColors.darkGray, isBold: true)
        case .insideNewDebt:
            self.attributedText = configText(text, size: 16, color: UIColor.AppColors.darkGray, isBold: true)
        }
    }
}
