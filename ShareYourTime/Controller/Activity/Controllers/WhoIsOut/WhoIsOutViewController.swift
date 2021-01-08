//
//  WhoIsOutViewController.swift
//  ShareYourTime
//
//  Created by Mohammed Khaled (Sob7y) on 1/25/19.
//  Copyright © 2019 ShareYourTime. All rights reserved.
//

import UIKit

class WhoIsOutViewController: BaseViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    
    var collection: UICollectionView!
    var isCollectionViewLoaded = false
    var parentView: ActivityViewController!

    var days: [DayModel] = []
    var onceOnly = false
    var page = 0
    var limit = 20
    var presenter: WhoIsOutPresenter!
    var outListArray: [EventModel] = []
    var todayModel: DayModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = WhoIsOutPresenterImp(view: self)
        days = getDays()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
//        UIView.performWithoutAnimation {
//            self.collectionView.reloadData()
//        }
//        collectionView.scrollToItem(at: IndexPath(row: 2, section: 0), at: .centeredHorizontally, animated: true)
    }
    
    private func getDays() -> [DayModel] {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let todayDate = Date()
        let tomorrowDate = Date().tomorrow
        let dayAfterTomorrowDate = Date().afterTomorrow

        let dayAfterTomorrowName = Date().afterTomorrow.getDayName()
        
        todayModel = DayModel(Strings.sharedInstance.todayTitle, dateFormatter.string(from: todayDate), true, getDateTimestamp(todayDate))
        let tomorrowModel = DayModel(Strings.sharedInstance.tomorrowTitle, dateFormatter.string(from: tomorrowDate), false, getDateTimestamp(tomorrowDate))
        let dayAfterTomorrowModel = DayModel(dayAfterTomorrowName, dateFormatter.string(from: dayAfterTomorrowDate), false, getDateTimestamp(dayAfterTomorrowDate))
        
        presenter.getList(holdDate: todayModel.timeStamp ?? "", page: page, limit: limit)
        return [todayModel, tomorrowModel, dayAfterTomorrowModel]
    }
    
    func getDateTimestamp(_ date: Date)->String {
        let myTimeStamp = Int(date.timeIntervalSince1970)
        return String(myTimeStamp)
    }

}

extension WhoIsOutViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return days.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DayCollectionViewCell", for: indexPath) as? DayCollectionViewCell else { return UICollectionViewCell() }
        
        cell.bind(days[indexPath.row])
        
//        if !isCollectionViewLoaded {
//            isCollectionViewLoaded = true
//            collectionView.reloadData()
//            collectionView.scrollToItem(at: IndexPath(row: 1, section: 0), at: .centeredHorizontally, animated: true)
//            presenter.getList(holdDate: todayModel.timeStamp ?? "", page: page, limit: limit)
//        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        emptyView()
        
        let dayModel = days[indexPath.row]
        for day in days {
            day.isSelected = false
        }
        dayModel.isSelected = true
        days[indexPath.row] = dayModel
        presenter.getList(holdDate: dayModel.timeStamp ?? "", page: page, limit: limit)
        
        UIView.performWithoutAnimation {
            self.collectionView.reloadData()
        }
        collectionView.reloadItems(at: [indexPath])
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    private func emptyView() {
        outListArray.removeAll()
        self.tableView.reloadData()
    }
}

extension WhoIsOutViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if outListArray.isEmpty {
            tableView.setEmptyMessage(Strings.sharedInstance.noDataAvaialble)
        } else {
            tableView.restore()
        }
        return outListArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let event = outListArray[indexPath.row]
        
        if event.joinType == JoinType.empty {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "WhoIsOutRequestCell", for: indexPath) as? WhoIsOutRequestCell  else { return UITableViewCell() }
            
            cell.bind(event)
            cell.joinBtn.addTarget(self, action: #selector(joinActionClicked(_:)), for: .touchUpInside)
            cell.mayBeBtn.addTarget(self, action: #selector(maybeActionClicked(_:)), for: .touchUpInside)
            
            cell.joinBtn.tag = indexPath.row
            cell.mayBeBtn.tag = indexPath.row
            
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "WhoIsOutCell", for: indexPath) as? WhoIsOutCell  else { return UITableViewCell() }
            
            cell.bind(event)
            
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let event = outListArray[indexPath.row]
        self.parentView.performSegue(withIdentifier: Constant.segues.push_details, sender: event)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "viewDidScroll"), object: scrollView)
    }
    
    @IBAction func joinActionClicked(_ sender: UIButton) {
        let event = outListArray[sender.tag]
        event.joinType = JoinType.join
        outListArray[sender.tag] = event
        presenter.joinEvent(eventId: String(event.id!))
        self.tableView.reloadData()
    }
    @IBAction func maybeActionClicked(_ sender: UIButton) {
        let event = outListArray[sender.tag]
        event.joinType = JoinType.maybe
        outListArray[sender.tag] = event
        presenter.maybeEvent(eventId: String(event.id!))
        self.tableView.reloadData()
    }
}

extension WhoIsOutViewController: WhoIsOutView {
    func didInsertData(_ respose: MyPlanResponse) {
        outListArray = respose.data ?? []
        tableView.reloadData()
    }
}
