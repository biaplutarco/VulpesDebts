//
//  DebtsViewController.swift
//  Dox
//
//  Created by Bia Plutarco on 21/05/19.
//  Copyright © 2019 Bia Plutarco. All rights reserved.
//

import UIKit

class DebtsViewController: UIViewController {
    lazy var titleLablel: MockLabel = {
        let label = MockLabel(text: .debts, type: .title)
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        return label
    }()
    
    lazy var addButton: CircleButton = {
        let addButton = CircleButton(image: #imageLiteral(resourceName: "addButton"), type: .add)
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.layer.cornerRadius = 20
        view.addSubview(addButton)
        return addButton
    }()
    
    lazy var segmentedWidth: CGFloat = {
        let segmentedWidth = view.frame.width*0.60
        return segmentedWidth
    }()
    
    lazy var segmentedControl: OneLineSC = {
        let segControl = OneLineSC(titles: self.titles, selectorMultiple: 3, segmentedWidth: self.segmentedWidth,
                                   selectedColor: UIColor.AppColors.lightGray,
                                   unselectedColor: UIColor.AppColors.gray)
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
    
    lazy var transition: CustomTransition = {
        let size = self.view.frame.height
        let startingPoint = self.addButton.center
        let center = self.view.center
        let transition = CustomTransition(size: size, startingPoint: startingPoint, viewCenter: center, duration: 0.6)
        return transition
    }()
    
    lazy var titles: [String] = {
        let titles = ["To receive", "To pay"]
        return titles
    }()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    var names: [String] = []
    var reasons: [String] = []
    var values: [String] = []
    var debtType: DebtType = .toReceive
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.AppColors.darkGray
        
        tableView.register(DebtCell.self, forCellReuseIdentifier: "cell")
        addButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        configConstraints()
    }
    
    @objc func buttonTapped(_ sender: UIButton) {
        let nextVC = NewDebtViewController()
        nextVC.transitioningDelegate = self
        nextVC.modalPresentationStyle = .custom
        nextVC.delegate = self
        present(nextVC, animated: true, completion: nil)
    }
    
    private func configConstraints() {
        NSLayoutConstraint.activate([
            titleLablel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            titleLablel.topAnchor.constraint(equalTo: view.topAnchor, constant: 58),
            titleLablel.bottomAnchor.constraint(equalTo: segmentedControl.topAnchor, constant: -24),
            titleLablel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4)
        ])
        
        NSLayoutConstraint.activate([
            addButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            addButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 40),
            addButton.heightAnchor.constraint(equalToConstant: 42),
            addButton.widthAnchor.constraint(equalToConstant: 42)
        ])
        
        NSLayoutConstraint.activate([
            segmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            segmentedControl.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.60),
            segmentedControl.bottomAnchor.constraint(equalTo: tableView.topAnchor, constant: -24),
            segmentedControl.heightAnchor.constraint(equalToConstant: 32)
        ])
        
        NSLayoutConstraint.activate([
            tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
    }
}
//TableView Delegate
extension DebtsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? DebtCell
            else { return UITableViewCell() }
        
        cell.setupCell(name: names[indexPath.row], reason: reasons[indexPath.row], value: values[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 128
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let title = NSLocalizedString("Paid", comment: "Paid")
        let paid = UIContextualAction(style: .destructive, title: title) { (_, _, _) in
            self.tableView.deleteRows(at: [indexPath], with: .fade)
        }
        paid.backgroundColor = UIColor.AppColors.darkGray
        paid.image = #imageLiteral(resourceName: "paid")
        let swipeAction = UISwipeActionsConfiguration(actions: [paid])
        swipeAction.performsFirstActionWithFullSwipe = true
        return swipeAction
    }
}
//SegmentedControl Delegate
extension DebtsViewController: OneLineSGDelegate {
    func didChangeTo(index: Int) {
        switch index {
        case 0:
            print("a")
        default:
            print("b")
        }
    }
}
//Transitioning Delegate + Button Delegate
extension DebtsViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController,
                             source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .present
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .dismiss
        return transition
    }
}

extension DebtsViewController: NewDebtVCDelegate {
    func didFinishAdd() {
        tableView.beginUpdates()
        tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
        tableView.endUpdates()
    }
    
    func addNewDebt(name: String, reason: String, value: String, at: DebtType) {
        names.insert(name, at: 0)
        reasons.insert(reason, at: 0)
        values.insert(value, at: 0)
        print(name, reason, value)
    }
}
