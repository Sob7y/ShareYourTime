//
//  LatestEventsCell.swift
//  ShareYourTime
//
//  Created by Mohammed Khaled on 11/9/19.
//  Copyright © 2019 ShareYourTime. All rights reserved.
//

import UIKit

protocol LatestEventsDelegate: class {
    func eventClicked(with event: ExploreEventModel)
}
class LatestEventsCell: UITableViewCell {

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var collectionView: UICollectionView!
    
    var delegate: LatestEventsDelegate?
    
    var events: [ExploreEventModel] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
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
        
        self.collectionView.register(
            UINib(nibName: LatestEventsCollectionViewCell.identifier,
              bundle: nil),
            forCellWithReuseIdentifier: LatestEventsCollectionViewCell.identifier)
        
        setupCollectionViewLayout()
        
        titleLabel.text = "trips".localized
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
    
}

extension LatestEventsCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return events.count
    }
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: LatestEventsCollectionViewCell.identifier,
            for: indexPath as IndexPath) as? LatestEventsCollectionViewCell
            else { return UICollectionViewCell() }
        
        cell.event = events[indexPath.item]
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.eventClicked(with: events[indexPath.item])
    }
}
