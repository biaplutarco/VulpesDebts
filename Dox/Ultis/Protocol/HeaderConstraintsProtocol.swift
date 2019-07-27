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
    func configHeaderConstraints(title: UILabel, segControl: UIControl, leftButton: UIButton, at view: UIView) {
        NSLayoutConstraint.activate([
            title.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            title.topAnchor.constraint(equalTo: view.topAnchor, constant: 86),
            title.bottomAnchor.constraint(equalTo: segControl.topAnchor, constant: -24),
            title.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8)
        ])
        
        NSLayoutConstraint.activate([
            leftButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            leftButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 42),
            leftButton.heightAnchor.constraint(equalToConstant: 42),
            leftButton.widthAnchor.constraint(equalToConstant: 42)
        ])
        
        NSLayoutConstraint.activate([
            segControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            segControl.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.60),
            segControl.heightAnchor.constraint(equalToConstant: 32)
        ])
    }
}
