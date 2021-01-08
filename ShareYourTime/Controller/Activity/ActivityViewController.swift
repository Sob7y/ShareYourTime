//
//  ActivityViewController.swift
//  ShareYourTime
//
//  Created by Mohammed Khaled (Sob7y) on 1/25/19.
//  Copyright © 2019 ShareYourTime. All rights reserved.
//

import UIKit
import CarbonKit
import SDWebImage
import FBSDKLoginKit
import FacebookLogin

class ActivityViewController: BaseViewController {

    @IBOutlet weak var seperatorView: UIView!
    @IBOutlet weak var whoIsOutView: UIView!
    @IBOutlet weak var myPlanView: UIView!
    @IBOutlet weak var exploreView: UIView!
    @IBOutlet weak var containerView:UIView!
    @IBOutlet weak var headerView:UIView!
    @IBOutlet weak var parentView:UIView!
    @IBOutlet weak var userImage:UIButton?
    @IBOutlet weak var viewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var headerViewTopConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var buttonsContainerView: UIView!
    
    var oldContentOffset = CGPoint.zero
    let topConstraintRange = (CGFloat(20)..<CGFloat(90))
    var carbonTabSwipeNavigation = CarbonTabSwipeNavigation()
    var cachedImageViewSize: CGRect!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupCarbonKit()
        getUserModel()
        registerToken()
        getFriends()
        
