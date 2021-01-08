//
//  MyPlanViewController.swift
//  ShareYourTime
//
//  Created by Mohammed Khaled (Sob7y) on 1/25/19.
//  Copyright © 2019 ShareYourTime. All rights reserved.
//

import UIKit

class MyPlanViewController: BaseViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    var parentView: ActivityViewController!
    
    var page = 0
    var limit = 20
    var presenter: MyPlanPresenter!
    var outListArray: [EventModel] = []
    var todayModel: DayModel!

    var collection: UICollectionView!
    var isCollectionViewLoaded = false
    
    var days: [DayModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = MyPlanPresenterImp(view: self)
        days = getDays()
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

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "viewDidScroll"), object: scrollView)
    }
}

extension MyPlanViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
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
}

extension MyPlanViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if outListArray.isEmpty {
            tableView.setEmptyMessage(Strings.sharedInstance.noDataAvaialble)
        } else {
            tableView.restore()
        }
        return outListArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "WhoIsOutCell", for: indexPath) as? WhoIsOutCell  else { return UITableViewCell() }
        
        cell.bind(outListArray[indexPath.row])
        
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let event = outListArray[indexPath.row]
        self.parentView.performSegue(withIdentifier: Constant.segues.push_details, sender: event)
    }
}

extension MyPlanViewController: MyPlanView {
    func didInsertData(_ respose: MyPlanResponse) {
        outListArray = respose.data ?? []
        tableView.reloadData()
    }
}
