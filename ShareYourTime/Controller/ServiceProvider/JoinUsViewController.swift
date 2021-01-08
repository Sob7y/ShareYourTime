//
//  JoinUsViewController.swift
//  ShareYourTime
//
//  Created by Mohammed Khaled on 11/4/19.
//  Copyright © 2019 ShareYourTime. All rights reserved.
//

import UIKit

class JoinUsViewController: BaseViewController {

    @IBOutlet private weak var joinUsContainerView: UIView!
    @IBOutlet private weak var categoryContainerView: UIView!
    @IBOutlet private weak var termsContainerView: UIView!
    
    @IBOutlet private weak var joinUsLabel: UILabel!
    @IBOutlet private weak var provideServiceLabel: UILabel!
    @IBOutlet private weak var categoryLabel: UILabel!
    @IBOutlet private weak var selectedCategoryLabel: UILabel!
    @IBOutlet private weak var termsAndConditionLabel: UILabel!
    @IBOutlet private weak var termsAndConditionTextView: UITextView!
    @IBOutlet private weak var submitButton: UIButton!
    @IBOutlet private weak var titleLabel: UILabel!
    
    var tap: UITapGestureRecognizer!

    var presenter: JoinUsPresenter?
    var termsAndCondition: String?
    var categoriesArray: [CategoryModel] = []
    var categoryModel: CategoryModel? {
        didSet {
            fillDate()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        getCategories()
        setupTapRecognizer()
    }
    
    private func setupView() {
        presenter = JoinUsPresenterImp(view: self)
        
        joinUsLabel.text = "join_us".localized
        provideServiceLabel.text = "provide_service".localized
        categoryLabel.text = "category".localized
        termsAndConditionLabel.text = "your_terms".localized
        selectedCategoryLabel.text = "choose_category".localized
        submitButton.setTitle("submit".localized, for: .normal)
        
        joinUsContainerView.layer.masksToBounds = true
        joinUsContainerView.layer.cornerRadius = 8
        
        termsContainerView.layer.masksToBounds = true
        termsContainerView.layer.cornerRadius = 8
        termsContainerView.layer.borderColor = UIColor.lightGray.cgColor
        termsContainerView.layer.borderWidth = 1
        
        submitButton.layer.masksToBounds = true
        submitButton.layer.cornerRadius = 20
    }

    private func fillDate() {
        if Defaults.sharedInstance.applicationLanguage == Langugage.arabic {
            selectedCategoryLabel.text = categoryModel?.nameAr
        } else {
            selectedCategoryLabel.text = categoryModel?.nameEn
        }
    }
    
    func getCategories() {
        presenter?.getCategories()
    }
    
    @IBAction func selectCategoryAction() {
        if !categoriesArray.isEmpty {
            let categoriesView = ServiceProviderViewController(nibName: nil, bundle: nil)
            categoriesView.categoriesArray = self.categoriesArray
            categoriesView.delegate = self
            self.presentPanModal(categoriesView)
        }
    }
    
    @IBAction func backButtonAction() {
        closeView()
//        self.navigationController?.popViewController(animated: true)
    }
    
    func closeView() {
        let transition = CATransition()
        transition.duration = 0.5
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.default)
        transition.type = CATransitionType.moveIn
        transition.subtype = CATransitionSubtype.fromBottom
        navigationController?.view.layer.add(transition, forKey: nil)
        _ = navigationController?.popViewController(animated: false)
    }
    
    private func setupTapRecognizer() {
        tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))

        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        tap.cancelsTouchesInView = false

        view.addGestureRecognizer(tap)
    }
    
    @objc
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    @IBAction func submitAction() {
        guard let model = categoryModel else {
            return self.showError(message: "choose_category".localized)
        }
        guard let text = self.termsAndConditionTextView.text, !text.isEmpty else {
            return self.showError(message: "fill_your_terms".localized)
        }
        
        presenter?.joinUs(category: model.id ?? 0, terms: text)
    }
}

extension JoinUsViewController: SelectCategoryDelegate {
    func categorySelected(_ categoryModel: CategoryModel) {
        self.categoryModel = categoryModel
    }
}

extension JoinUsViewController: JoinUsView {
    func requestDone() {
        closeView()
//        self.navigationController?.popViewController(animated: true)
    }
    
    func didInsertCategories(_ categoriesResponse: SPCategoryResponse) {
        categoriesArray = categoriesResponse.data ?? []
    }
}
