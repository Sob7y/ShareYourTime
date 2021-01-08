//
//  ExploreViewController.swift
//  ShareYourTime
//
//  Created by Mohammed Khaled (Sob7y) on 1/25/19.
//  Copyright © 2019 ShareYourTime. All rights reserved.
//

import UIKit

enum ExploreTypes: Int {
    case latest = 0
    case mostBooked
    case topUsers
    case topCountries
}

class ExploreViewController: BaseViewController {

    @IBOutlet private weak var tableView: UITableView!
    var presenter: ExplorePresenter!
    var exploreData: ExploreData?
    var parentView: ActivityViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        getData()
    }
    
    private func setupView() {
        presenter = ExplorePresenterImp(view: self)
        registerTableViewCells()
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(getData),
                                               name: Notification.Name("relodExplore"),
                                               object: nil)
    }
    
    @objc
    private func getData() {
        presenter.getExploreData()
    }

    private func registerTableViewCells() {
        self.tableView.register(
            UINib(nibName: LatestEventsCell.identifier, bundle: nil),
            forCellReuseIdentifier: LatestEventsCell.identifier)
        
        self.tableView.register(
            UINib(nibName: MostBookedCell.identifier, bundle: nil),
            forCellReuseIdentifier: MostBookedCell.identifier)
        
        self.tableView.register(
            UINib(nibName: TopUsersCell.identifier, bundle: nil),
            forCellReuseIdentifier: TopUsersCell.identifier)
        
        self.tableView.register(
            UINib(nibName: TopCountriesCell.identifier, bundle: nil),
            forCellReuseIdentifier: TopCountriesCell.identifier)
    }
    
    private func pushDetails(_ event: ExploreEventModel) {
        self.parentView.performSegue(withIdentifier: Constant.segues.push_explore_details, sender: event)
    }
}

extension ExploreViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case ExploreTypes.latest.rawValue:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: LatestEventsCell.identifier, for: indexPath) as? LatestEventsCell else { return UITableViewCell() }
            
            cell.events = exploreData?.latest ?? []
            cell.delegate = self
            
            cell.selectionStyle = .none
            return cell
        case ExploreTypes.mostBooked.rawValue:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MostBookedCell.identifier, for: indexPath) as? MostBookedCell else { return UITableViewCell() }
            
            cell.events = exploreData?.mostBooked ?? []
            
            cell.selectionStyle = .none
            return cell
        case ExploreTypes.topUsers.rawValue:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TopUsersCell.identifier, for: indexPath) as? TopUsersCell else { return UITableViewCell() }
            
            cell.users = exploreData?.topUsers?.users ?? []
            
            cell.selectionStyle = .none
            return cell
        case ExploreTypes.topCountries.rawValue:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TopCountriesCell.identifier, for: indexPath) as? TopCountriesCell else { return UITableViewCell() }
            
            cell.countries = exploreData?.topCountries?.countries ?? []
            
            cell.selectionStyle = .none
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "viewDidScroll"), object: scrollView)
    }
}

extension ExploreViewController: LatestEventsDelegate {
    func eventClicked(with event: ExploreEventModel) {
        pushDetails(event)
    }
}

extension ExploreViewController: ExploreView {
    func didInsertData(_ respose: ExploreResponse) {
        exploreData = respose.data
        self.tableView.reloadData()
    }
}
