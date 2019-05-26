//
//  InputLabel.swift
//  Dox
//
//  Created by Bia Plutarco on 25/05/19.
//  Copyright © 2019 Bia Plutarco. All rights reserved.
//

import UIKit

class InputLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(text: String) {
        self.init(frame: CGRect.zero)
        configLabel(text: text)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension InputLabel: AttributedTextProtocol {
    private func configLabel(text: String) {
        self.attributedText = configText(text, size: 16, color: UIColor.AppColors.lightGray, isBold: false)
    }
}
