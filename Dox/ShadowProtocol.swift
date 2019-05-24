//
//  ShadowProtocol.swift
//  Dox
//
//  Created by Bia Plutarco on 24/05/19.
//  Copyright © 2019 Bia Plutarco. All rights reserved.
//

import UIKit

protocol ShadowProtocol: class {
}

extension ShadowProtocol {
    func configShadowIn(view: UIView, isDark: Bool) {
        view.clipsToBounds = false
        view.layer.shadowRadius = 22
        view.layer.shadowOffset = CGSize(width: 0, height: 3)
        if isDark {
            view.layer.shadowColor = UIColor.AppColors.darkShadow.cgColor
            view.layer.shadowOpacity = 0.5
        } else {
            view.layer.shadowColor = UIColor.AppColors.lightGray.cgColor
            view.layer.shadowOpacity = 0.25
        }
    }
}
