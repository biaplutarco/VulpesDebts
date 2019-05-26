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
        let addButton = CircleButton(image: #imageLiteral(resourceName: "add+exit"), type: .add)
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.layer.cornerRadius = 20
        view.addSubview(addButton)
        return addButton
    }()
    
    lazy var segmentedWidth: CGFloat = {
        let segmentedWidth = view.frame.width*0.54
        return segmentedWidth
    }()
    
    lazy var segmentedControl: OneLineSC = {
        let segControl = OneLineSC(titles: self.titles, selectorMultiple: 3, segmentedWidth: self.segmentedWidth)
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
    
    var titles = ["to recieve", "to pay"]
    var tableViewItems: [String] = ["Aaaa", "Bbbbb", "Cccc"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.AppColors.darkGray
        tableView.register(DebtCell.self, forCellReuseIdentifier: "cell")
        
        configConstraints()
    }
    
    private func configConstraints() {
        NSLayoutConstraint.activate([
            titleLablel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            titleLablel.topAnchor.constraint(equalTo: view.topAnchor, constant: 48),
            titleLablel.bottomAnchor.constraint(equalTo: segmentedControl.topAnchor, constant: -24),
            titleLablel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4)
            ])
        
        NSLayoutConstraint.activate([
            addButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            addButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 28),
            addButton.heightAnchor.constraint(equalToConstant: 40),
            addButton.widthAnchor.constraint(equalToConstant: 40)
        ])
        
        NSLayoutConstraint.activate([
            segmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            segmentedControl.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.54),
            segmentedControl.bottomAnchor.constraint(equalTo: tableView.topAnchor, constant: -16),
            segmentedControl.heightAnchor.constraint(equalToConstant: 32)
            ])
        
        NSLayoutConstraint.activate([
            tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
    }
}

extension DebtsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? DebtCell
            else { return UITableViewCell() }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 128
    }
}

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
