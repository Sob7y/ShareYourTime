//
//  ProfileViewController.swift
//  ShareYourTime
//
//  Created by Maha Khaled on 4/6/19.
//  Copyright © 2019 ShareYourTime. All rights reserved.
//

import UIKit

class ProfileViewController: BaseViewController {

    @IBOutlet private weak var coverImg: UIImageView!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var joinUsView: UIView!
    @IBOutlet private weak var joinUsLabel: UILabel!
    @IBOutlet private weak var provideServiceLabel: UILabel!
    
    var oldContentOffset = CGPoint.zero
    let topConstraintRange = (CGFloat(-400)..<CGFloat(-120))
    var cachedImageViewSize: CGRect!
    
    var userModel: UserModel!
    var presenter: ProfilePresenter!
    var language: String!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    @IBOutlet weak var tableView_topConstraint: NSLayoutConstraint!
    @IBOutlet weak var joinUsHeightConstraint: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        cachedImageViewSize = self.coverImg.frame
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.getProfile()
        self.tableView.setContentOffset(CGPoint.zero, animated: true)
    }
    
    func setup() {
        joinUsView.layer.masksToBounds = true
        joinUsView.layer.cornerRadius = 8
        
        presenter = ProfilePresenterImp(view: self)
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
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let detailVC = storyboard.instantiateViewController(withIdentifier: "JoinUsViewController") as? JoinUsViewController {
            let transition:CATransition = CATransition()
            transition.duration = 0.5
            transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.default)
            transition.type = CATransitionType.moveIn
            transition.subtype = CATransitionSubtype.fromTop
            self.navigationController!.view.layer.add(transition, forKey: kCATransition)
            self.navigationController?.pushViewController(detailVC, animated: false)
        }
        
//        performSegue(withIdentifier: Constant.segues.push_joinUs, sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constant.segues.push_update_profile {
            if let destination = segue.destination as? EditProfileViewController {
                destination.userModel = sender as? UserModel
            }
        }
    }
}


extension ProfileViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if userModel != nil {
            return 8
        }
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfileHeaderCell.identifier, for: indexPath) as? ProfileHeaderCell else { return UITableViewCell() }
            
            cell.bind(self.userModel)
            cell.selectionStyle = .none
            return cell
        }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProfileInfoCell.identifier, for: indexPath) as? ProfileInfoCell else { return UITableViewCell() }
        
        cell.setup(indexPath.row)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 300
        }
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 1:
            logoutConfirmation()
        case 2:
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: Constant.segues.push_change_password, sender: nil)
            }
        case 3:
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: Constant.segues.push_friends_list, sender: nil)
            }
        case 4:
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: Constant.segues.push_requests_list, sender: nil)
            }
        case 5:
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: Constant.segues.push_circles, sender: self.userModel)
            }
        case 6:
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: Constant.segues.push_update_profile, sender: self.userModel)
            }
        case 7:
            UserDefaults.standard.removeObject(forKey: "uesrModel")
            UserDefaults.standard.synchronize()
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: Constant.segues.push_login, sender: nil)
            }
        default:
            break
        }
        
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
    
    func logoutConfirmation() {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "change_language".localized, message: nil, preferredStyle: .actionSheet)
            
            let arabicAction = UIAlertAction(title: "العربية", style: .default, handler: { (action) in
                let langStr = "ar"
                Strings.sharedInstance.changeLangugage(lang: Langugage(rawValue: langStr)!)
                Defaults.sharedInstance.applicationLanguage = Langugage(rawValue: langStr)!
                
                self.language = langStr
                self.changeLanguage()
            })
            let englishAction = UIAlertAction(title: "English", style: .default, handler: { (action) in
                let langStr = "en"
                Strings.sharedInstance.changeLangugage(lang: Langugage(rawValue: langStr)!)
                Defaults.sharedInstance.applicationLanguage = Langugage(rawValue: langStr)!
                
                self.language = langStr
                self.changeLanguage()
            })
            let cancelAction = UIAlertAction(title: "cancel".localized, style: .cancel, handler: { (action) in
                
            })
            
            alert.addAction(englishAction)
            alert.addAction(arabicAction)
            alert.addAction(cancelAction)
            
            self.present(alert, animated: true, completion: {
                
            })
        }
    }
    
    func changeLanguage() {
        guard let code = self.language,
            let selectedLanguage = L102Language(rawValue: code) else {
                return
        }
        
        L102Language.language = selectedLanguage
        resetApp()
    }
    
    func resetApp() {
        let splashView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "splashView") as? SplashViewController
        appDelegate.window?.rootViewController = splashView
        appDelegate.window?.makeKeyAndVisible()
    }
}

extension ProfileViewController: ProfileView {
    func didInsertData(_ respose: ProfileResponseModel) {
        self.userModel = respose.data
        fillData()
        if userModel.isServiceProvider ?? false {
            joinUsHeightConstraint.constant = 0
            joinUsView.isHidden = true
        } else {
            joinUsHeightConstraint.constant = 115
            joinUsView.isHidden = false
        }
        tableView.reloadData()
    }
}
