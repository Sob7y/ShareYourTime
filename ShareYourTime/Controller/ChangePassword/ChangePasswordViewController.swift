//
//  ChangePasswordViewController.swift
//  ShareYourTime
//
//  Created by Maha Khaled on 4/26/19.
//  Copyright © 2019 ShareYourTime. All rights reserved.
//

import UIKit

enum TableViewRows: Int {
    case oldPassword = 0
    case newPassword = 1
    case repeatPassword = 2
    case changePassword = 3
}

class ChangePasswordViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet private weak var titleLabel: UILabel!

    var isSwitchBetweenButtons = false
    var oldPassword:String?
    var newPassword:String?
    var repeatPassword:String?
    var originContentOffset:CGPoint!
    
    var presenter: ChangePasswordPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        presenter = ChangePasswordPresenterImp(view: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    @IBAction func backButtonAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func setupView() {
        titleLabel.text = "change_password".localized
    }
}

extension ChangePasswordViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case TableViewRows.oldPassword.rawValue:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ChangePasswordCell", for: indexPath) as? ChangePasswordCell else {return UITableViewCell()}
            
            cell.textfield.delegate = self
            cell.textfield.returnKeyType = UIReturnKeyType.next
            cell.textfield.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
            cell.textfield.tag = TableViewRows.oldPassword.rawValue
            cell.setupOldPasswordField()
            
            cell.selectionStyle = .none
            return cell
        case TableViewRows.newPassword.rawValue:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ChangePasswordCell", for: indexPath) as? ChangePasswordCell else {return UITableViewCell()}
            
            cell.textfield.delegate = self
            cell.setupNewPasswordField()
            cell.textfield.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
            cell.textfield.tag = TableViewRows.newPassword.rawValue
            
            cell.selectionStyle = .none
            return cell
        case TableViewRows.repeatPassword.rawValue:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ChangePasswordCell", for: indexPath) as? ChangePasswordCell else {return UITableViewCell()}
            
            cell.textfield.delegate = self
            cell.textfield.returnKeyType = UIReturnKeyType.next
            cell.textfield.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
            cell.textfield.tag = TableViewRows.repeatPassword.rawValue
            cell.setupRepeatPasword()
            
            cell.selectionStyle = .none
            return cell
            
        case TableViewRows.changePassword.rawValue:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "NormalLoginCell", for: indexPath) as? NormalLoginCell else { return UITableViewCell() }
            
            cell.loginBtn.addTarget(self, action: #selector(changePassword), for: .touchUpInside)
            cell.bindChangePassword()
            
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if isSwitchBetweenButtons==true {
            
        } else {
            view.endEditing(true)
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        isSwitchBetweenButtons = false
    }
    
    @IBAction func textFieldDidChange(_ textField: UITextField) {
        if textField.tag==TableViewRows.oldPassword.rawValue {
            oldPassword=textField.text
        } else if textField.tag==TableViewRows.newPassword.rawValue {
            newPassword=textField.text
        } else if textField.tag==TableViewRows.repeatPassword.rawValue {
            repeatPassword=textField.text
        }
    }
    
    @IBAction func changePassword(_ sender: UIButton) {
        guard let oldPass = oldPassword else { return }
        guard let newPass = newPassword else { return }
        guard let repeatPass = repeatPassword else { return }
        
        if newPassword != repeatPassword {
            return
        }
        self.tableView.setContentOffset(CGPoint.zero, animated: true)
        presenter.changePassword(oldPassword: oldPass, newPassword: newPass)
    }
}

extension ChangePasswordViewController:UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        isSwitchBetweenButtons = true
        if textField.tag==TableViewRows.oldPassword.rawValue {

        } else {
//            self.selectCell(textfield: textField)
        }
    }
//
//    func selectCell(textfield:UITextField){
//
//        let pointInTable = textfield.superview?.convert(textfield.frame.origin, to: tableView)
//        var contentOffset = originContentOffset
//        contentOffset?.y = (pointInTable?.y)! - textfield.frame.size.height - 80
//        self.tableView.setContentOffset(contentOffset!, animated: true)
//    }
}

extension ChangePasswordViewController: ChangePasswordView {
    func didInsertData() {
        self.navigationController?.popViewController(animated: true)
    }
}
