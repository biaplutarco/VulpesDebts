//
//  NewDebtCell.swift
//  Dox
//
//  Created by Bia Plutarco on 26/05/19.
//  Copyright © 2019 Bia Plutarco. All rights reserved.
//

import UIKit

class InputCell: UITableViewCell, LabelLayoutProtocol {
    var myPickerData = ["R$", "$", "£", "€"]
    
//    Label
    lazy var mockLabel: UILabel = {
        let mockLabel = createMediumLabel(text: "error", andTextColor: UIColor.AppColors.black)
        mockLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(mockLabel)
        return mockLabel
    }()
//    TextField
    lazy var textField: CardTextField = {
        let textField = CardTextField(backgroundColor: UIColor.AppColors.lightOrange)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    lazy var symbolTextField: CardTextField = {
        let textField = CardTextField(backgroundColor: UIColor.AppColors.lightOrange)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.inputView = pickerSymbols
        self.addSubview(textField)
        return textField
    }()
    
    lazy var valueTextField: CardTextField = {
        let textField = CardTextField(backgroundColor: UIColor.AppColors.lightOrange)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textAlignment = .right
        textField.keyboardType = UIKeyboardType.decimalPad
        self.addSubview(textField)
        return textField
    }()
    
    lazy var pickerSymbols: UIPickerView = {
        let pickerSymbols = UIPickerView()
        pickerSymbols.delegate = self
        return pickerSymbols
    }()
    
    weak var delegate: UITextFieldDelegate?
    
//    Method
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.selectionStyle = .none
    }
    
    override func draw(_ rect: CGRect) {
        self.contentView.backgroundColor = UIColor.AppColors.orange
    }
    
    func configCellWith(title: String, andType cellType: InputCellType) {
        self.mockLabel.text = title
        self.textField.delegate = delegate
        
        configPlaceholderTo(cellType: cellType)
        configConstraintsTo(cellType: cellType)
    }
    
    func getTextFieldTextFor(cellType: InputCellType) -> String {
        switch cellType {
        case .value:
            guard let valueText = valueTextField.text,
                  let symbolText = symbolTextField.text else { return "error" }
            let text = "\(symbolText)\(valueText)"
            return text
        default:
            guard let text = textField.text else { return "error" }
            return text
        }
    }
    
    private func configPlaceholderTo(cellType: InputCellType) {
        switch cellType {
        case .name:
            textField.placeholder = NSLocalizedString("Name", comment: "Name")
        case .reason:
            textField.placeholder = NSLocalizedString("Reason", comment: "Reason")
        case .value:
            symbolTextField.placeholder = NSLocalizedString("$", comment: "$")
            valueTextField.placeholder = "00,00"
        }
    }
}
//Constraints
extension InputCell {
    private func configConstraintsTo(cellType: InputCellType) {
        switch cellType {
        case .value:
            NSLayoutConstraint.activate([
                mockLabel.topAnchor.constraint(equalTo: self.topAnchor),
                mockLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.4),
                mockLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20)
            ])
            
            NSLayoutConstraint.activate([
                symbolTextField.topAnchor.constraint(equalTo: mockLabel.bottomAnchor, constant: 10),
                symbolTextField.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
                symbolTextField.rightAnchor.constraint(equalTo: valueTextField.leftAnchor, constant: -12),
                symbolTextField.widthAnchor.constraint(equalToConstant: 68),
                symbolTextField.heightAnchor.constraint(equalToConstant: 40)
            ])
            
            NSLayoutConstraint.activate([
                valueTextField.topAnchor.constraint(equalTo: mockLabel.bottomAnchor, constant: 10),
                valueTextField.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20),
                valueTextField.heightAnchor.constraint(equalToConstant: 40)
            ])
        default:
            NSLayoutConstraint.activate([
                mockLabel.topAnchor.constraint(equalTo: self.topAnchor),
                mockLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.4),
                mockLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20)
            ])
            
            self.addSubview(textField)
            NSLayoutConstraint.activate([
                textField.topAnchor.constraint(equalTo: mockLabel.bottomAnchor, constant: 10),
                textField.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
                textField.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20),
                textField.heightAnchor.constraint(equalToConstant: 40)
            ])
        } 
    }
}

extension InputCell: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView( _ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return myPickerData.count
    }
    
    func pickerView( _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return myPickerData[row]
    }
    
    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        symbolTextField.text = myPickerData[row]
    }
}
