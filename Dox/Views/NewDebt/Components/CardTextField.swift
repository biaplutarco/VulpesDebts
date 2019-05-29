//
//  CardTextField.swift
//  Dox
//
//  Created by Bia Plutarco on 26/05/19.
//  Copyright © 2019 Bia Plutarco. All rights reserved.
//

import UIKit

class CardTextField: UITextField {
    lazy var padding: UIEdgeInsets = {
        let padding = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        return padding
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(backgroundColor color: UIColor) {
        self.init(frame: CGRect.zero)
        configTextField(backgroundColor: color)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}

extension CardTextField: ShadowProtocol {
    private func configTextField(backgroundColor: UIColor) {
        self.backgroundColor = backgroundColor
        self.layer.cornerRadius = 8
        self.configShadowIn(view: self, isDark: false)
    }
}
