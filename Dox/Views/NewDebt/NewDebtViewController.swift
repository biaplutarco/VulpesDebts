//
//  NewDebtViewController.swift
//  Dox
//
//  Created by Bia Plutarco on 26/05/19.
//  Copyright © 2019 Bia Plutarco. All rights reserved.
//

import UIKit

enum DebtType: Int {
    case toReceive = 0
    case toPay = 1
}

class NewDebtViewController: UIViewController {
    lazy var titleLablel: MockLabel = {
        let label = MockLabel(text: .newDebt, type: .titleDark)
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        return label
    }()
    
    lazy var exitButton: CircleButton = {
        let exitButton = CircleButton(image: #imageLiteral(resourceName: "exitButton"), type: .exit)
        exitButton.translatesAutoresizingMaskIntoConstraints = false
        exitButton.layer.cornerRadius = 20
        exitButton.isUserInteractionEnabled = true
        view.addSubview(exitButton)
        return exitButton
    }()
    
    lazy var titles: [String] = {
        let titles = ["To receive", "To pay"]
        return titles
    }()
    
    lazy var segmentedWidth: CGFloat = {
        let segmentedWidth = view.frame.width*0.60
        return segmentedWidth
    }()
    
    lazy var segmentedControl: OneLineSC = {
        let segControl = OneLineSC(titles: self.titles, selectorMultiple: 3, segmentedWidth: self.segmentedWidth,
                                   selectedColor: UIColor.AppColors.darkGray,
                                   unselectedColor: UIColor.AppColors.grayLowOpacity)
        segControl.delegate = self
        segControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(segControl)
        return segControl
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        return tableView
    }()
    
    lazy var saveButton: RectangleButton = {
        let saveButton = RectangleButton(title: "Save")
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.setTitleColor(UIColor.AppColors.lightGray, for: .normal)
        saveButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        view.addSubview(saveButton)
        return saveButton
    }()
    
    lazy var mockLabelTitles: [MockLabelText] = {
        let mockLabelTitles: [MockLabelText] = [.name, .reason, .value]
        return mockLabelTitles
    }()
    
    weak var delegate: NewDebtVCDelegate?
    
    lazy var name: String = {
        let name = NSLocalizedString("Name", comment: "Name")
        return name
    }()
    
    lazy var reason: String = {
        let reason = NSLocalizedString("Reason", comment: "Reason")
        return reason
    }()
    
    lazy var symbol: String = {
        let symbol = NSLocalizedString("Symbol", comment: "Symbol")
        return symbol
    }()
    
    lazy var value: String = {
        let value = NSLocalizedString("Value", comment: "Value")
        return value
    }()
    
    var nameCell: NewDebtCell?
    var reasonCell: NewDebtCell?
    var valueCell: ValueDebtCell?
    var debtType: DebtType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.AppColors.orange
        
        tableView.register(NewDebtCell.self, forCellReuseIdentifier: "cell")
        tableView.register(ValueDebtCell.self, forCellReuseIdentifier: "valueCell")
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
        
        exitButton.addTarget(self, action: #selector(exitTapped(_:)), for: .touchUpInside)
        saveButton.addTarget(self, action: #selector(saveTapped(_:)), for: .touchUpInside)
        
        configConstraints()
        hideKeyboardWhenTappedAround()
    }
    
    @objc func exitTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func saveTapped(_ sender: UIButton) {
        getTextFromTextFields()
//        guard let debtType = debtType else { return }
        let finalValue = "\(symbol)\(self.value)"
        self.delegate?.addNewDebt(name: self.name, reason: self.reason, value: finalValue, type: .toReceive)
        dismiss(animated: true) {
            self.delegate?.didFinishAdd()
        }
    }
    
    private func getTextFromTextFields() {
        guard let nameCell = nameCell,
              let reasonCell = reasonCell,
              let valueCell = valueCell else { return }
        
        name = nameCell.inputText()
        reason = reasonCell.inputText()
        value = valueCell.inputValueText()
        symbol = valueCell.inputSymbolText()
    }
    
    private func configConstraints() {
        NSLayoutConstraint.activate([
            exitButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            exitButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 40),
            exitButton.heightAnchor.constraint(equalToConstant: 42),
            exitButton.widthAnchor.constraint(equalToConstant: 42)
        ])
    
        NSLayoutConstraint.activate([
            titleLablel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            titleLablel.topAnchor.constraint(equalTo: view.topAnchor, constant: 58),
            titleLablel.bottomAnchor.constraint(equalTo: segmentedControl.topAnchor, constant: -24),
            titleLablel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8)
        ])
        
        NSLayoutConstraint.activate([
            segmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            segmentedControl.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.60),
            segmentedControl.bottomAnchor.constraint(equalTo: tableView.topAnchor, constant: -26),
            segmentedControl.heightAnchor.constraint(equalToConstant: 32)
        ])
        
        NSLayoutConstraint.activate([
            tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tableView.bottomAnchor.constraint(equalTo: saveButton.topAnchor, constant: -24),
            tableView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
            saveButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -44),
            saveButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            saveButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            saveButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
}

extension NewDebtViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mockLabelTitles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 2 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "valueCell", for: indexPath) as?
                ValueDebtCell else { return UITableViewCell() }
            valueCell = cell
            cell.setupCell(title: mockLabelTitles[indexPath.row], for: self)
            
            return cell
        } else if indexPath.row == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? NewDebtCell
                else { return UITableViewCell() }
            reasonCell = cell
            cell.setupCell(title: mockLabelTitles[indexPath.row], for: self)
            
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? NewDebtCell
                else { return UITableViewCell() }
            nameCell = cell
            cell.setupCell(title: mockLabelTitles[indexPath.row], for: self)
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 96
    }
}

extension NewDebtViewController: OneLineSGDelegate {
    func didChangeTo(index: Int) {
        switch index {
        case 0:
            debtType = .toReceive
        default:
            debtType = .toPay
        }
    }
}

extension NewDebtViewController: UITextFieldDelegate {
    private func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        var userInfo = notification.userInfo!
        var keyboardFrame: CGRect = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as AnyObject).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)
        
        var contentInset: UIEdgeInsets = self.tableView.contentInset
        contentInset.bottom = keyboardFrame.size.height
        tableView.contentInset = contentInset
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        let contentInset: UIEdgeInsets = UIEdgeInsets.zero
        tableView.contentInset = contentInset
    }
//      Método chamado quando o usuário aperta RETURN no teclado
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // Agora fazemos o text field deixar de ser o first responder
        // Isso faz com que o teclado se esconda
        textField.resignFirstResponder()
        return true
    }
//     Isso faz com que o teclado seja escondido quando vc toca fora dele
    private func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
