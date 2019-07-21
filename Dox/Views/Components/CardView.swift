//
//  CardView.swift
//  Dox
//
//  Created by Bia Plutarco on 25/05/19.
//  Copyright © 2019 Bia Plutarco. All rights reserved.
//

import UIKit

class CardView: UIView {
    convenience init(backgroundColor color: UIColor) {
        self.init(frame: CGRect.zero)
        configView(backgroundColor: color)
    }

    private func configView(backgroundColor: UIColor) {
        self.backgroundColor = backgroundColor
        self.layer.cornerRadius = 8
    }
}
