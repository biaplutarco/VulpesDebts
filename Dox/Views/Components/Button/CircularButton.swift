//
//  CircleButton.swift
//  Dox
//
//  Created by Bia Plutarco on 26/05/19.
//  Copyright © 2019 Bia Plutarco. All rights reserved.
//

import UIKit

class CircularButton: UIButton {
    convenience init(image: UIImage, type: CircularButtonType) {
        self.init(frame: CGRect.zero)
        configButton(image: image, type: type)
    }
    
    private func configButton(image: UIImage, type: CircularButtonType) {
        self.setBackgroundImage(image, for: .normal)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.cornerRadius = 20
        switch type {
        case .add:
            self.tintColor = UIColor.AppColors.orange
        default:
            self.tintColor = UIColor.AppColors.debtsBackgroundColor
        }
    }
}
