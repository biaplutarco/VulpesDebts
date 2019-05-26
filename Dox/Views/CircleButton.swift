//
//  CircleButton.swift
//  Dox
//
//  Created by Bia Plutarco on 26/05/19.
//  Copyright © 2019 Bia Plutarco. All rights reserved.
//

import UIKit

enum ButtonActionType {
    case add
    case exit
}

class CircleButton: UIButton {
    weak var delegate: CircleButtonDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(image: UIImage, type: ButtonActionType) {
        self.init(frame: CGRect.zero)
        configButton(image: image, type: type)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
//ShadowProtocol
extension CircleButton: ShadowProtocol {
    private func configButton(image: UIImage, type: ButtonActionType) {
        switch type {
        case .add:
            self.configShadowIn(view: self, isDark: true)
            self.tintColor = UIColor.AppColors.orange
            
        default:
            self.configShadowIn(view: self, isDark: false)
            self.tintColor = UIColor.AppColors.darkGray
        }
        self.setBackgroundImage(image, for: .normal)
    }
}
