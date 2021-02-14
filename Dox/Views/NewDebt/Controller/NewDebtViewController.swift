//
//  NewDebtViewController.swift
//  Dox
//
//  Created by Bia Plutarco on 26/05/19.
//  Copyright © 2019 Bia Plutarco. All rights reserved.
//

import UIKit

// MARK: Delegate

protocol NewDebtViewControllerDelegate: class {
    func addNew(debt: Debt)
}

// MARK: Class

class NewDebtViewController: UIViewController {

    private lazy var newDebView: NewDebtView = {
        let view = NewDebtView(viewModel: NewDebtViewModel(), frame: self.view.frame)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        view.setupView()
        
        return view
    }()
    
    weak var delegate: NewDebtViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        buildHierarchy()
        configConstraints()
    }
    
    private func buildHierarchy() {
        view.addSubview(newDebView)
    }
    
    private func configConstraints() {
        NSLayoutConstraint.activate([
            newDebView.topAnchor.constraint(equalTo: view.bottomAnchor),
            newDebView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            newDebView.rightAnchor.constraint(equalTo: view.rightAnchor),
            newDebView.leftAnchor.constraint(equalTo: view.leftAnchor)
        ])
    }
}

// MARK: NewDebtView Delegate

extension NewDebtViewController: NewDebtViewDelegate {
    func dismiss() {
        dismiss(animated: true, completion: nil)
    }
    
    func save(newDebt: Debt) {
        dismiss(animated: true) {
            self.delegate?.addNew(debt: newDebt)
        }
    }
}
