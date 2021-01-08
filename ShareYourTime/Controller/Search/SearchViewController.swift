//
//  SearchViewController.swift
//  ShareYourTime
//
//  Created by Maha Khaled on 5/10/19.
//  Copyright © 2019 ShareYourTime. All rights reserved.
//

import UIKit

class SearchViewController: BaseViewController {

    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet weak private var searchBar: UISearchBar!
    @IBOutlet weak private var titleLabel: UILabel!
    
    var users: [UserModel] = []
    var presenter: SearchPresenter!
    var searchText = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    @IBAction func backButtonAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func setupView() {
        presenter = SearchPresenterImp(view: self)
        searchBar.barTintColor = UIColor.clear
        searchBar.backgroundColor = UIColor.groupTableViewBackground
        searchBar.isTranslucent = true
        searchBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        
        searchBar.placeholder = "search".localized
        searchBar.delegate = self
        
        titleLabel.text = "search".localized
    }
    
    @IBAction func addUser(_ sender: UIButton) {
        let user = users[sender.tag]
        switch user.relation {
        case .friend?:
            removeFriendConfirmation(sender.tag)
        case .notFriend?:
            user.relation = .pending
            presenter.addUser(email: user.email ?? "")
        case .pending?:
            break
        case .none:
            break
        }
        
        self.tableView.reloadData()
    }
    
    func removeFriendConfirmation(_ index: Int) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "remove_friend_msg".localized, message: nil, preferredStyle: .actionSheet)
            
            let okAction = UIAlertAction(title: "yes".localized, style: .default, handler: { (action) in
                let user = self.users[index]
                guard let id = user.id else { return }
                user.relation = .notFriend
                self.presenter.removeUser(userId: String(id))
                self.users[index] = user
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

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier, for: indexPath) as? SearchTableViewCell else { return UITableViewCell() }
        
        let user = users[indexPath.row]
        cell.bind(user)
        
        cell.addUserButton.addTarget(self, action: #selector(addUser(_:)), for: .touchUpInside)
        cell.addUserButton.tag = indexPath.row
        
        cell.selectionStyle = .none
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.view.endEditing(true)
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count >= 3 {
            presenter.search(keyWord: searchText)
        } else {
            self.users.removeAll()
            self.tableView.reloadData()
        }
        self.searchText = searchText
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        presenter.search(keyWord: searchBar.text ?? "")
    }
}

extension SearchViewController: SearchView {
    func didInsertData(_ respose: SearchResponse) {
        users = respose.data ?? []
        self.tableView.reloadData()
    }
}
