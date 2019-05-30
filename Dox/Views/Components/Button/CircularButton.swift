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
}
//ShadowProtocol
extension CircularButton: ShadowProtocol {
    private func configButton(image: UIImage, type: CircularButtonType) {
        self.setBackgroundImage(image, for: .normal)
        switch type {
        case .add:
            self.configShadowIn(view: self, isDark: true)
            self.tintColor = UIColor.AppColors.orange
        default:
            self.configShadowIn(view: self, isDark: false)
            self.tintColor = UIColor.AppColors.darkGray
        }
    }
}