        cachedImageViewSize = self.headerView.frame
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.viewDidScroll),
                                               name: NSNotification.Name(rawValue: "viewDidScroll"),
                                               object: nil)
        
        if Defaults.sharedInstance.applicationLanguage?.rawValue == "en" {
            self.seperatorView.center.x = whoIsOutView.center.x
            return
        }
        self.seperatorView.center.x = exploreView.center.x
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getUserModel()
        self.navigationController?.isNavigationBarHidden = true
    }
    
    func getFriends() {
//        let params = ["fields": "id, first_name, last_name, name, email, picture"]
//        let fbRequest = FBSDKGraphRequest(graphPath:"me/friends", parameters: params);
//        fbRequest?.start(completionHandler: { (connections, result, error) in
//            let resultDic = result as? NSDictionary
//            if let userNameArray = resultDic?.value(forKey: "data") as? NSArray {
//                
//            }
//        })        
    }
    
    private func registerToken() {
        if let deviceToken = (UserDefaults.standard.object(forKey: Constant.keys.DEVICE_TOKEN)) as? String {
            let uuid = UIDevice.current.identifierForVendor!.uuidString
            RegisterDeviceApi.getInstance().registerDevice(deviceToken: deviceToken, UUID: uuid, apiCallBack: self)
        }
    }
    
    private func getUserModel() {
        if UserDefaults.standard.object(forKey: "uesrModel") != nil {
            let decoded  = UserDefaults.standard.object(forKey: "uesrModel") as! Data
            let user = NSKeyedUnarchiver.unarchiveObject(with: decoded) as! UserModel
            
            guard let image = user.image else {return }
            userImage?.sd_setBackgroundImage(with: URL(string: ApiUrls.base_url + image), for: .normal)
            userImage?.layer.masksToBounds = true
            userImage?.layer.cornerRadius = (userImage?.frame.size.width)! / 2
        }
    }

    @IBAction func activityAction(_ sender: UIButton) {
        if sender.tag == 10 {
            self.moveSeperatorViewTo(whoIsOutView, 10)
            carbonTabSwipeNavigation.setCurrentTabIndex(0, withAnimation: false)
        } else if sender.tag == 11 {
            self.moveSeperatorViewTo(myPlanView, 11)
            carbonTabSwipeNavigation.setCurrentTabIndex(1, withAnimation: false)
        } else {
            self.moveSeperatorViewTo(exploreView, 12)
            carbonTabSwipeNavigation.setCurrentTabIndex(2, withAnimation: false)
        }
    }
    
    func moveSeperatorViewTo(_ view: UIView, _ tag: Int) {
        print(view.frame.origin.x + ((view.frame.size.width - self.seperatorView.frame.size.width) / 2))
        
        UIView.animate(withDuration: 0.2, delay: 0.0, options: [.curveEaseIn], animations: {
//            self.seperatorView.frame.origin.x = view.frame.origin.x + ((view.frame.size.width - self.seperatorView.frame.size.width) / 2)
//            self.seperatorView.translatesAutoresizingMaskIntoConstraints = false
            self.seperatorView.center.x = view.center.x
            if tag == 10 {
                self.seperatorView.backgroundColor = .brinkPink2
            } else if tag == 11 {
                self.seperatorView.backgroundColor = .stilDeGrainYellow
            } else {
                self.seperatorView.backgroundColor = .ultramarineBlue
            }
        }) { (bool) in
            
        }
    }
    
    func setupCarbonKit(){
        let items:[String] = ["", "", ""]
        carbonTabSwipeNavigation = CarbonTabSwipeNavigation(items: items, delegate: self)
        print("self.view.frame.size.width = \(self.view.frame.size.width)")
        carbonTabSwipeNavigation.view.frame = CGRect(x:0, y:0, width:self.containerView.frame.size.width, height:self.containerView.frame.size.height)
        
        carbonTabSwipeNavigation.setIndicatorHeight(0)
        carbonTabSwipeNavigation.setTabBarHeight(0)//tab bar height
        carbonTabSwipeNavigation.pagesScrollView?.isScrollEnabled = false
        carbonTabSwipeNavigation.insert(intoRootViewController: self, andTargetView: containerView)
        
        whoIsOutView.layer.masksToBounds = true
        myPlanView.layer.masksToBounds = true
        exploreView.layer.masksToBounds = true
        whoIsOutView.layer.cornerRadius = 8
        myPlanView.layer.cornerRadius = 8
        exploreView.layer.cornerRadius = 8
    }
    
    @IBAction func logout() {
        UserDefaults.standard.removeObject(forKey: "uesrModel")
        UserDefaults.standard.synchronize()
        performSegue(withIdentifier: Constant.segues.push_login, sender: nil)
    }
    
    @IBAction func openProfile(_ sender: UIButton) {
        performSegue(withIdentifier: "push_profile", sender: nil)
    }
    
    @objc func viewDidScroll(notification: Notification) {
        
        let scrollView = notification.object as! UIScrollView
        /*
//        let y: CGFloat = -scrollView.contentOffset.y
//        let delta =  scrollView.contentOffset.y - oldContentOffset.y
//
//        let offset = scrollView.contentOffset.y / 95
//        print(offset)
//        if offset >= 1 {
//
//        } else {
//            _ = scrollView.contentOffset.y / 95.0
//            headerViewTopConstraint.constant -= delta
//        }        
        
        let y: CGFloat = -scrollView.contentOffset.y
        let delta =  scrollView.contentOffset.y - oldContentOffset.y
        
        //we compress the top view
        if delta > 0 && headerViewTopConstraint.constant > topConstraintRange.lowerBound && scrollView.contentOffset.y > 0 {
            headerViewTopConstraint.constant -= delta
            
            //hide header view
            UIView.animate(withDuration: 0.3, delay: 0.0, options: UIView.AnimationOptions.curveEaseOut, animations: {
                self.headerView.alpha = 0.0
//                self.parentView.frame.origin.y -= delta
            }, completion: {
                (finished: Bool) -> Void in
            })
        }
        
        //we expand the top view
        if delta < 0 && headerViewTopConstraint.constant < topConstraintRange.upperBound && scrollView.contentOffset.y < 0 {
            headerViewTopConstraint.constant -= delta
            scrollView.contentOffset.y -= delta
            
            //show header view
            UIView.animate(withDuration: 0.3, delay: 0.0, options: UIView.AnimationOptions.curveEaseOut, animations: {
                self.headerView.alpha = 1.0
            }, completion: {
                (finished: Bool) -> Void in
            })
        }
        oldContentOffset = scrollView.contentOffset
        */
 
    }
    
    func transformElements(_ element: UIView?,
                       _ scale: CGFloat,
                       _ originY: CGFloat,
                       _ desiredY: CGFloat,
                       _ factor: CGFloat) {
        if let e = element {
            e.transform = CGAffineTransform(scaleX: scale, y: scale).translatedBy(x: 0, y: desiredY * (1 - factor))
            
        }
    }
    
    @IBAction func createEventBButtonClicked() {
        let decoded  = UserDefaults.standard.object(forKey: "uesrModel") as! Data
        let user = NSKeyedUnarchiver.unarchiveObject(with: decoded) as! UserModel
        if user.isServiceProvider ?? false {
            self.performSegue(withIdentifier: Constant.segues.push_create_sp_event, sender: nil)
        } else {
            self.performSegue(withIdentifier: Constant.segues.push_create_event, sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constant.segues.push_details {
            let destination = segue.destination as! EventDetailsViewController
            destination.eventModel = sender as? EventModel
        } else  if segue.identifier == Constant.segues.push_explore_details {
            if let destination = segue.destination as? ExploreDetailsViewController {
                destination.eventModel = sender as? ExploreEventModel
            }
        }
    }
}

extension ActivityViewController: CarbonTabSwipeNavigationDelegate {
    func carbonTabSwipeNavigation(_ carbonTabSwipeNavigation: CarbonTabSwipeNavigation, viewControllerAt index: UInt) -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if index == 0{
            let whoIsOutView = storyboard.instantiateViewController(withIdentifier: "WhoIsOutViewController") as! WhoIsOutViewController
            whoIsOutView.parentView = self
            return whoIsOutView
        } else if index == 1{
            let myPlanView = storyboard.instantiateViewController(withIdentifier: "MyPlanViewController") as! MyPlanViewController
            myPlanView.parentView = self
            return myPlanView
        } else {
            let exploreView = storyboard.instantiateViewController(withIdentifier: "ExploreViewController") as! ExploreViewController
            exploreView.parentView = self
            return exploreView
        }
    }
}

extension ActivityViewController: ApiCallBack {
    func onSuccess(response: Any) {
        
    }
    func onFailure(error: ApiError) {
        
    }
}
