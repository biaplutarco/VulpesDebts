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
//        To stay in back
        self.insertSubview(cardView, at: 1)
        return cardView
    }()
//    MockLabels
    lazy var mockLabelName: MockLabel = {
        let label = MockLabel(text: .name, type: .insideCard)
        label.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(label)
        return label
    }()
    
    lazy var mockLabelValue: MockLabel = {
        let label = MockLabel(text: .value, type: .insideCard)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        self.addSubview(label)
        return label
    }()
    
    lazy var mockLabelReason: MockLabel = {
        let label = MockLabel(text: .reason, type: .insideCard)
        label.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(label)
        return label
    }()
//    InputLabels
    lazy var inputLabelName: UILabel = {
        let label = UILabel()
        label.attributedText = configText("error", size: 16, color: UIColor.AppColors.lightGray, isBold: true)
        label.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(label)
        return label
    }()
    
    lazy var inputLabelReason: UILabel = {
        let label = UILabel()
        label.attributedText = configText("error", size: 16, color: UIColor.AppColors.lightGray, isBold: true)
        label.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(label)
        return label
    }()
    
    lazy var inputLabelValue: UILabel = {
        let label = UILabel()
        label.attributedText = configText("error", size: 16, color: UIColor.AppColors.lightGray, isBold: true)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        self.addSubview(label)
        return label
    }()
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.contentView.backgroundColor = UIColor.AppColors.darkGray
        configConstraints()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.selectionStyle = .none
    }
}
//AttributedTextProtocol
extension DebtCell: AttributedTextProtocol {
    func configCellWith(debt: Debt, andTextColor color: UIColor) {
        inputLabelName.attributedText = configText(debt.name, size: 16, color: color, isBold: true)
        inputLabelValue.attributedText = configText(debt.value, size: 16, color: color, isBold: true)
        inputLabelReason.attributedText = configText(debt.reason, size: 16, color: color, isBold: true)
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