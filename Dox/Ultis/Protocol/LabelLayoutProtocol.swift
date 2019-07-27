
//
//  LabelLayoutProtocol.swift
//  Dox
//
//  Created by Beatriz Plutarco on 23/07/19.
//  Copyright © 2019 Bia Plutarco. All rights reserved.
//

import UIKit

protocol LabelLayoutProtocol {
}

extension LabelLayoutProtocol {
    func createEmpytLabel(text: String, andTextColor color: UIColor) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = color
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18)
        label.numberOfLines = 3
        return label
    }
    
    func createLargeTitleLabel(text: String, andTextColor color: UIColor) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = color
        label.font = UIFont.boldSystemFont(ofSize: 36)
        return label
    }
    
    func createLargeLabel(text: String, andTextColor color: UIColor) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = color
        label.font = UIFont.boldSystemFont(ofSize: 26)
        return label
    }
    
    func createMediumLabel(text: String, andTextColor color: UIColor) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = color
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }
    
    func createSmallLabel(text: String, andTextColor color: UIColor) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = color
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }
}
