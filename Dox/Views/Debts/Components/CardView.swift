//
//  CardView.swift
//  Dox
//
//  Created by Bia Plutarco on 25/05/19.
//  Copyright © 2019 Bia Plutarco. All rights reserved.
//

import UIKit

class CardView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(backgroundColor color: UIColor) {
        self.init(frame: CGRect.zero)
        configView(backgroundColor: color)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CardView: ShadowProtocol {
    private func configView(backgroundColor: UIColor) {
        self.backgroundColor = backgroundColor
        self.layer.cornerRadius = 8
        self.configShadowIn(view: self, isDark: true)
    }
}
