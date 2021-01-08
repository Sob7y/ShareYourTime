//
//  TopCountriesCell.swift
//  ShareYourTime
//
//  Created by Mohammed Khaled on 11/9/19.
//  Copyright © 2019 ShareYourTime. All rights reserved.
//

import UIKit

class TopCountriesCell: UITableViewCell {

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var collectionView: UICollectionView!
    
    var countries: [CountryModel] = [] {
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
            UINib(nibName: TopCountriesCollectionViewCell.identifier,
              bundle: nil),
            forCellWithReuseIdentifier: TopCountriesCollectionViewCell.identifier)
        
        setupCollectionViewLayout()
        
        titleLabel.text = "more_entertainment".localized
    }
    
    private func setupCollectionViewLayout() {
        let cellWidth = CGFloat(300)
        let cellheight = CGFloat(260)
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

extension TopCountriesCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return countries.count
    }
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: TopCountriesCollectionViewCell.identifier,
            for: indexPath as IndexPath) as? TopCountriesCollectionViewCell
            else { return UICollectionViewCell() }
        
        cell.country = countries[indexPath.item]
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}
