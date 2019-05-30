//
//  RectangleButton.swift
//  Dox
//
//  Created by Bia Plutarco on 26/05/19.
//  Copyright © 2019 Bia Plutarco. All rights reserved.
//

import UIKit

class RectangleButton: UIButton {
    convenience init(title: String) {
        self.init(frame: CGRect.zero)
        configButton(title: title)
    }
}
//ShadowProtocol
extension RectangleButton: ShadowProtocol {
    private func configButton(title: String) {
        self.configShadowIn(view: self, isDark: false)
        self.layer.cornerRadius = 8
        self.backgroundColor = UIColor.AppColors.darkGray
//        Set LocalizedString to title
        let translatedTitle = NSLocalizedString(title, comment: title)
        self.setTitle(translatedTitle, for: .normal)
    }
}
