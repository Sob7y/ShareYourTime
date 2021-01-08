//
//  CircleTableViewCell.swift
//  ShareYourTime
//
//  Created by Mohammed Khaled on 8/5/19.
//  Copyright © 2019 ShareYourTime. All rights reserved.
//

import UIKit

class CircleTableViewCell: UITableViewCell {

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var viewAllLabel: UILabel!
    @IBOutlet private weak var collectionView: UICollectionView!
    
    var circleData: CirclesData? {
        didSet {
            fillData()
            collectionView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.register(UINib(nibName: CircleCollectionViewCell.identifier,
                                           bundle: nil),
                                     forCellWithReuseIdentifier: CircleCollectionViewCell.identifier)
        setupCollectionViewLayout()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func fillData() {
        if let name = circleData?.circle?.name {
            titleLabel.text = name
        }
        viewAllLabel.text = "view_all".localized
    }
    
    func setupCollectionViewLayout() {
        let cellWidth = CGFloat(58)
        let cellheight = CGFloat(58)
        let cellSize = CGSize(width: cellWidth,
                              height: cellheight)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = cellSize
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumLineSpacing = 8.0
        //        layout.minimumInteritemSpacing = 0.0
        collectionView.setCollectionViewLayout(layout, animated: true)
        collectionView.reloadData()
    }
    
    
}

extension CircleTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return circleData?.connections?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CircleCollectionViewCell.identifier,
            for: indexPath as IndexPath) as? CircleCollectionViewCell
            else { return UICollectionViewCell() }
        
        cell.userModel = circleData?.connections?[indexPath.row]
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        
    }
}
