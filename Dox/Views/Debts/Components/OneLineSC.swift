//
//  OneLineSC.swift
//  Dox
//
//  Created by Bia Plutarco on 25/05/19.
//  Copyright © 2019 Bia Plutarco. All rights reserved.
//

import UIKit

class OneLineSC: UIControl {
    lazy var selectorView: UIView = {
        let selectorView = UIView()
        selectorView.backgroundColor = UIColor.AppColors.lightGray
        selectorView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(selectorView)
        return selectorView
    }()
    
    lazy var selectorViewLeftAnchor: NSLayoutConstraint = {
        let leftAnchor = selectorView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: selectorStartpoint)
        return leftAnchor
    }()
    
    lazy var selectorWidth: CGFloat = {
        let selectorWidth = segmentedWidth/CGFloat(buttons.count*selectorMultiple)
        return selectorWidth
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: buttons)
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        return stackView
    }()
    
    lazy var selectorStartpoint: CGFloat = {
        let selectorStartpoint = segmentedWidth/CGFloat(buttons.count*selectorMultiple)
        return selectorStartpoint
    }()
    
    lazy var buttons: [UIButton] = {
        var buttons = [UIButton]()
        for buttonTitle in buttonTitles {
            let button = UIButton(type: .system)
            button.setTitle(buttonTitle, for: .normal)
            button.addTarget(self, action: #selector(buttonAction(sender:)), for: .touchUpInside)
            button.setTitleColor(UIColor.AppColors.gray, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
            buttons.append(button)
        }
        //        Set the first item in button to selected
        buttons[0].setTitleColor(UIColor.AppColors.lightGray, for: .normal)
        return buttons
    }()
    
    weak var delegate: OneLineSGDelegate?
    
    var buttonTitles: [String]
    var segmentedWidth: CGFloat
    var selectorMultiple: Int
    var selectedIndex: Int = 0
    
    init(frame: CGRect, buttonTitles: [String], selectorMultiple: Int, segmentedWidth: CGFloat) {
        self.buttonTitles = buttonTitles
        self.selectorMultiple = selectorMultiple
        self.segmentedWidth = segmentedWidth
        super.init(frame: frame)
    }
    
    convenience init(titles: [String], selectorMultiple multiple: Int, segmentedWidth width: CGFloat) {
        self.init(frame: CGRect.zero, buttonTitles: titles, selectorMultiple: multiple, segmentedWidth: width)
        setIndex(index: selectedIndex)
        configConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    Set Index of StackView
    func setIndex(index: Int) {
//        Set initial index to 0
        selectedIndex = index
        delegate?.didChangeTo(index: index)
    }
    
    @objc func buttonAction(sender: UIButton) {
        for (buttonIndex, button) in buttons.enumerated() {
            button.setTitleColor(UIColor.AppColors.gray, for: .normal)
            if button == sender {
                button.setTitleColor(UIColor.AppColors.lightGray, for: .normal)
                setIndex(index: buttonIndex)
//                Setup to animate anchor
                let offset = selectorStartpoint + selectorWidth*CGFloat(buttonIndex*selectorMultiple)
                selectorViewLeftAnchor.isActive = false
                selectorViewLeftAnchor = selectorView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: offset)
                selectorViewLeftAnchor.isActive = true
//               Animate
                UIView.animate(withDuration: 0.3) {
                    self.layoutIfNeeded()
                }
            }
        }
    }
}

//Constraints
extension OneLineSC {
    private func configConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -1),
            stackView.widthAnchor.constraint(equalTo: self.widthAnchor),
            stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            selectorView.topAnchor.constraint(equalTo: stackView.bottomAnchor),
            selectorView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            selectorView.widthAnchor.constraint(equalToConstant: selectorWidth),
            selectorViewLeftAnchor
        ])
    }
}