//
//  ViewCircleViewController.swift
//  ShareYourTime
//
//  Created by Mohammed Khaled on 8/15/19.
//  Copyright © 2019 ShareYourTime. All rights reserved.
//

import UIKit

class ViewCircleViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet weak var editBtn: UIButton!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descLbl: UILabel!
    
    var users: [UserModel] = []
    var membersUsers: [UserModel] = []
    var circleData: CirclesData?
    var presenter: ViewCirclePresenter!
    var circleTitle: String?
    var isViewingDetails = false
    
    var page = 1
    var limit = 200
    var isInEditMode = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setEditButtonMode()
        
        if let data = circleData {
            self.circleTitle = data.circle?.name ?? ""
            isViewingDetails = true
            submitBtn.isHidden = true
        } else {
            isViewingDetails = false
        }
        
        getDetails()
    }
    
    @IBAction func createCircleAction() {
        guard let title = self.circleTitle else { return self.showError(message: "circle_title_is_required".localized)}
        if users.isEmpty {
            self.showError(message: "please_select_your_firnds".localized)
            return
        }
        var selectedUsersIds: [Int] = []
        for user in users {
            if user.isMember ?? false {
                selectedUsersIds.append(user.id ?? 0)
            }
        }
        presenter.editCircle(id: self.circleData?.circle?.id ?? 0, title: title, ids: selectedUsersIds)
    }
    
    func setupView() {
        presenter = ViewCirclePresenterImp(view: self)
        
        submitBtn.layer.masksToBounds = true
        submitBtn.layer.cornerRadius = 20
        submitBtn.setTitle(Strings.sharedInstance.submit, for: .normal)
        
        titleLbl.text = "view_circle".localized
        descLbl.text = "create_your_own_circle".localized
        
    }
    
    private func setEditButtonMode() {
        let decoded  = UserDefaults.standard.object(forKey: "uesrModel") as! Data
        let user = NSKeyedUnarchiver.unarchiveObject(with: decoded) as! UserModel
        if let data = circleData {
            editBtn.isHidden = user.id == data.circle?.userId ? false : true
        } else {
            editBtn.isHidden = true
        }
        titleLbl.text = isInEditMode ? "edit_circle".localized : "view_circle".localized
        editBtn.setTitle(isInEditMode ? "cancel".localized : "edit".localized, for: .normal)
    }
    
    func getDetails() {
        presenter.getCircleDetails(id: self.circleData?.circle?.id ?? 0, page: 1, limit: 200)
    }
    
    @IBAction func editButtonAction() {
        if isInEditMode {
            isInEditMode = false
            setEditButtonMode()
            submitBtn.isHidden = true
            isViewingDetails = true
            self.users = users.filter({ $0.isMember ?? false })
            self.tableView.reloadData()
            return
        }
        isInEditMode = true
        getDetails()
        isViewingDetails = false
        setEditButtonMode()
        submitBtn.isHidden = false
        
        self.tableView.reloadData()
    }
    
    @IBAction func backButtonAction() {
        self.navigationController?.popViewController(animated: true)
    }
    

}

extension ViewCircleViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return isInEditMode ? 1 : 1
        } else {
            if users.isEmpty {
                self.tableView.setEmptyMessage("No_friends".localized)
            } else {
                self.tableView.restore()
            }
            return users.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if indexPath.row == 1 {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: AddNewUsersCell.identifier, for: indexPath) as? AddNewUsersCell else {return UITableViewCell()}
                
                cell.selectionStyle = UITableViewCell.SelectionStyle.none
                return cell
            }
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CreateEventTitleCell.identifier, for: indexPath) as? CreateEventTitleCell else {return UITableViewCell()}
            
            cell.bind()
            cell.textfield.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
            cell.textfield.tag = indexPath.row
            
            cell.textfield.isEnabled = isInEditMode ? true : false
            
            if let data = circleData {
                cell.textfield.text = data.circle?.name
            }
            
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            return cell
        }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier, for: indexPath) as? SearchTableViewCell else { return UITableViewCell() }
        
        let user = users[indexPath.row]
        cell.bindFriends(user)
        
        cell.addUserButton.addTarget(self, action: #selector(addRemoveUserAction(_:)), for: .touchUpInside)
        cell.addUserButton.tag = indexPath.row
        
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                return 90
            }
            return 70
        }
        return 67
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.view.endEditing(true)
    }
    
    @IBAction func addRemoveUserAction(_ sender: UIButton) {
        if isInEditMode {
            let user = users[sender.tag]
            user.isMember = !(user.isMember ?? false)
            users[sender.tag] = user
            self.tableView.reloadData()
        }
    }
}

extension ViewCircleViewController: UITextFieldDelegate {
    @IBAction func textFieldDidChange(_ textField: UITextField) {
        switch textField.tag {
        case 0:
            circleTitle = textField.text
        default:
            break
        }
    }
}

extension ViewCircleViewController: ViewCircleView {
    func circleCreated() {
        self.navigationController?.popViewController(animated: true)
    }
    func didInsertData(_ response: ViewCircleResponse) {
        if isViewingDetails {
            self.users = (response.data?[0].connections ?? []).filter({ $0.isMember ?? false })
            membersUsers = users.filter({ $0.isMember ?? false })
        } else {
            self.users = response.data?[0].connections ?? []
        }
        
       
        self.tableView.reloadData()
    }
}
