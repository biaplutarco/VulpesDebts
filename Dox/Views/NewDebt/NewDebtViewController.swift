//
//  NewDebtViewController.swift
//  Dox
//
//  Created by Bia Plutarco on 26/05/19.
//  Copyright © 2019 Bia Plutarco. All rights reserved.
//

import UIKit

class NewDebtViewController: UIViewController {
    lazy var titleLablel: MockLabel = {
        let label = MockLabel(text: .newDebt, type: .titleDark)
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        return label
    }()
    
    lazy var exitButton: CircleButton = {
        let exitButton = CircleButton(image: #imageLiteral(resourceName: "exitButton"), type: .exit)
        exitButton.translatesAutoresizingMaskIntoConstraints = false
        exitButton.layer.cornerRadius = 20
        exitButton.isUserInteractionEnabled = true
        view.addSubview(exitButton)
        return exitButton
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
    
    lazy var saveButton: RectangleButton = {
        let saveButton = RectangleButton(title: "Save")
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(saveButton)
        return saveButton
    }()
    
    lazy var mockLabelTitles: [MockLabelText] = {
        let mockLabelTitles: [MockLabelText] = [.type, .name, .value, .reason]
        return mockLabelTitles
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.AppColors.orange
        
        tableView.register(NewDebtCell.self, forCellReuseIdentifier: "cell")
        exitButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        configConstraints()
    }
    
    @objc func buttonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    private func configConstraints() {
        NSLayoutConstraint.activate([
            exitButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            exitButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 40),
            exitButton.heightAnchor.constraint(equalToConstant: 42),
            exitButton.widthAnchor.constraint(equalToConstant: 42)
        ])
    
        NSLayoutConstraint.activate([
            titleLablel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            titleLablel.topAnchor.constraint(equalTo: view.topAnchor, constant: 58),
            titleLablel.bottomAnchor.constraint(equalTo: tableView.topAnchor, constant: -24),
            titleLablel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8)
        ])
        
        NSLayoutConstraint.activate([
            tableView.bottomAnchor.constraint(equalTo: saveButton.topAnchor, constant: -24),
            tableView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
            saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            saveButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -24),
            saveButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.36)
        ])
    }
}

extension NewDebtViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mockLabelTitles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? NewDebtCell
            else { return UITableViewCell() }
        cell.setupCell(title: mockLabelTitles[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 108
    }
}
