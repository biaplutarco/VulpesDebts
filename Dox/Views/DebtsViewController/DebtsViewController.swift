//
//  DebtsViewController.swift
//  Dox
//
//  Created by Bia Plutarco on 21/05/19.
//  Copyright © 2019 Bia Plutarco. All rights reserved.
//

import UIKit

class DebtsViewController: UIViewController {
//    Label
    lazy var largeTitle: MockLabel = {
        let title = NSLocalizedString("Debts", comment: "Debts")
        let label = MockLabel(text: title, type: .largeTitle)
        view.addSubview(label)
        return label
    }()
//    Button
    lazy var headerButton: CircularButton = {
        let addButton = CircularButton(image: #imageLiteral(resourceName: "addButton"), type: .add)
        view.addSubview(addButton)
        return addButton
    }()
//    SegmentedControl
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
            selectedColor: UIColor.AppColors.lightGray, unselectedColor: UIColor.AppColors.gray
        )
        segmentedControl.delegate = self
        view.addSubview(segmentedControl)
        return segmentedControl
    }()
    
    lazy var isToPay: Bool = {
        let isToPay = false
        return isToPay
    }()
//    CustomTransition
    lazy var transition: CircularTransition = {
        let size = view.frame.height
        let startingPoint = headerButton.center
        let center = view.center
        let transition = CircularTransition(
            size: size, startingPoint: startingPoint, viewCenter: center, duration: 0.6
        )
        return transition
    }()
//    TableView
    lazy var dataToReceive: [Debt] = {
        let dataToReceive: [Debt] = CoreDataManager.sharedManager.getDebtsFrom(type: .toReceive)
        return dataToReceive
    }()
    
    lazy var dataToPay: [Debt] = {
        let dataToReceive: [Debt] = CoreDataManager.sharedManager.getDebtsFrom(type: .toPay)
        return dataToReceive
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
//    Life circle method
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.AppColors.darkGray
        tableView.register(DebtCell.self, forCellReuseIdentifier: "cell")
        headerButton.addTarget(self, action: #selector(headerButtonTapped(_:)), for: .touchUpInside)
        configConstraints()
    }
//    Action
    @objc func headerButtonTapped(_ sender: UIButton) {
        let nextVC = NewDebtViewController()
        nextVC.delegate = self
        nextVC.transitioningDelegate = self
        nextVC.modalPresentationStyle = .custom
        present(nextVC, animated: true, completion: nil)
    }
}
//Constraints
extension DebtsViewController: HeaderConstraintsProtocol {
    private func configConstraints() {
        configHeaderConstraints(largeTitle: largeTitle, segmentedControl: segmentedControl,
                                button: headerButton, at: view)
        
        NSLayoutConstraint.activate([
            tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.widthAnchor.constraint(equalTo: view.widthAnchor),
            tableView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 24)
        ])
    }
}
//TableViewDelegate
extension DebtsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isToPay == false {
            return dataToReceive.count
        } else {
            return dataToPay.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? DebtCell
            else { return UITableViewCell() }
        if isToPay == false {
            cell.configCellWith(debt: dataToReceive[indexPath.row], andTextColor: UIColor.AppColors.lightGray)
            return cell
        } else {
            cell.configCellWith(debt: dataToPay[indexPath.row], andTextColor: UIColor.AppColors.lightGray)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 128
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath)
        -> UISwipeActionsConfiguration? {
        let title = NSLocalizedString("Paid", comment: "Paid")
        let paidAction = UIContextualAction(style: .normal, title: title) { (_, _, _) in
            if self.isToPay == false {
                CoreDataManager.sharedManager.deleteDebt(self.dataToReceive[indexPath.row])
                self.dataToReceive.remove(at: indexPath.row)
                tableView.reloadSections(IndexSet(indexPath), with: .automatic)
            } else {
                CoreDataManager.sharedManager.deleteDebt(self.dataToPay[indexPath.row])
                self.dataToPay.remove(at: indexPath.row)
                tableView.reloadSections(IndexSet(indexPath), with: .automatic)
            }
        }
        paidAction.backgroundColor = UIColor.AppColors.darkGray
        paidAction.image = #imageLiteral(resourceName: "paid")
            
        let swipeAction = UISwipeActionsConfiguration(actions: [paidAction])
        swipeAction.performsFirstActionWithFullSwipe = true
        return swipeAction
    }
}
//SegmentedControlDelegate
extension DebtsViewController: LineSegmentedControlDelegate {
    func didChangeTo(index: Int) {
        switch index {
        case 0:
            isToPay = false
            tableView.reloadSections(IndexSet(IndexPath(row: 0, section: 0)), with: .automatic)
        default:
            isToPay = true
            tableView.reloadSections(IndexSet(IndexPath(row: 0, section: 0)), with: .automatic)
        }
    }
}
//Transitioning Delegate
extension DebtsViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController,
                             source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionType = .present
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionType = .dismiss
        return transition
    }
}
//NewDebtViewControllerDelegate
extension DebtsViewController: NewDebtViewControllerDelegate {
    func addNew(debt: Debt) {
        if debt.type == 0 {
            dataToReceive = CoreDataManager.sharedManager.getDebtsFrom(type: .toReceive)
            tableView.reloadSections(IndexSet(IndexPath(row: 0, section: 0)), with: .automatic)
        } else {
            dataToPay = CoreDataManager.sharedManager.getDebtsFrom(type: .toPay)
            tableView.reloadSections(IndexSet(IndexPath(row: 0, section: 0)), with: .automatic)
        }
    }
}
