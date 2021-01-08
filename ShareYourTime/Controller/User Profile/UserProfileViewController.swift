//
//  UserProfileViewController.swift
//  ShareYourTime
//
//  Created by Mohammed Khaled on 9/21/19.
//  Copyright © 2019 ShareYourTime. All rights reserved.
//

import UIKit

class UserProfileViewController: BaseViewController {
    
    @IBOutlet private weak var coverImg: UIImageView!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var joinUsView: UIView!
    @IBOutlet private weak var joinUsLabel: UILabel!
    @IBOutlet private weak var provideServiceLabel: UILabel!
    
    var oldContentOffset = CGPoint.zero
    let topConstraintRange = (CGFloat(-400)..<CGFloat(-120))
    var cachedImageViewSize: CGRect!
    
    var userModel: UserModel!
    var presenter: UserProfilePresenter!
    var language: String!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var userId: String?
    var eventsArray: [EventModel] = []
    
    @IBOutlet weak var tableView_topConstraint: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        getData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        cachedImageViewSize = self.coverImg.frame
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        self.tableView.setContentOffset(CGPoint.zero, animated: true)
    }
    
    func setup() {
        presenter = UserProfilePresenterImp(view: self)
    }
    
    func getData() {
        presenter.getUserProfile(userId ?? "")
    }
    
    func fillData() {
        if let image = userModel.image {
            let imageUrl = URL(string: ApiUrls.base_url + image)
            coverImg.sd_setImage(with: imageUrl)
        }
    }
    
    @IBAction func backButtonAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func searchAction(_ sender: UIButton) {
        self.performSegue(withIdentifier: Constant.segues.push_search, sender: nil)
    }
    
    @IBAction func joinUsAction(_ sender: UIButton) {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constant.segues.push_update_profile {
            if let destination = segue.destination as? EditProfileViewController {
                destination.userModel = sender as? UserModel
            }
        }
    }
    

}

extension UserProfileViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return userModel != nil ? 2 : 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return eventsArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfileHeaderCell.identifier, for: indexPath) as? ProfileHeaderCell else { return UITableViewCell() }
            
            cell.bind(self.userModel)
            cell.selectionStyle = .none
            return cell
        }
        let event = eventsArray[indexPath.row]
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "WhoIsOutCell", for: indexPath) as? WhoIsOutCell  else { return UITableViewCell() }
        
        cell.bind(event)
        cell.byWhomeLbl.text = Strings.sharedInstance.by + " " + (event.createdBy?.name ?? "")
        
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 300
        }
        return 170
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let y: CGFloat = -scrollView.contentOffset.y
        if y > 0 {
            self.coverImg.frame = CGRect(x: 0, y: scrollView.contentOffset.y, width: self.cachedImageViewSize.size.width + y, height: self.cachedImageViewSize.size.height + y)
            self.coverImg.center = CGPoint(x: self.view.center.x, y: self.coverImg.center.y)
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

extension UserProfileViewController: UserProfileView {
    func didInsertData(_ respose: ProfileResponseModel) {
        self.userModel = respose.data
        fillData()
        tableView.reloadData()
    }
    
    func didInsertEvents(_ respose: UserEventsResponseModel) {
        eventsArray = respose.data ?? []
        tableView.reloadData()
    }
}
