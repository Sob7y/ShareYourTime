//
//  ExploreDetailsViewController.swift
//  ShareYourTime
//
//  Created by Mohammed Khaled on 11/15/19.
//  Copyright © 2019 ShareYourTime. All rights reserved.
//

import UIKit

class ExploreDetailsViewController: BaseViewController {

    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var coverImage: UIImageView!
    @IBOutlet private weak var bookButton: UIButton!
    @IBOutlet weak var tableView_topConstraint: NSLayoutConstraint!

    var oldContentOffset = CGPoint.zero
    let topConstraintRange = (CGFloat(-480)..<CGFloat(-200))
    var cachedImageViewSize: CGRect!

    var presenter: ExploreDetailsPresenter!
    var eventModel: ExploreEventModel?
    
    var storedOffsets = [Int: CGFloat]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        getData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        cachedImageViewSize = self.coverImage.frame
    }
    
    private func setupView() {
        presenter = ExploreDetailsPresenterImp(view: self)
        bookButton.setTitle("book".localized, for: .normal)
        bookButton.layer.masksToBounds = true
        bookButton.layer.cornerRadius = 8
    }
    
    private func getData() {
        presenter.getExploreDetails(self.eventModel?.id ?? 0)
    }
    
    private func fillCoverImage() {
        if let image = eventModel?.images?.first {
            let imageUrl = URL(string: ApiUrls.base_url + image)
            coverImage.sd_setImage(with: imageUrl)
        }
    }
    
    @IBAction func bookButtonTapped() {
        presenter.bookEvent(self.eventModel?.id ?? 0)
    }

    @IBAction func backButtonAction() {
        self.navigationController?.popViewController(animated: true)
    }
}

extension ExploreDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ExploreDetailsInfoCell.identifier, for: indexPath) as? ExploreDetailsInfoCell else {return UITableViewCell()}
            
            cell.event = self.eventModel
            
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            return cell
        } else if indexPath.row == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ExploreDetailsJoinedUsersCell.identifier, for: indexPath) as? ExploreDetailsJoinedUsersCell else {return UITableViewCell()}
            
            cell.event = self.eventModel
            
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ExploreDetailsLocationCell.identifier, for: indexPath) as? ExploreDetailsLocationCell else {return UITableViewCell()}
            
            cell.event = self.eventModel
            
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 205
        } else if indexPath.row == 1 {
            return 120
        }
        return 250
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y: CGFloat = -scrollView.contentOffset.y
        if y > 0 {
            self.coverImage.frame = CGRect(x: 0, y: scrollView.contentOffset.y, width: self.cachedImageViewSize.size.width + y, height: self.cachedImageViewSize.size.height + y)
            self.coverImage.center = CGPoint(x: self.view.center.x, y: self.coverImage.center.y)
        }
        let delta =  scrollView.contentOffset.y - oldContentOffset.y
        //we compress the top view
        if delta > 0 && tableView_topConstraint.constant > topConstraintRange.lowerBound && scrollView.contentOffset.y > 0 {
            //            tableView_topConstraint.constant -= delta
            //            scrollView.contentOffset.y -= delta
        }
        
        //we expand the top view
        if delta < 0 && tableView_topConstraint.constant < topConstraintRange.upperBound && scrollView.contentOffset.y < 0 {
            tableView_topConstraint.constant -= delta
            scrollView.contentOffset.y -= delta
        }
        oldContentOffset = scrollView.contentOffset
    }
    
}

extension ExploreDetailsViewController: ExploreDetailsView {
    func didInsertData(_ respose: ExploreDetailsResponse) {
        eventModel = respose.data
        fillCoverImage()
        tableView.reloadData()
    }
    
    func eventBooked() {
        self.navigationController?.popViewController(animated: true)
    }
}
