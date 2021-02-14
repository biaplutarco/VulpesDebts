//
//  NewDebtTextFieldHelper.swift
//  Dox
//
//  Created by Bia Plutarco on 14/02/21.
//  Copyright © 2021 Bia Plutarco. All rights reserved.
//

import UIKit

class NewDebtTextFieldHelper {
    
    // MARK: Private Properties

    private var view: UIView
    private var tableView: UITableView
    
    // MARK: Initializer
    
    init(view: UIView, tableView: UITableView) {
        self.view = view
        self.tableView = tableView
    }
    
    // MARK: Methods
    
    //  Method called when the user click on Return button on keyboard
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    //  Add observers to notificated when keyboard will show + hide
    func addObservers() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    //  Show keyboard + push to up texfield
    @objc func keyboardWillShow(notification: NSNotification) {
        let userInfo = notification.userInfo!
        var keyboardFrame: CGRect = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as AnyObject).cgRectValue
        keyboardFrame = view.convert(keyboardFrame, from: nil)
        
        var contentInset = tableView.contentInset
        contentInset.bottom = keyboardFrame.size.height
        
        tableView.contentInset = contentInset
    }
    
    //  Hide keydoard + push to down textfield
    @objc func keyboardWillHide(notification: NSNotification) {
        tableView.contentInset = UIEdgeInsets.zero
    }
    
    //  Hide keyboard when touch up outside
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        
        view.addGestureRecognizer(tap)
    }
    
    //  Dismiss keyboard methods
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
