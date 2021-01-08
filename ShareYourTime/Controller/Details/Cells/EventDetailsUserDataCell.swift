//
//  EventDetailsUserDataCell.swift
//  ShareYourTime
//
//  Created by Maha Khaled on 3/20/19.
//  Copyright © 2019 ShareYourTime. All rights reserved.
//

import UIKit

class EventDetailsUserDataCell: UITableViewCell {

    @IBOutlet weak private var containerView: UIView!
    @IBOutlet weak private var userImageContainerView: UIView!
    @IBOutlet weak private var eventOwnerNameLabel: UILabel!
    @IBOutlet weak private var eventDayLebel: UILabel!
    @IBOutlet weak private var eventTimeLabel: UILabel!
    @IBOutlet weak private var eventTitleLabel: UILabel!
    @IBOutlet weak private var eventOwnerImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func bind(_ event: EventModel) {
        eventTitleLabel.text = event.title
        
        let eventDate = Date(timeIntervalSince1970: event.holdDate ?? 0)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm" //Specify your format that you want
        let strDate = dateFormatter.string(from: eventDate)
        eventTimeLabel.text = strDate
        eventDayLebel.text = eventDate.getDayName()
        
        if let name = event.createdBy?.name {
            eventOwnerNameLabel.text = name
        }
        
        if let image = event.createdBy?.image {
            let url = ApiUrls.base_url + image
            eventOwnerImage.sd_setImage(with: URL(string: (url)))
        }
        
        eventOwnerImage.layer.cornerRadius = 26
        eventOwnerImage.layer.masksToBounds = true
        userImageContainerView.layer.cornerRadius = 30
        userImageContainerView.layer.masksToBounds = true
    }

}
