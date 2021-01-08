//
//  FriendsViewController.swift
//  ShareYourTime
//
//  Created by Maha Khaled on 5/17/19.
//  Copyright © 2019 ShareYourTime. All rights reserved.
//

import UIKit

class FriendsViewController: BaseViewController {

    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet weak private var titleLabel: UILabel!
    
    var users: [UserModel] = []
    var presenter: FriendsPresenter!
    var page = 1
    var limit = 200
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        getFriends()
    }
    
    func getFriends() {
        presenter.getFriends(page: String(page), limit: String(limit))
    }
    
    func setupView() {
        presenter = FriendsPresenterImp(view: self)
        titleLabel.text = "friends_list".localized
    }
    @IBAction func backButtonAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constant.segues.push_user_profile {
            let destination = segue.destination as! UserProfileViewController
            destination.userModel = sender as? UserModel
        }
    }
    
}

extension FriendsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if users.isEmpty {
            self.tableView.setEmptyMessage("No_friends".localized)
        } else {
            self.tableView.restore()
        }
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier, for: indexPath) as? SearchTableViewCell else { return UITableViewCell() }
        
        let user = users[indexPath.row]
        cell.bindUsers(user)
        
        cell.addUserButton.addTarget(self, action: #selector(removeUser(_:)), for: .touchUpInside)
        cell.addUserButton.tag = indexPath.row
        
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = users[indexPath.row]
        self.performSegue(withIdentifier: Constant.segues.push_user_profile, sender: user)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 67
    }
    
    @IBAction func removeUser(_ sender: UIButton) {
        removeFriendConfirmation(sender.tag)
    }
    
    func removeFriendConfirmation(_ index: Int) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "remove_friend_msg".localized, message: nil, preferredStyle: .actionSheet)
            
            let okAction = UIAlertAction(title: "yes".localized, style: .default, handler: { (action) in
                let user = self.users[index]
                guard let id = user.id else { return }
                self.presenter.removeUser(userId: String(id))
                self.users.remove(at: index)
                self.tableView.reloadData()
            })
            let cancelAction = UIAlertAction(title: "cancel".localized, style: .cancel, handler: { (action) in
                
            })
            
            alert.addAction(okAction)
            alert.addAction(cancelAction)
            
            self.present(alert, animated: true, completion: {
                
            })
        }
    }
}

extension FriendsViewController: FriendsView {
    func didInsertData(_ response: FriendsResponseModel) {
        self.users = response.data ?? []
        self.tableView.reloadData()
    }
}
