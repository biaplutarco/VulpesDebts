//
//  RectangularButtonProtocol.swift
//  Dox
//
//  Created by Beatriz Plutarco on 24/07/19.
//  Copyright © 2019 Bia Plutarco. All rights reserved.
//

import UIKit

protocol ButtonProtocol {
}

extension ButtonProtocol {
    func createRectangularButton(text: String) -> UIButton {
        let button = UIButton()
        button.layer.cornerRadius = 10
        button.backgroundColor = UIColor.AppColors.black
        button.setTitleColor(UIColor.AppColors.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.setTitle(text, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }
}
