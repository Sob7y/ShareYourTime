//
//  InviteUsersViewController.swift
//  ShareYourTime
//
//  Created by Mohammed Khaled on 9/26/19.
//  Copyright © 2019 ShareYourTime. All rights reserved.
//

import UIKit
import XLPagerTabStrip

enum InviteTypes: String {
    case user
    case group
}

class InviteUsersViewController: BaseViewController {
    
    var itemInfo = IndicatorInfo(title: "Albums")
    // MARK: - XLPagerTabStrip Required Methods
    init(itemInfo: IndicatorInfo) {
        self.itemInfo = itemInfo
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var inviteButton: UIButton!
    
    var presenter: InviteUsersPresenter!
    
    var circlesData: [CirclesData] = []
    var users: [UserModel] = []
    var eventModel: EventModel?
    var inviteType: InviteTypes?
    
    var page = 0
    var limit = 1000
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        getData()
    }
    
    private func setupView() {
        presenter = InviteUsersPresenterImp(view: self)
        
        inviteButton.layer.masksToBounds = true
        inviteButton.layer.cornerRadius = 20
        inviteButton.setTitle("invite_users_title".localized, for: .normal)
    }
    
    private func getData() {
        if inviteType == .user {
            presenter.getUsers(page: String(page), limit: String(limit))
        } else {
            presenter.getGroups(page: page, limit: limit)
        }
    }
    
    @IBAction func inviteButtonTapped(_ sender: UIButton) {
        if inviteType == .user {
            if users.isEmpty {
                self.showError(message: "please_select_your_firnds".localized)
                return
            }
            var selectedUsersIds: [Int] = []
            for user in users {
                if user.isSelected {
                    selectedUsersIds.append(user.id ?? 0)
                }
            }
            presenter.invite(type: .user, eventId: String(eventModel?.id ?? 0), ids: selectedUsersIds)
        } else {
            var selectedGroupsIds: [Int] = []
            for circle in circlesData {
                if circle.isMember {
                    selectedGroupsIds.append(circle.circle?.id ?? 0)
                }
            }
            presenter.invite(type: .group, eventId: String(eventModel?.id ?? 0), ids: selectedGroupsIds)
        }
    }
}

extension InviteUsersViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if inviteType == .user {
            return users.count
        }
        return circlesData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if inviteType == .user {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: InviteUserCell.identifier, for: indexPath) as? InviteUserCell else { return UITableViewCell() }
            
            let user = users[indexPath.row]
            cell.bindInviteUsers(user)
            
            cell.addUserButton.addTarget(self, action: #selector(addRemoveUser(_:)), for: .touchUpInside)
            cell.addUserButton.tag = indexPath.row
            
            cell.selectionStyle = .none
            return cell
        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: InviteGroupCell.identifier, for: indexPath) as? InviteGroupCell else { return UITableViewCell() }
        
        cell.circleData = self.circlesData[indexPath.row]
        
        cell.addCircleButton.addTarget(self, action: #selector(addRemoveGroup(_:)), for: .touchUpInside)
        cell.addCircleButton.tag = indexPath.row
        
        cell.selectionStyle = .none
        return cell
    }
    
    @IBAction func addRemoveUser(_ sender: UIButton) {
        let user = users[sender.tag]
        user.isSelected = !(user.isSelected)
        users[sender.tag] = user
        self.tableView.reloadData()
    }
    
    @IBAction func addRemoveGroup(_ sender: UIButton) {
        let cicle = circlesData[sender.tag]
        cicle.isMember = !(cicle.isMember)
        circlesData[sender.tag] = cicle
        self.tableView.reloadData()
    }
}

extension InviteUsersViewController: IndicatorInfoProvider {
    // MARK: - IndicatorInfoProvider
    func indicatorInfo(for pagerTabStripController: PagerTabStripViewController) -> IndicatorInfo {
        return itemInfo
    }
}

extension InviteUsersViewController: InviteUsersView {
    func didInsertInviteDone() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func didInsertGroups(_ response: CirclesResponse) {
        circlesData = response.data ?? []
        tableView.reloadData()
    }
    
    func didInsertUsers(_ respose: FriendsResponseModel) {
        users = respose.data ?? []
        tableView.reloadData()
    }
}
