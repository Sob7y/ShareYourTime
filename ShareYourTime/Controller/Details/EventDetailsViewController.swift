//
//  EventDetailsViewController.swift
//  ShareYourTime
//
//  Created by Maha Khaled on 3/20/19.
//  Copyright © 2019 ShareYourTime. All rights reserved.
//

import UIKit

class EventDetailsViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var joinContainerView: UIView!
    @IBOutlet weak var joinButton: UIButton!
    @IBOutlet weak var mayBeButton: UIButton!
    @IBOutlet weak var joinLabel: UILabel!
    @IBOutlet weak var mayBeLabel: UILabel!
    @IBOutlet weak var joinImage: UIImageView!
    @IBOutlet weak var mayBeImage: UIImageView!

    var presenter: EventDetailsPresenter!
    var eventModel: EventModel!
    
    var storedOffsets = [Int: CGFloat]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        presenter = EventDetailsPresenterImp(view: self)
        presenter.getEventDetails(eventId: String(eventModel.id!))
    }
    
    func setupView() {
        switch eventModel.joinType {
        case .owner?:
            //hide join view
            joinContainerView.alpha = 0
            break
        case .join?:
            enableJoin()
        case .maybe?:
            enableMaybe()
        default:
            enableBoth()
        }
        joinLabel.text = Strings.sharedInstance.join
        mayBeLabel.text = Strings.sharedInstance.mayBe
    }
    
    func enableBoth() {
        joinContainerView.alpha = 1
        
        joinLabel.alpha = 1
        joinImage.alpha = 1
        mayBeLabel.alpha = 1
        mayBeImage.alpha = 1
    }
    
    func enableJoin() {
        joinLabel.alpha = 0.4
        joinImage.alpha = 0.4
        mayBeLabel.alpha = 1.0
        mayBeImage.alpha = 1.0
    }
    
    func enableMaybe() {
        joinLabel.alpha = 1
        joinImage.alpha = 1
        mayBeLabel.alpha = 0.4
        mayBeImage.alpha = 0.4
    }
    
    @IBAction func backAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func joinActionClicked() {
        enableJoin()
        presenter.joinEvent(eventId: String(eventModel.id!))
    }
    
    @IBAction func maybeActionClicked() {
        enableMaybe()
        presenter.maybeEvent(eventId: String(eventModel.id!))
    }
    
    @IBAction func openInviteUsers(_ sender: UIButton) {
        self.performSegue(withIdentifier: Constant.segues.push_invite, sender: eventModel)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constant.segues.push_invite {
            let destination = segue.destination as! InviteUsersContainerViewController
            destination.eventModel = sender as? EventModel
        }
    }
}

extension EventDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return 3
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == 2 {
            guard let tableViewCell = cell as? EventDetailsJoinedPeopleCell else { return }
            
            tableViewCell.setCollectionViewDataSourceDelegate(self, forRow: indexPath.row)
            tableViewCell.collectionView.tag = 0
            tableViewCell.collectionViewOffset = storedOffsets[indexPath.row] ?? 0
            return
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            guard let cell = tableView.dequeueReusableCell(withIdentifier: EventDetailsUserDataCell.identifier, for: indexPath) as? EventDetailsUserDataCell else {return UITableViewCell()}
            
            cell.bind(self.eventModel)
            
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            return cell
        } else if indexPath.row == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: EventDetailsLocationCell.identifier, for: indexPath) as? EventDetailsLocationCell else {return UITableViewCell()}
            
            cell.eventModel = self.eventModel
            
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: EventDetailsJoinedPeopleCell.identifier, for: indexPath) as? EventDetailsJoinedPeopleCell else {return UITableViewCell()}
            
            
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 228
        } else if indexPath.row == 1 {
            return 172
        }
        return 145
    }
}

extension EventDetailsViewController:UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return eventModel.joinedUsers?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "JoinedCollectionViewCell", for: indexPath) as! JoinedCollectionViewCell
        
        if let user = (eventModel.joinedUsers?[indexPath.row]) {
            cell.bind(user)
        }
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let user = eventModel.joinedUsers?[indexPath.row]
            
    }
}

extension EventDetailsViewController: EventDetailsView {
    func didInsertData(_ respose: EventDetailsResponse) {
        eventModel = respose.data
        tableView.reloadData()
    }
}
