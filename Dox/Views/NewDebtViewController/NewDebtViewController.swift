//
//  NewDebtViewController.swift
//  Dox
//
//  Created by Bia Plutarco on 26/05/19.
//  Copyright © 2019 Bia Plutarco. All rights reserved.
//

import UIKit

class NewDebtViewController: UIViewController, LabelLayoutProtocol, ButtonProtocol {
//    Label
    lazy var largeTitle: UILabel = {
        let title = NSLocalizedString("New Debt", comment: "New Debt")
        let label = createLargeTitleLabel(text: title, andTextColor: UIColor.AppColors.black)
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        return label
    }()
    
    lazy var labelsTitles: [String] = {
        let labelsTitles: [String] = [NSLocalizedString("Name", comment: "Name"),
                                         NSLocalizedString("Reason", comment: "Reason"),
                                         NSLocalizedString("Value", comment: "Value")]
        return labelsTitles
    }()

//    Button
    lazy var leftButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "exitButton"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        return button
    }()
    
    lazy var footerButton: UIButton = {
        let title = NSLocalizedString("Save", comment: "Save")
        let button = createRectangularButton(text: title)
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        return button
    }()
//    SegmentedControll
    lazy var titles: [String] = {
        let titles = [NSLocalizedString("To receive", comment: "To receive"),
                      NSLocalizedString("To pay", comment: "To pay")]
        return titles
    }()
    
    lazy var lineStackView: LineStackView = {
        let segmentedControl = LineStackView(
            width: view.frame.width * 0.6,
            titles: titles, mulplierLineWidth: 3,
            selectedColor: UIColor.AppColors.black, unselectedColor: UIColor.AppColors.darkGray
        )
        segmentedControl.delegate = self
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
        leftButton.addTarget(self, action: #selector(exitTapped(_:)), for: .touchUpInside)
        footerButton.addTarget(self, action: #selector(saveTapped(_:)), for: .touchUpInside)
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
extension NewDebtViewController: HeaderConstraintsProtocol {
    private func configConstraints() {
        configHeaderConstraints(title: largeTitle, segControl: lineStackView,
                                leftButton: leftButton, at: view)
        
        NSLayoutConstraint.activate([
            tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tableView.topAnchor.constraint(equalTo: lineStackView.bottomAnchor, constant: 20),
            tableView.bottomAnchor.constraint(equalTo: footerButton.topAnchor),
            tableView.widthAnchor.constraint(equalTo: view.widthAnchor)
            ])
        
        NSLayoutConstraint.activate([
            footerButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40),
            footerButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            footerButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            footerButton.heightAnchor.constraint(equalToConstant: 40)
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
        cell.configCellWith(title: labelsTitles[index], andType: inputCellTypes[index], to: self)
        inputCells.append(cell)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 96
    }
}
//SegmentedControlDelegate
extension NewDebtViewController: LineStackViewDelegate {
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
