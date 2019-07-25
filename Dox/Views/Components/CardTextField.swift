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
    
    convenience init(backgroundColor color: UIColor) {
        self.init(frame: CGRect.zero)
        configTextField(backgroundColor: color)
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
    
    private func configTextField(backgroundColor: UIColor) {
        self.backgroundColor = backgroundColor
        self.layer.cornerRadius = 10
    }
}
