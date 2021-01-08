//
//  CreateCircleViewController.swift
//  ShareYourTime
//
//  Created by Mohammed Khaled on 8/6/19.
//  Copyright © 2019 ShareYourTime. All rights reserved.
//

import UIKit

class CreateCircleViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descLbl: UILabel!
    
    var users: [UserModel] = []
    var presenter: CreateCirclePresenter!
    var circleTitle: String?

    var page = 1
    var limit = 200
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        getFriends()
    }
    
    @IBAction func createCircleAction() {
        guard let title = self.circleTitle else { return self.showError(message: "circle_title_is_required".localized)}
        if users.isEmpty {
            self.showError(message: "please_select_your_firnds".localized)
            return
        }
        var slectedUsersIds: [Int] = []
        for user in users {
            if user.isSelected {
                slectedUsersIds.append(user.id ?? 0)
            }
        }
        presenter.createCircle(title: title, ids: slectedUsersIds)
    }
    
    func setupView() {
        presenter = CreateCirclePresenterImp(view: self)
        
        submitBtn.layer.masksToBounds = true
        submitBtn.layer.cornerRadius = 20
        submitBtn.setTitle(Strings.sharedInstance.submit, for: .normal)
        
        titleLbl.text = "create_circle".localized
        descLbl.text = "create_your_own_circle".localized
    }
    
    func getFriends() {
        presenter.getFriends(page: String(page), limit: String(limit))
    }
    
    @IBAction func backButtonAction() {
        self.navigationController?.popViewController(animated: true)
    }

}

extension CreateCircleViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
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
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "CreateEventTitleCell", for: indexPath) as? CreateEventTitleCell else {return UITableViewCell()}
            
            cell.bind()
            cell.textfield.addTarget(self, action: #selector(textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
            cell.textfield.tag = indexPath.row
            
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            return cell
        }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier, for: indexPath) as? SearchTableViewCell else { return UITableViewCell() }
        
        let user = users[indexPath.row]
        cell.bindFriends(user)
        cell.addUserButton.addTarget(self, action: #selector(addUser(_:)), for: .touchUpInside)
        cell.addUserButton.tag = indexPath.row
        
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 90
        }
        return 67
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.view.endEditing(true)
    }
    
    @IBAction func addUser(_ sender: UIButton) {
        let user = users[sender.tag]
        user.isSelected = !user.isSelected
        users[sender.tag] = user
        self.tableView.reloadData()
    }
}

extension CreateCircleViewController: UITextFieldDelegate {
    @IBAction func textFieldDidChange(_ textField: UITextField) {
        switch textField.tag {
        case 0:
            circleTitle = textField.text
        default:
            break
        }
    }
}

extension CreateCircleViewController: CreateCircleView {
    func circleCreated() {
        self.navigationController?.popViewController(animated: true)
    }
    func didInsertData(_ response: FriendsResponseModel) {
        self.users = response.data ?? []
        self.tableView.reloadData()
    }
}
