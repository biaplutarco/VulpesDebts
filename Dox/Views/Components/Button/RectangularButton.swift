//
//  RectangleButton.swift
//  Dox
//
//  Created by Bia Plutarco on 26/05/19.
//  Copyright © 2019 Bia Plutarco. All rights reserved.
//

import UIKit

class RectangularButton: UIButton {
    convenience init(title: String) {
        self.init(frame: CGRect.zero)
        configButton(title: title)
    }

    private func configButton(title: String) {
        self.layer.cornerRadius = 8
        self.backgroundColor = UIColor.AppColors.debtsBackgroundColor
//        Set LocalizedString to title
        let translatedTitle = NSLocalizedString(title, comment: title)
        self.setTitleColor(UIColor.AppColors.white, for: .normal)
        self.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.setTitle(translatedTitle, for: .normal)
    }
}
