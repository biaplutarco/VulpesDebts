//
//  NewDebtViewController.swift
//  Dox
//
//  Created by Bia Plutarco on 26/05/19.
//  Copyright © 2019 Bia Plutarco. All rights reserved.
//

import UIKit

class NewDebtViewController: UIViewController {
//    Label
    lazy var largeTitle: MockLabel = {
        let title = NSLocalizedString("New Debt", comment: "New Debt")
        let label = MockLabel(text: title, type: .darkLargeTitle)
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
    lazy var headerButton: CircularButton = {
        let headerButton = CircularButton(image: #imageLiteral(resourceName: "exitButton"), type: .exit)
        view.addSubview(headerButton)
        return headerButton
    }()
    
    lazy var footerButton: RectangularButton = {
        let footerButton = RectangularButton(title: "Save")
        view.addSubview(footerButton)
        return footerButton
    }()
//    SegmentedControll
    lazy var segmentedTitles: [String] = {
        let toReceiveTitle = NSLocalizedString("To receive", comment: "To receive")
        let toPayTitle = NSLocalizedString("To pay", comment: "To pay")
        let segmentedTitles = [toReceiveTitle, toPayTitle]
        return segmentedTitles
    }()
    
    lazy var segmentedControl: LineSegmentedControl = {
        let segmentedControl = LineSegmentedControl(
            width: view.frame.width * 0.6,
            titles: segmentedTitles, mulplierLineWidth: 3,
            selectedColor: UIColor.AppColors.darkGray, unselectedColor: UIColor.AppColors.grayLowOpacity
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
        headerButton.addTarget(self, action: #selector(exitTapped(_:)), for: .touchUpInside)
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
        configHeaderConstraints(largeTitle: largeTitle, segmentedControl: segmentedControl,
                                button: headerButton, at: view)
        
        NSLayoutConstraint.activate([
            tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tableView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 26),
            tableView.bottomAnchor.constraint(equalTo: footerButton.topAnchor, constant: -24),
            tableView.widthAnchor.constraint(equalTo: view.widthAnchor)
            ])
        
        NSLayoutConstraint.activate([
            footerButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -44),
            footerButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            footerButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            footerButton.heightAnchor.constraint(equalToConstant: 44)
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
