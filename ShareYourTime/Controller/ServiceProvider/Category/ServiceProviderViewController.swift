//
//  ServiceProviderViewController.swift
//  ShareYourTime
//
//  Created by Mohammed Khaled on 11/8/19.
//  Copyright © 2019 ShareYourTime. All rights reserved.
//

import UIKit
import PanModal

protocol SelectCategoryDelegate: class {
    func categorySelected(_ categoryModel: CategoryModel)
}
class ServiceProviderViewController: BaseViewController {

    @IBOutlet private weak var tableView: UITableView!
    
    weak var delegate: SelectCategoryDelegate?
    var categoriesArray: [CategoryModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCell()
    }
    
    private func registerCell() {
        self.tableView.register(
        UINib(nibName: SPCategoryCell.identifier, bundle: nil),
        forCellReuseIdentifier: SPCategoryCell.identifier)
    }

}

extension ServiceProviderViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoriesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SPCategoryCell.identifier, for: indexPath) as? SPCategoryCell else { return UITableViewCell() }
        
        cell.categoryModel = categoriesArray[indexPath.row]
        
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.categorySelected(categoriesArray[indexPath.row])
        self.dismiss(animated: true)
    }
    
}

extension ServiceProviderViewController: PanModalPresentable {
    var panScrollable: UIScrollView? {
        return tableView
    }
    
    var longFormHeight: PanModalHeight {
        let contentHight = CGFloat(categoriesArray.count * 55)
        return .contentHeight(contentHight)
    }
    
    var anchorModalToLongForm: Bool {
        return true
    }
}
