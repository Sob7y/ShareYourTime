//
//  CreateSPDateCell.swift
//  ShareYourTime
//
//  Created by Mohammed Khaled on 11/10/19.
//  Copyright © 2019 ShareYourTime. All rights reserved.
//

import UIKit

protocol CreateSPDateCellDelegate: class {
    func timeSelected()
    func setDays(_ days: [CreateEventDayModel])
}

class CreateSPDateCell: UITableViewCell {
    
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var timeTitleLabel: UILabel!
    @IBOutlet private weak var textField: UITextField!
    
    weak var delegate: CreateSPDateCellDelegate?
    
    var days: [CreateEventDayModel]?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupCell()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    private func setupCell() {
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        days = setupDays()
    }
    
    private func setupCollectionViewLayout() {
        let cellWidth = CGFloat(145)
        let cellheight = CGFloat(200)
        let cellSize = CGSize(width: cellWidth,
                              height: cellheight)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = cellSize
        layout.sectionInset = UIEdgeInsets(top: 1, left: 0, bottom: 1, right: 14)
        layout.minimumLineSpacing = 14.0
        //        layout.minimumInteritemSpacing = 0.0
        collectionView.setCollectionViewLayout(layout, animated: true)
        collectionView.reloadData()
    }
    
    private func setupDays() -> [CreateEventDayModel] {
        var eventDays: [CreateEventDayModel] = []
        
        let saturdayModel = CreateEventDayModel("staurday", "Sat", false)
        let sundayModel = CreateEventDayModel("sunday", "Sun", false)
        let mondayModel = CreateEventDayModel("monday", "Mon", false)
        let tuesdayModel = CreateEventDayModel("tuesday", "Tue", false)
        let wednesdayModel = CreateEventDayModel("wednesday", "Wed", false)
        let thursdayModel = CreateEventDayModel("thursday", "Thu", false)
        let fridayModel = CreateEventDayModel("friday", "Fri", false)
        
        eventDays.append(saturdayModel)
        eventDays.append(sundayModel)
        eventDays.append(mondayModel)
        eventDays.append(tuesdayModel)
        eventDays.append(wednesdayModel)
        eventDays.append(thursdayModel)
        eventDays.append(fridayModel)
        
        self.textField.text = "hours".localized
        
        return eventDays
    }
    
    @IBAction func setTimeAction() {
        delegate?.timeSelected()
    }
    
    func bindTime(_ time: String) {
        self.textField.text = time + " " + "hours".localized
    }
}

extension CreateSPDateCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return days?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CreateEventDayCollectionViewCell.identifier,
            for: indexPath as IndexPath) as? CreateEventDayCollectionViewCell
            else { return UICollectionViewCell() }
        
        if let model = days?[indexPath.row] {
            cell.dayModel = model
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let day = days?[indexPath.row] {
            day.isSelected = !(day.isSelected)
            days?[indexPath.row] = day
            collectionView.reloadItems(at: [indexPath])
//            collectionView.reloadData()
        }
        
        delegate?.setDays(days ?? [])
    }
}
