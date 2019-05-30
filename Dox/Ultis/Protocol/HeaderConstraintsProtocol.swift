//
//  HeaderConstraintsProtocol.swift
//  Dox
//
//  Created by Bia Plutarco on 29/05/19.
//  Copyright © 2019 Bia Plutarco. All rights reserved.
//

import UIKit

protocol HeaderConstraintsProtocol {
}

extension HeaderConstraintsProtocol {
    func configHeaderConstraints(largeTitle: UILabel, segmentedControl: UIControl, button: UIButton, at view: UIView) {
        NSLayoutConstraint.activate([
            largeTitle.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            largeTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: 58),
            largeTitle.bottomAnchor.constraint(equalTo: segmentedControl.topAnchor, constant: -24),
            largeTitle.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8)
        ])
        
        NSLayoutConstraint.activate([
            button.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            button.topAnchor.constraint(equalTo: view.topAnchor, constant: 40),
            button.heightAnchor.constraint(equalToConstant: 42),
            button.widthAnchor.constraint(equalToConstant: 42)
        ])
        
        NSLayoutConstraint.activate([
            segmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            segmentedControl.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.60),
            segmentedControl.heightAnchor.constraint(equalToConstant: 32)
        ])
    }
}
