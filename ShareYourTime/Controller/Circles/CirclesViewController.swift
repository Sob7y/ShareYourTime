//
//  CirclesViewController.swift
//  ShareYourTime
//
//  Created by Mohammed Khaled on 8/5/19.
//  Copyright © 2019 ShareYourTime. All rights reserved.
//

import UIKit

class CirclesViewController: BaseViewController {

    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var titleLbl: UILabel!
    @IBOutlet private weak var descLbl: UILabel!
    @IBOutlet private weak var editButton: UIButton!
    
    var presenter: CirclesPresenter!
    var circlesData: [CirclesData] = []
    
    var page = 1
    var limit = 200

    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getData()
    }
    private func setupView() {
        titleLbl.text = "circles".localized
        descLbl.text = "manage_circles".localized
    }
    
    private func getData()  {
        presenter = CirclesPresenterImp(view: self)
        presenter.getCircles(page: page, limit: limit)
    }
    
    private func registerCells() {
        self.tableView.register(
            UINib(nibName: CircleTableViewCell.identifier, bundle: nil),
            forCellReuseIdentifier: CircleTableViewCell.identifier)
    }
    
    @IBAction func backButtonAction() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func createCircleButtonClicked() {
        self.performSegue(withIdentifier: Constant.segues.push_create_circle, sender: nil)
    }
    
    @IBAction func editCircleButtonClicked() {
        if tableView.isEditing {
            tableView.setEditing(false, animated: false)
            editButton.setTitle("edit".localized, for: .normal)
        } else {
            tableView.setEditing(true, animated: false)
            editButton.setTitle("done".localized, for: .normal)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constant.segues.push_view_circle {
            let destination = segue.destination as! ViewCircleViewController
            destination.circleData = sender as? CirclesData
        }
    }
}

extension CirclesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return circlesData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CircleTableViewCell.identifier, for: indexPath) as? CircleTableViewCell else { return UITableViewCell() }
        
        cell.circleData = self.circlesData[indexPath.row]
        
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            deleteCircle(circlesData[indexPath.row])
            self.circlesData.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    func deleteCircle(_ circle: CirclesData) {
        presenter.deleteCircle(id: circle.circle?.id ?? 0)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let circleData = self.circlesData[indexPath.row]
        self.performSegue(withIdentifier: Constant.segues.push_view_circle, sender: circleData)
    }    
}

extension CirclesViewController: CirclesView {
    func didInsertData(_ response: CirclesResponse) {
        circlesData = response.data ?? []
        self.tableView.reloadData()
    }
}
