//
//  LoginViewController.swift
//  ShareYourTime
//
//  Created by Mohammed Khaled (Sob7y) on 1/25/19.
//  Copyright © 2019 ShareYourTime. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import FacebookLogin

class LoginViewController: BaseViewController {

    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var signupBtn: UIButton!
    
    var socialObject = SocialObject()
    var presenter: LoginPresenter!
    var imageData: String!
    var email: String?
    var password: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        localizeView()
        presenter = LoginPresenterImp(view: self)
    }
    
    func localizeView() {
        signupBtn.setTitle(Strings.sharedInstance.doesNothaveAccountSignup, for: .normal)
    }
    
    @IBAction func pushSignup() {
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: Constant.segues.push_signup, sender: nil)
        }
    }
    
    @IBAction func normalLogin() {
        self.view.endEditing(true)
        guard let email = self.email, self.validateEmail(email) else { return self.showError(message: Strings.sharedInstance.emailIsMandatory) }
        guard let password = self.password else { return self.showError(message: Strings.sharedInstance.passwordIsMandatory) }
        presenter.login(password: password, email: email)
    }
    
    @IBAction func forgetPassword() {
        
    }
    
    @IBAction func facebookLogin() {
        //        self.showLoading()
        let loginManager = LoginManager()
        loginManager.logOut()
        loginManager.loginBehavior = .browser
        loginManager.logIn(permissions: [.publicProfile, .email], viewController: self) { (loginResult) in
            switch loginResult {
            case .failed(let error):
                self.hideLoading()
                print(error)
            case .cancelled:
                self.hideLoading()
                print("User cancelled login.")
            case .success:
                self.showLoading()
                _ = GraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email"]).start(completionHandler: { (connection, result, error) in
                    let dictionary = result as! NSDictionary
                    print(dictionary)
                    self.fillFacebookSocialData(socialValDict: dictionary)
                })
            }
        }
    }
    
    func fillFacebookSocialData(socialValDict:NSDictionary) -> Void {
        self.hideLoading()
        socialObject.email = socialValDict["email"] as? String
        socialObject.userName = socialValDict["name"] as? String
        socialObject.socialId = socialValDict["id"] as? String
        socialObject.gender = socialValDict["gender"] as? String
        
        let picture =  socialValDict["picture"] as? NSDictionary
        let data =  picture?["data"] as? NSDictionary
        let userImage = (data?["url"]) as? String
        
        do {
            imageData =  userImage
        } catch {
            
        }

        presenter.fbLogin(socialName: socialObject.userName, socialId: socialObject.socialId, name: socialObject.userName, email: socialObject.email, image: imageData)
    }
    
    private func pushMainView() {
        self.performSegue(withIdentifier: Constant.segues.push_main, sender: nil)
    }

    func validateEmail(_ candidate: String) -> Bool {
        // Regex source and more information here: http://emailregex.com
        
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: candidate)
    }
}

extension LoginViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case loginCells.email.rawValue:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "TextFieldCell", for: indexPath) as? TextFieldCell else { return UITableViewCell() }
            
            cell.setupEmailField()
            cell.delegate = self
            
            cell.selectionStyle = .none
            return cell
        case loginCells.password.rawValue:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "TextFieldCell", for: indexPath) as? TextFieldCell else { return UITableViewCell() }
            
            cell.setupPasswordField()
            cell.delegate = self
            cell.hideError = true
            
            cell.selectionStyle = .none
            return cell
        case loginCells.login.rawValue:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "NormalLoginCell", for: indexPath) as? NormalLoginCell else { return UITableViewCell() }
            
            cell.loginBtn.addTarget(self, action: #selector(normalLogin), for: .touchUpInside)
            cell.forgetPassBtn.addTarget(self, action: #selector(forgetPassword), for: .touchUpInside)
            cell.bind()
            
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            return cell
        case loginCells.fbLogin.rawValue:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "FacebookLoginCell", for: indexPath) as? FacebookLoginCell else { return UITableViewCell() }
            
            cell.fbLoginBtn.addTarget(self, action: #selector(facebookLogin), for: .touchUpInside)
            cell.bind()
            
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            return cell
        default:
            let cell = UITableViewCell()
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case loginCells.empty.rawValue:
            return 150
        case loginCells.login.rawValue:
            return 120
        case loginCells.fbLogin.rawValue:
            return 70
        default:
            return 80
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            self.view.endEditing(true)
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
    
}

extension LoginViewController: TextFieldCellDelagete {
    func setPhone(_ phone: String) {
        
    }
    
    func setName(_ name: String) {
        
    }
    
    func setEmail(_ email: String) {
        self.email = email
    }
    
    func setPassword(_ password: String) {
        self.password = password
    }
    
    func setConfirmPassword(_ confirmPassword: String) {
        
    }
    
    func setPasswordTextField(_ textfield: UITextField) {
        
    }
    
    func setConfirmPasswordTextField(_ textfield: UITextField) {
        
    }
    
    
}

extension LoginViewController: LoginView {
    func didLoginAction(_ loginResponse: LoginResponse) {        
        self.performSegue(withIdentifier: Constant.segues.push_main, sender: nil)
    }
    
}
