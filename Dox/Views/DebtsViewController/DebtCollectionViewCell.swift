//
//  DebtCollectionViewCell.swift
//  Dox
//
//  Created by Beatriz Plutarco on 23/07/19.
//  Copyright © 2019 Bia Plutarco. All rights reserved.
//

import UIKit

class DebtCollectionViewCell: UICollectionViewCell, LabelLayoutProtocol {
    var isInEditingMode: Bool = false {
        didSet {
            didSelectedBackground()
        }
    }
    
    override var isSelected: Bool {
        didSet {
            didSelectedBackground()
        }
    }
    
    lazy var name: UILabel = {
        let name = createMediumLabel(text: "error", andTextColor: UIColor.AppColors.white)
        name.translatesAutoresizingMaskIntoConstraints = false
        addSubview(name)
        return name
    }()
    
    lazy var reason: UILabel = {
        let reason = createSmallLabel(text: "error", andTextColor: UIColor.AppColors.white)
        reason.translatesAutoresizingMaskIntoConstraints = false
        addSubview(reason)
        return reason
    }()
    
    lazy var value: UILabel = {
        let value = createLargeLabel(text: "error", andTextColor: UIColor.AppColors.white)
        value.translatesAutoresizingMaskIntoConstraints = false
        addSubview(value)
        return value
    }()
    
    func setUp(withDebt debt: Debt) {
        name.text = debt.name
        reason.text = debt.reason
        value.text = debt.value
        layer.cornerRadius = 10
        configConstraints()
        didSelectedBackground()
    }
    
    private func didSelectedBackground() {
        if isInEditingMode {
            if isSelected {
                backgroundColor = UIColor.AppColors.orange
            } else {
                backgroundColor = UIColor.AppColors.gray
            }
        } else {
            backgroundColor = UIColor.AppColors.darkGray
        }
    }
    
    private func configConstraints() {
        NSLayoutConstraint.activate([
            name.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            name.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            name.bottomAnchor.constraint(equalTo: self.reason.topAnchor, constant: -4)
            ])
        
        NSLayoutConstraint.activate([
            reason.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            reason.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16)
            ])
        
        NSLayoutConstraint.activate([
            value.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            value.heightAnchor.constraint(equalToConstant: 40),
            value.centerYAnchor.constraint(equalTo: self.centerYAnchor)
            ])
    }
}
