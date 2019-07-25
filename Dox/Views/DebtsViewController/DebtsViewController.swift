//
//  DebtsViewController.swift
//  Dox
//
//  Created by Bia Plutarco on 21/05/19.
//  Copyright © 2019 Bia Plutarco. All rights reserved.
//

import UIKit

class DebtsViewController: UIViewController, LabelLayoutProtocol {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    var isToPay = false
    
//    Label
    lazy var largeTitle: UILabel = {
        let title = NSLocalizedString("Debts", comment: "Debts")
        let label = createLargeTitleLabel(text: title, andTextColor: UIColor.AppColors.white)
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        return label
    }()
    
    lazy var empytLabel: UILabel = {
        let title = NSLocalizedString("Empyt Label", comment: "Empyt Label")
        let label = createEmpytLabel(text: title, andTextColor: UIColor.AppColors.gray)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
//    Button
    lazy var headerButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "addButton"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        return button
    }()
    
    lazy var editButton: UIButton = {
        let button = UIButton()
        button.setTitle(NSLocalizedString("Edit", comment: "Edit"), for: .normal)
        button.setTitleColor(UIColor.AppColors.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        return button
    }()
//    SegmentedControl
    lazy var segmentedTitles: [String] = {
        let toReceiveTitle = NSLocalizedString("To receive", comment: "To receive")
        let toPayTitle = NSLocalizedString("To pay", comment: "To pay")
        let segmentedTitles = [toReceiveTitle, toPayTitle]
        return segmentedTitles
    }()
    
    lazy var segmentedControl: LineSegmentedControl = {
        let segmentedControl = LineSegmentedControl(width: view.frame.width * 0.6,
                                                    titles: segmentedTitles, mulplierLineWidth: 3,
                                                    selectedColor: UIColor.AppColors.white,
                                                    unselectedColor: UIColor.AppColors.gray)
        segmentedControl.delegate = self
        view.addSubview(segmentedControl)
        return segmentedControl
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
    
//    Data
    lazy var dataToReceive: [Debt] = {
        let dataToReceive: [Debt] = CoreDataManager.sharedManager.getDebtsFrom(type: .toReceive)
        return dataToReceive
    }()
    
    lazy var dataToPay: [Debt] = {
        let dataToReceive: [Debt] = CoreDataManager.sharedManager.getDebtsFrom(type: .toPay)
        return dataToReceive
    }()
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: CGRect.zero,
                                              collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        return collectionView
    }()
    
//    Life circle method
    override func viewWillAppear(_ animated: Bool) {
        addEmpytLabel()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.AppColors.debtsBackgroundColor
        collectionView.register(DebtCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        
        editButton.addTarget(self, action: #selector(editTapped(_:)), for: .touchUpInside)
        headerButton.addTarget(self, action: #selector(goToNextVC(_:)), for: .touchUpInside)
        configConstraints()
    }
//    Action
    @objc func deleteItems(_ sender: UIButton) {
        guard let selectedCells = collectionView.indexPathsForSelectedItems else { return }
        let items = selectedCells.map { $0.item }.sorted().reversed()
        
        editButton.setTitle(NSLocalizedString("Edit", comment: "Edit"), for: .normal)
        headerButton.removeTarget(self, action: #selector(deleteItems(_:)), for: .touchUpInside)
        headerButton.addTarget(self, action: #selector(goToNextVC(_:)), for: .touchUpInside)
        headerButton.setImage(#imageLiteral(resourceName: "addButton"), for: .normal)
        isEditing = false
        
        for item in items {
            if self.isToPay == true {
                CoreDataManager.sharedManager.deleteDebt(dataToPay[item])
                dataToPay = CoreDataManager.sharedManager.getDebtsFrom(type: .toPay)
                collectionView.deleteItems(at: selectedCells)
                collectionView.reloadSections(IndexSet(IndexPath(row: 0, section: 0)))
            } else {
                CoreDataManager.sharedManager.deleteDebt(dataToReceive[item])
                dataToReceive = CoreDataManager.sharedManager.getDebtsFrom(type: .toReceive)
                collectionView.deleteItems(at: selectedCells)
                collectionView.reloadSections(IndexSet(IndexPath(row: 0, section: 0)))
                
            }
        }
    }
    
    @objc func goToNextVC(_ sender: UIButton) {
        let nextVC = NewDebtViewController()
        nextVC.delegate = self
        nextVC.transitioningDelegate = self
        nextVC.modalPresentationStyle = .custom
        present(nextVC, animated: true, completion: nil)
    }
    
    @objc func editTapped(_ sender: UIButton) {
        isEditing.toggle()
        
        if isEditing == true {
            editButton.setTitle(NSLocalizedString("Cancel", comment: "Cancel"), for: .normal)
            headerButton.setImage(#imageLiteral(resourceName: "trash"), for: .normal)
            headerButton.isEnabled = false
            headerButton.removeTarget(self, action: #selector(goToNextVC(_:)), for: .touchUpInside)
            headerButton.addTarget(self, action: #selector(deleteItems(_:)), for: .touchUpInside)
            
        } else {
            editButton.setTitle(NSLocalizedString("Edit", comment: "Edit"), for: .normal)
            headerButton.setImage(#imageLiteral(resourceName: "addButton"), for: .normal)
            headerButton.isEnabled = true
            headerButton.removeTarget(self, action: #selector(deleteItems(_:)), for: .touchUpInside)
            headerButton.addTarget(self, action: #selector(goToNextVC(_:)), for: .touchUpInside)
            
        }
    }
    
    private func addEmpytLabel() {
        if (dataToPay.isEmpty && dataToReceive.isEmpty) {
            view.addSubview(empytLabel)
            configEmpytLabelConstraints()
        } else {
            view.willRemoveSubview(empytLabel)
            empytLabel.removeFromSuperview()
            view.layoutIfNeeded()
            view.layoutSubviews()
        }
    }
}
//Constraints
extension DebtsViewController: HeaderConstraintsProtocol {
    private func configConstraints() {
        configHeaderConstraints(largeTitle: largeTitle, segmentedControl: segmentedControl,
                                button: headerButton, at: view)
        
        NSLayoutConstraint.activate([
            editButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 42),
            editButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
            ])
        
        NSLayoutConstraint.activate([
            collectionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            collectionView.widthAnchor.constraint(equalTo: view.widthAnchor),
            collectionView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 24)
        ])
    }
    
    private func configEmpytLabelConstraints() {
        NSLayoutConstraint.activate([
            empytLabel.widthAnchor.constraint(equalToConstant: 300),
            empytLabel.heightAnchor.constraint(equalToConstant: 400),
            empytLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            empytLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])
    }
}
//TableViewDelegate
extension DebtsViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isToPay == false {
            return dataToReceive.count
        } else {
            return dataToPay.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? DebtCollectionViewCell
            else { return UICollectionViewCell() }
        if isToPay == true {
            cell.setUp(withDebt: dataToPay[indexPath.row])
            return cell
        } else {
            cell.setUp(withDebt: dataToReceive[indexPath.row])
            return cell
        }
        
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        
        collectionView.allowsMultipleSelection = editing
        let indexPaths = collectionView.indexPathsForVisibleItems
        for indexPath in indexPaths {
            let cell = collectionView.cellForItem(at: indexPath) as! DebtCollectionViewCell
            cell.isInEditingMode = editing
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        headerButton.isEnabled = true
        collectionView.cellForItem(at: indexPath)?.isSelected = true
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        collectionView.cellForItem(at: indexPath)?.isSelected = false
        if let selectedItems = collectionView.indexPathsForSelectedItems, selectedItems.count == 0 {
            headerButton.isEnabled = false
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.width - 40), height: (view.frame.width - 40)/5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
}
//SegmentedControlDelegate
extension DebtsViewController: LineSegmentedControlDelegate {
    func didChangeTo(index: Int) {
        switch index {
        case 0:
            isToPay = false
            collectionView.reloadSections(IndexSet(IndexPath(row: 0, section: 0)))
        default:
            isToPay = true
            collectionView.reloadSections(IndexSet(IndexPath(row: 0, section: 0)))
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
            collectionView.reloadSections(IndexSet(IndexPath(row: 0, section: 0)))
            didChangeTo(index: 0)
            segmentedControl.selectedButtonAt(index: 0)
            addEmpytLabel()
        } else {
            dataToPay = CoreDataManager.sharedManager.getDebtsFrom(type: .toPay)
            collectionView.reloadSections(IndexSet(IndexPath(row: 0, section: 0)))
            didChangeTo(index: 1)
            segmentedControl.selectedButtonAt(index: 1)
            addEmpytLabel()
        }
    }
}
