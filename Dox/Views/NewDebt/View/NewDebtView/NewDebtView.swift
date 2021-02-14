//
//  NewDebtView.swift
//  Dox
//
//  Created by Bia Plutarco on 14/02/21.
//  Copyright © 2021 Bia Plutarco. All rights reserved.
//

import UIKit

// MARK: Delegate

protocol NewDebtViewDelegate: class {
    func dismiss()
    func save(newDebt: Debt)
}

// MARK: Class

class NewDebtView: UIView, ButtonProtocol  {
    
    // MARK: Constants

    enum Constants: CGFloat {
        case spacing = 20
        case doubleSpacing = 40
    }
    
    // MARK: Private Properties
    
    private let cellIdentifier = "cell"
    private var debtType: DebtType = .none
    private var viewModel: NewDebtViewModel
    
    // MARK: Subviews
    
    private lazy var headerView: HeaderView = {
        let headerView = HeaderView(
            title: viewModel.screenTitle,
            segmentedTitles: viewModel.segmentedTitles
        )
        headerView.delegate = self
        headerView.setupView()
        
        return headerView
    }()
    
    private lazy var footerButton: UIButton = {
        return createRectangularButton(text: viewModel.saveButtonTitle)
    }()

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = viewModel.dataSource
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()

    // MARK: Initializer
    
    weak var delegate: NewDebtViewDelegate?
    
    init(viewModel: NewDebtViewModel, frame: CGRect = .zero) {
        self.viewModel = viewModel
        
        super.init(frame: frame)
        
        self.viewModel.textFieldHelper = NewDebtTextFieldHelper(view: self, tableView: tableView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Methods
    
    func setupView() {
        backgroundColor = UIColor.AppColors.orange

        tableView.register(InputCell.self, forCellReuseIdentifier: cellIdentifier)
        footerButton.addTarget(self, action: #selector(saveTapped(_:)), for: .touchUpInside)
        
        buildHierarchy()
        configConstraints()
    }
    
    // MARK: Actions
    
    @objc func saveTapped(_ sender: UIButton) {    
        delegate?.save(newDebt: viewModel.createNewDebt(ofType: debtType))
    }
}

// MARK: Constraints

extension NewDebtView: HeaderConstraintsProtocol {
    private func buildHierarchy() {
        addSubview(headerView)
        addSubview(tableView)
        addSubview(footerButton)
    }
    
    private func configConstraints() {
        let spacing = Constants.spacing.rawValue
        let doubleSpacing = Constants.doubleSpacing.rawValue
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: topAnchor),
            headerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            tableView.centerXAnchor.constraint(equalTo: centerXAnchor),
            tableView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: spacing),
            tableView.bottomAnchor.constraint(equalTo: footerButton.topAnchor),
            tableView.widthAnchor.constraint(equalTo: widthAnchor),

            footerButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -doubleSpacing),
            footerButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -spacing),
            footerButton.leftAnchor.constraint(equalTo: leftAnchor, constant: spacing),
            footerButton.heightAnchor.constraint(equalToConstant: doubleSpacing)
        ])
    }
}

// MARK: Delegates

//  HeaderView Delegate
extension NewDebtView: HeaderViewDelegate {
    func dismiss() {
        delegate?.dismiss()
    }
    
    func didChangeDebtType(to type: DebtType) {
        debtType = type
    }
}
