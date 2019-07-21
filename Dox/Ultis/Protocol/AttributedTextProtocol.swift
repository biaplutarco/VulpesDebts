//
//  AttributedTextProtocol.swift
//  Dox
//
//  Created by Bia Plutarco on 26/05/19.
//  Copyright © 2019 Bia Plutarco. All rights reserved.
//

import UIKit

protocol AttributedTextProtocol: class {
}

extension AttributedTextProtocol {
    func configText(_ text: String, size: CGFloat, color: UIColor, isBold: Bool) -> NSMutableAttributedString {
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
