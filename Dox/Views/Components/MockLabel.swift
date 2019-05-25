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
}

enum MockLabelType {
    case cardDebt
    case viewNewDebt
    case button
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
    
    private func configLabel(text: String, type: MockLabelType) {
        switch type {
        case .cardDebt:
            self.attributedText = configAtributedText(text: text, fontSize: 14, color: UIColor.AppColors.gray)
        case .button:
            self.attributedText = configAtributedText(text: text, fontSize: 18, color: UIColor.AppColors.lightGray)
        default:
            self.attributedText = configAtributedText(text: text, fontSize: 20, color: UIColor.AppColors.darkGray)
        }
    }
    
    private func configAtributedText(text: String, fontSize: CGFloat, color: UIColor) -> NSMutableAttributedString {
        let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: fontSize),
                          NSAttributedString.Key.foregroundColor: color]
        return NSMutableAttributedString(string: text, attributes: attributes)
    }
}
