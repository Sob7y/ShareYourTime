//
//  InviteUsersContainerViewController.swift
//  ShareYourTime
//
//  Created by Mohammed Khaled on 9/26/19.
//  Copyright © 2019 ShareYourTime. All rights reserved.
//

import UIKit
import XLPagerTabStrip

class InviteUsersContainerViewController: ButtonBarPagerTabStripViewController {

    @IBOutlet private weak var titleLbl: UILabel!
    @IBOutlet private weak var descLbl: UILabel!
    var eventModel: EventModel?

    override func viewDidLoad() {
        setupXLPager()
        super.viewDidLoad()
    }
    
    @IBAction func backButtonAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    private func setupXLPager() {
        let font = UIFont(name: "HelveticaNeue-Medium", size: 18.0)!
        
        settings.style.buttonBarBackgroundColor = .clear
        settings.style.buttonBarItemBackgroundColor = .white
        settings.style.selectedBarBackgroundColor = .unitedNationsBlue
        settings.style.buttonBarItemFont = font
        settings.style.selectedBarHeight = 4.0
        settings.style.buttonBarHeight = 44
        settings.style.buttonBarMinimumLineSpacing = 0
        settings.style.buttonBarItemTitleColor = .lavenderGray
        settings.style.buttonBarItemsShouldFillAvailableWidth = true
        settings.style.buttonBarLeftContentInset = 0
        settings.style.buttonBarRightContentInset = 0
        self.containerView.backgroundColor = .clear
        changeCurrentIndexProgressive = { (oldCell: ButtonBarViewCell?,
            newCell: ButtonBarViewCell?,
            progressPercentage: CGFloat,
            changeCurrentIndex: Bool,
            animated: Bool) -> Void in
            guard changeCurrentIndex == true else { return }
            oldCell?.label.textColor = .lavenderGray
            newCell?.label.textColor = .outerSpace
        }
    }

    // MARK: - PagerTabStripDataSource
       
    override func viewControllers(for pagerTabStripController: PagerTabStripViewController) -> [UIViewController] {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let inviteUsersView = storyboard.instantiateViewController(withIdentifier: "InviteUsersViewController") as! InviteUsersViewController
        inviteUsersView.inviteType = .user
        inviteUsersView.itemInfo.title = "users".localized
        inviteUsersView.eventModel = eventModel

        let inviteGroupsView = storyboard.instantiateViewController(withIdentifier: "InviteUsersViewController") as! InviteUsersViewController
        inviteGroupsView.inviteType = .group
        inviteGroupsView.itemInfo.title = "groups".localized
        inviteGroupsView.eventModel = eventModel
        
        return [inviteUsersView, inviteGroupsView]
    }
}
