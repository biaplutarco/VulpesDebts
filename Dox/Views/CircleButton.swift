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

extension CircleButton: ShadowProtocol {
    private func configButton(image: UIImage, type: ButtonActionType) {
        self.setBackgroundImage(image, for: .normal)
        switch type {
        case .add:
            self.transform.rotated(by: 0)
            self.configShadowIn(view: self, isDark: true)
        default:
            self.transform.rotated(by: .pi/2)
            self.configShadowIn(view: self, isDark: false)
        }
    }
}
