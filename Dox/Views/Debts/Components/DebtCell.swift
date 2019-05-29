//
//  DebtCell.swift
//  Dox
//
//  Created by Bia Plutarco on 24/05/19.
//  Copyright © 2019 Bia Plutarco. All rights reserved.
//

import UIKit

class DebtCell: UITableViewCell {
    lazy var cardView: CardView = {
        let cardView = CardView(backgroundColor: UIColor.AppColors.mediumGray)
        cardView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(cardView)
        return cardView
    }()
    
    lazy var mockLabelName: MockLabel = {
        let label = MockLabel(text: .name, type: .cardDebt)
        label.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(label)
        return label
    }()
    
    lazy var mockLabelValue: MockLabel = {
        let label = MockLabel(text: .value, type: .cardDebt)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        self.addSubview(label)
        return label
    }()
    
    lazy var mockLabelReason: MockLabel = {
        let label = MockLabel(text: .reason, type: .cardDebt)
        label.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(label)
        return label
    }()
    
    lazy var inputLabelName: InputLabel = {
        let label = InputLabel(text: "error")
        label.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(label)
        return label
    }()
    
    lazy var inputLabelReason: InputLabel = {
        let label = InputLabel(text: "error")
        label.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(label)
        return label
    }()
    
    lazy var inputLabelValue: InputLabel = {
        let label = InputLabel(text: "error")
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        self.addSubview(label)
        return label
    }()
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        configConstraints()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.selectionStyle = .none
    }
    
    func setupCell(name: String, reason: String, value: String) {
        self.contentView.backgroundColor = UIColor.AppColors.darkGray
        inputLabelName.text = name
        inputLabelValue.text = value
        inputLabelReason.text = reason
    }
}

//Constraints
extension DebtCell {
    private func configConstraints() {
        NSLayoutConstraint.activate([
            cardView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            cardView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.88),
            cardView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            cardView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            mockLabelName.leftAnchor.constraint(equalTo: cardView.leftAnchor, constant: 12),
            mockLabelName.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 12),
            mockLabelName.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.4)
        ])
        
        NSLayoutConstraint.activate([
            inputLabelName.leftAnchor.constraint(equalTo: cardView.leftAnchor, constant: 12),
            inputLabelName.topAnchor.constraint(equalTo: mockLabelName.bottomAnchor, constant: 4),
            inputLabelName.widthAnchor.constraint(equalTo: cardView.widthAnchor, multiplier: 0.4)
        ])
        
        NSLayoutConstraint.activate([
            mockLabelReason.leftAnchor.constraint(equalTo: cardView.leftAnchor, constant: 12),
            mockLabelReason.topAnchor.constraint(equalTo: inputLabelName.bottomAnchor, constant: 12),
            mockLabelReason.widthAnchor.constraint(equalTo: cardView.widthAnchor, multiplier: 0.4)
        ])
        
        NSLayoutConstraint.activate([
            inputLabelReason.leftAnchor.constraint(equalTo: cardView.leftAnchor, constant: 12),
            inputLabelReason.topAnchor.constraint(equalTo: mockLabelReason.bottomAnchor, constant: 4),
            inputLabelReason.widthAnchor.constraint(equalTo: cardView.widthAnchor, multiplier: 0.8)
        ])
        
        NSLayoutConstraint.activate([
            mockLabelValue.rightAnchor.constraint(equalTo: cardView.rightAnchor, constant: -12),
            mockLabelValue.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 12),
            mockLabelValue.widthAnchor.constraint(equalTo: cardView.widthAnchor, multiplier: 0.4)
        ])
        
        NSLayoutConstraint.activate([
            inputLabelValue.rightAnchor.constraint(equalTo: cardView.rightAnchor, constant: -12),
            inputLabelValue.topAnchor.constraint(equalTo: mockLabelValue.bottomAnchor, constant: 4),
            inputLabelValue.widthAnchor.constraint(equalTo: cardView.widthAnchor, multiplier: 0.4)
        ])
    }
}
