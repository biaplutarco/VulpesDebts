//
//  LineSegmentedControl.swift
//  Dox
//
//  Created by Bia Plutarco on 25/05/19.
//  Copyright © 2019 Bia Plutarco. All rights reserved.
//

import UIKit

class LineSegmentedControl: UIControl {
    lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: buttons)
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        return stackView
    }()
    
    lazy var lineView: UIView = {
        let lineView = UIView()
        lineView.backgroundColor = selectedColor
        lineView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(lineView)
        return lineView
    }()
    
    lazy var lineViewLeftAnchor: NSLayoutConstraint = {
        let leftAnchor = lineView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: lineStartpoint)
        return leftAnchor
    }()
    
    lazy var lineWidth: CGFloat = {
        let selectorWidth = width/CGFloat(buttons.count*mulplierLineWidth)
        return selectorWidth
    }()
    
    lazy var lineStartpoint: CGFloat = {
        let selectorStartpoint = width/CGFloat(buttons.count*mulplierLineWidth)
        return selectorStartpoint
    }()
    
    lazy var buttons: [UIButton] = {
        var buttons = [UIButton]()
        for title in titles {
            let button = UIButton(type: .system)
            button.setTitle(title, for: .normal)
            button.setTitleColor(unselectedColor, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
            button.addTarget(self, action: #selector(buttonAction(sender:)), for: .touchUpInside)
            buttons.append(button)
        }
//        Set the first item in button to selected
        buttons[0].setTitleColor(selectedColor, for: .normal)
        buttons[0].titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        return buttons
    }()
    
    weak var delegate: LineSegmentedControlDelegate?
    
    var titles: [String]
    var width: CGFloat
    var mulplierLineWidth: Int
    var selectedColor: UIColor
    var unselectedColor: UIColor
    var selectedIndex: Int = 0
    
    private init(frame: CGRect, width: CGFloat, titles: [String], mulplierLineWidth: Int,
                 selectedColor: UIColor, unselectedColor: UIColor) {
        self.width = width
        self.titles = titles
        self.mulplierLineWidth = mulplierLineWidth
        self.selectedColor = selectedColor
        self.unselectedColor = unselectedColor
        super.init(frame: frame)
    }
    
    convenience init(width: CGFloat, titles: [String], mulplierLineWidth: Int, selectedColor: UIColor,
                     unselectedColor: UIColor) {
        self.init(frame: CGRect.zero, width: width, titles: titles, mulplierLineWidth: mulplierLineWidth,
                  selectedColor: selectedColor, unselectedColor: unselectedColor)
        setIndex(index: selectedIndex)
        self.translatesAutoresizingMaskIntoConstraints = false
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
    
    func seletedButton(_ button: UIButton, at index: Int) {
        button.setTitleColor(selectedColor, for: .normal)
        setIndex(index: index)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
//        Setup to animate anchor
        let offset = lineStartpoint + lineWidth * CGFloat(index * mulplierLineWidth)
        lineViewLeftAnchor.isActive = false
        lineViewLeftAnchor = lineView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: offset)
        lineViewLeftAnchor.isActive = true
//        Animate
        UIView.animate(withDuration: 0.3) {
            self.layoutIfNeeded()
        }
    }
    
    func selectedButtonAt(index: Int) {
        if index == 0 {
            buttons[1].setTitleColor(unselectedColor, for: .normal)
        } else if index == 1 {
            buttons[0].setTitleColor(unselectedColor, for: .normal)
        }
        
        buttons[index].setTitleColor(selectedColor, for: .normal)
        setIndex(index: index)
        buttons[index].titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        //        Setup to animate anchor
        let offset = lineStartpoint + lineWidth * CGFloat(index * mulplierLineWidth)
        lineViewLeftAnchor.isActive = false
        lineViewLeftAnchor = lineView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: offset)
        lineViewLeftAnchor.isActive = true
        //        Animate
        UIView.animate(withDuration: 0.3) {
            self.layoutIfNeeded()
        }
    }
    
    @objc func buttonAction(sender: UIButton) {
        for (index, button) in buttons.enumerated() {
            button.setTitleColor(unselectedColor, for: .normal)
            if button == sender {
                seletedButton(button, at: index)
            }
        }
    }
}
//Constraints
extension LineSegmentedControl {
    private func configConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -1),
            stackView.widthAnchor.constraint(equalTo: self.widthAnchor),
            stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            lineView.topAnchor.constraint(equalTo: stackView.bottomAnchor),
            lineView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            lineView.widthAnchor.constraint(equalToConstant: lineWidth),
            lineViewLeftAnchor
        ])
    }
}
