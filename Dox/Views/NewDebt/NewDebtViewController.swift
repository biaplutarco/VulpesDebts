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
    case error
}

class NewDebtViewController: UIViewController {
    lazy var titleLablel: MockLabel = {
        let label = MockLabel(text: .newDebt, type: .darkLargeTitle)
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
    
    lazy var segmetendTitles: [String] = {
        let segmetendTitles = ["To receive", "To pay"]
        return segmetendTitles
    }()
    
    lazy var segmentedControl: LineSegmentedControl = {
        let segmentedControl = LineSegmentedControl(
            width: view.frame.width * 0.6,
            titles: segmetendTitles, mulplierLineWidth: 3,
            selectedColor: UIColor.AppColors.darkGray, unselectedColor: UIColor.AppColors.grayLowOpacity
        )
        segmentedControl.delegate = self
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(segmentedControl)
        return segmentedControl
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
    
    weak var delegate: NewDebtViewControllerDelegate?
    
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
    
    lazy var debtType: DebtType = {
        let debtType: DebtType = .toReceive
        return debtType
    }()
    
    var nameCell: InputNewDebtCell?
    var reasonCell: InputNewDebtCell?
    var valueCell: ValueDebtCell?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.AppColors.orange
        tableView.register(InputNewDebtCell.self, forCellReuseIdentifier: "cell")
        tableView.register(ValueDebtCell.self, forCellReuseIdentifier: "valueCell")
//        Add action to buttons
        exitButton.addTarget(self, action: #selector(exitTapped(_:)), for: .touchUpInside)
        saveButton.addTarget(self, action: #selector(saveTapped(_:)), for: .touchUpInside)
//        Methods
        addObservers()
        configConstraints()
        hideKeyboardWhenTappedAround()
    }
//    Actions
    @objc func exitTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func saveTapped(_ sender: UIButton) {
        getTextFromTextFields()
        let finalValue = "\(symbol)\(self.value)"
        let debt = CoreDataManager.sharedManager.createDebt(name: name,
                                                            reason: reason, value: finalValue, type: debtType)
        dismiss(animated: true) {
            self.delegate?.addNew(debt: debt)
        }
    }
    
    private func getTextFromTextFields() {
        guard let nameCell = nameCell,
              let reasonCell = reasonCell,
              let valueCell = valueCell else { return }
        
        name = nameCell.getTextFieldInputText()
        reason = reasonCell.getTextFieldInputText()
        value = valueCell.getValueTextFieldInputText()
        symbol = valueCell.getSymbolTextFieldInputText()
    }
}
//Constraints
extension NewDebtViewController {
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
//TableViewDelagate
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
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? InputNewDebtCell
                else { return UITableViewCell() }
            reasonCell = cell
            cell.configCellWith(title: mockLabelTitles[indexPath.row], to: self)
            
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? InputNewDebtCell
                else { return UITableViewCell() }
            nameCell = cell
            cell.configCellWith(title: mockLabelTitles[indexPath.row], to: self)
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 96
    }
}
//SegmentedControlDelegate
extension NewDebtViewController: LineSegmentedControlDelegate {
    func didChangeTo(index: Int) {
        switch index {
        case 0:
            debtType = .toReceive
        default:
            debtType = .toPay
        }
    }
}
//TextFieldDelegate
extension NewDebtViewController: UITextFieldDelegate {
//    Method called when the user click on Return button on keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
//    Add observers to notificated when keyboard will show + hide
    private func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
    }
//    Show keyboard + push to up texfield
    @objc func keyboardWillShow(notification: NSNotification) {
        var userInfo = notification.userInfo!
        var keyboardFrame: CGRect = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as AnyObject).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)
        
        var contentInset: UIEdgeInsets = self.tableView.contentInset
        contentInset.bottom = keyboardFrame.size.height
        tableView.contentInset = contentInset
    }
//    Hide keydoard + push to down textfield
    @objc func keyboardWillHide(notification: NSNotification) {
        let contentInset: UIEdgeInsets = UIEdgeInsets.zero
        tableView.contentInset = contentInset
    }
//    Hide keyboard when touch up outside
    private func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
//    Dismiss keyboard methods
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
