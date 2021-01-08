//
//  RequestsListViewController.swift
//  ShareYourTime
//
//  Created by Maha Khaled on 5/17/19.
//  Copyright © 2019 ShareYourTime. All rights reserved.
//

import UIKit

class RequestsListViewController: BaseViewController {

    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var responedLabel: UILabel!
    
    var users: [UserModel] = []
    var presenter: RequestsListPresenter!
    var page = 1
    var limit = 200
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        presenter = RequestsListPresenterImp(view: self)
        getRequests()
    }
    
    func getRequests() {
        presenter.getRequests(page: String(page), limit: String(limit))
    }

    @IBAction func backButtonAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func setupView() {
        titleLabel.text = "requests_list".localized
        responedLabel.text = "responed_request".localized.replacingOccurrences(of: "{count}", with: String(users.count))
    }
}

extension RequestsListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if users.isEmpty {
            self.tableView.setEmptyMessage("No_requests".localized)
        } else {
            self.tableView.restore()
        }
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: RequestCell.identifier, for: indexPath) as? RequestCell else { return UITableViewCell() }
        
        let user = users[indexPath.row]
        cell.bind(user)
        
        cell.acceptButton.addTarget(self, action: #selector(acceptRequest(_:)), for: .touchUpInside)
        cell.acceptButton.tag = indexPath.row
        cell.rejectButton.addTarget(self, action: #selector(rejectRequest(_:)), for: .touchUpInside)
        cell.rejectButton.tag = indexPath.row
        
        cell.selectionStyle = .none
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.view.endEditing(true)
    }
    
    @IBAction func acceptRequest(_ sender: UIButton) {
        let user = users[sender.tag]
        guard let id = user.id else { return }
        presenter.acceptRequest(String(id))
        users.remove(at: sender.tag)
        self.tableView.reloadData()
    }
    @IBAction func rejectRequest(_ sender: UIButton) {
        let user = users[sender.tag]
        guard let id = user.id else { return }
        presenter.rejectRequest(String(id))
        users.remove(at: sender.tag)
        self.tableView.reloadData()
    }
}

extension RequestsListViewController: RequestsListView {
    func didInsertData(_ response: RequestsListResponse) {
        users = response.data ?? []
        setupView()
        self.tableView.reloadData()
    }
}
