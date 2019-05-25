//
//  DebtsViewController.swift
//  Dox
//
//  Created by Bia Plutarco on 21/05/19.
//  Copyright © 2019 Bia Plutarco. All rights reserved.
//

import UIKit

class DebtsViewController: UIViewController {
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
    
    var tableViewItems: [String] = ["Aaaa", "Bbbbb", "Cccc"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.AppColors.darkGray
        tableView.register(DebtCell.self, forCellReuseIdentifier: "cell")
        
        NSLayoutConstraint.activate([
            tableView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.7),
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
