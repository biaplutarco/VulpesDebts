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
//    Label
    lazy var largeTitle: MockLabel = {
        let label = MockLabel(text: .newDebt, type: .darkLargeTitle)
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        return label
    }()
    
    lazy var mockLabelTitles: [String] = {
        let mockLabelTitles: [String] = [NSLocalizedString("Name", comment: "Name"),
                                         NSLocalizedString("Reason", comment: "Reason"),
                                         NSLocalizedString("Value", comment: "Value")]
        return mockLabelTitles
    }()

//    Button
    lazy var exitButton: CircleButton = {
        let exitButton = CircleButton(image: #imageLiteral(resourceName: "exitButton"), type: .exit)
        exitButton.translatesAutoresizingMaskIntoConstraints = false
        exitButton.layer.cornerRadius = 20
        exitButton.isUserInteractionEnabled = true
        view.addSubview(exitButton)
        return exitButton
    }()
    
    lazy var saveButton: RectangleButton = {
        let saveButton = RectangleButton(title: "Save")
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.setTitleColor(UIColor.AppColors.lightGray, for: .normal)
        saveButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        view.addSubview(saveButton)
        return saveButton
    }()
//    SegmentedControll
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
//    TableView
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
//    InputCell
    lazy var inputCellTypes: [InputCellType] = {
        let inputCellTypes: [InputCellType] = [.name, .reason, .value]
        return inputCellTypes
    }()
    
    lazy var inputCells: [InputCell] = {
        let inputCells: [InputCell] = []
        return inputCells
    }()
//    DebtType
    lazy var debtType: DebtType = {
        let debtType: DebtType = .toReceive
        return debtType
    }()
//    Delegate
    weak var delegate: NewDebtViewControllerDelegate?
    
//    Life circle method
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.AppColors.orange
        tableView.register(InputCell.self, forCellReuseIdentifier: "cell")
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
        let newDebt = createNewDebt()
        dismiss(animated: true) {
            self.delegate?.addNew(debt: newDebt)
        }
    }
    
    private func createNewDebt() -> Debt {
        let name = inputCells[0].getTextFieldTextFor(cellType: .name)
        let reason = inputCells[1].getTextFieldTextFor(cellType: .reason)
        let value = inputCells[2].getTextFieldTextFor(cellType: .value)
        let newDebt = CoreDataManager.sharedManager.saveDebt(name: name, reason: reason, value: value, type: debtType)
        return newDebt
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
            largeTitle.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            largeTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: 58),
            largeTitle.bottomAnchor.constraint(equalTo: segmentedControl.topAnchor, constant: -24),
            largeTitle.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8)
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
        return inputCellTypes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? InputCell
            else { return UITableViewCell() }
        let index = indexPath.row
        cell.configCellWith(title: mockLabelTitles[index], andType: inputCellTypes[index], to: self)
        inputCells.append(cell)
        return cell
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
