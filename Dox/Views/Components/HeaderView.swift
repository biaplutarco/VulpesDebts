//
//  HeaderView.swift
//  Dox
//
//  Created by Bia Plutarco on 14/02/21.
//  Copyright © 2021 Bia Plutarco. All rights reserved.
//

import UIKit

// MARK: Delegate

protocol HeaderViewDelegate: class {
    func dismiss()
    func didChangeDebtType(to type: DebtType)
}

// MARK: Class

class HeaderView: UIView, LabelLayoutProtocol {
    
    // MARK: Constants

    enum Constants: CGFloat {
        case mulplierWidth = 0.6
        case mulplierLineWidth = 3
    }
    
    // MARK: Private Properties
    
    private var title: String
    private var segmentedTitles: [String]
    
    // MARK: Subviews

    private lazy var titleLabel: UILabel = {
        let label = createLargeTitleLabel(text: title, andTextColor: UIColor.AppColors.black)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var leftButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "exitButton"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    private lazy var lineStackView: LineStackView = {
        let lineStackView = LineStackView(
            width: frame.width * Constants.mulplierWidth.rawValue,
            titles: segmentedTitles,
            mulplierLineWidth: Int(Constants.mulplierLineWidth.rawValue),
            selectedColor: UIColor.AppColors.black, unselectedColor: UIColor.AppColors.darkGray
        )
        lineStackView.delegate = self
        
        return lineStackView
    }()
    
    // MARK: Initializer
    
    weak var delegate: HeaderViewDelegate?
    
    init(title: String, segmentedTitles: [String]) {
        self.title = title
        self.segmentedTitles = segmentedTitles
        
        super.init(frame: CGRect())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Actions
    
    @objc func exitTapped(_ sender: UIButton) {
        delegate?.dismiss()
    }
    
    // MARK: Methods

    func setupView() {
        translatesAutoresizingMaskIntoConstraints = false

        leftButton.addTarget(self, action: #selector(exitTapped(_:)), for: .touchUpInside)

        buildHierarchy()
        configConstraints()
    }
    
    private func buildHierarchy() {
        addSubview(titleLabel)
        addSubview(leftButton)
        addSubview(lineStackView)
    }
    
    private func configConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 86),
            titleLabel.bottomAnchor.constraint(equalTo: lineStackView.topAnchor, constant: -24),
            titleLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8)
        ])
        
        NSLayoutConstraint.activate([
            leftButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            leftButton.topAnchor.constraint(equalTo: topAnchor, constant: 42),
            leftButton.heightAnchor.constraint(equalToConstant: 42),
            leftButton.widthAnchor.constraint(equalToConstant: 42)
        ])

        NSLayoutConstraint.activate([
            lineStackView.centerXAnchor.constraint(equalTo: centerXAnchor),
            lineStackView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.60),
            lineStackView.heightAnchor.constraint(equalToConstant: 32)
        ])
    }
}

// MARK: SegmentedControl Delegate

extension HeaderView: LineStackViewDelegate {
    func didChangeTo(index: Int) {
        delegate?.didChangeDebtType(to: DebtType(rawValue: index) ?? .none)
    }
}
