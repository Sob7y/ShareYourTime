//
//  CreateEventDateCell.swift
//  ShareYourTime
//
//  Created by Mohammed Khaled (Sob7y) on 2/16/19.
//  Copyright © 2019 ShareYourTime. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

protocol CreateEventDateDelegate: class {
    func setDate(day: DayModel)
}

class CreateEventDateCell: UITableViewCell {

    @IBOutlet weak var textfield: UITextField!
    @IBOutlet weak var titleLbl: UILabel!
    
    @IBOutlet weak var todayBtn: UIButton!
    @IBOutlet weak var tomorrowBtn: UIButton!
    @IBOutlet weak var dayAfterTomorrowBtn: UIButton!
    @IBOutlet weak var setTimeBtn: UIButton!
    
    weak var delegate: CreateEventDateDelegate?
    var todayModel: DayModel!
    var tomorrowModel: DayModel!
    var dayAfterTomorrowModel: DayModel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setup()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup() {
        getDays()
        todayBtn.setTitle(todayModel.name, for: .normal)
        tomorrowBtn.setTitle(tomorrowModel.name, for: .normal)
        dayAfterTomorrowBtn.setTitle(dayAfterTomorrowModel.name, for: .normal)
    }
    
    func bind() {
        titleLbl.text = Strings.sharedInstance.timeTitle
        textfield.placeholder = Strings.sharedInstance.timePlaceholder
    }


    @IBAction func setDate(_ sender: UIButton) {
        switch sender.tag {
        case 20:
            selectBtn(todayBtn)
            unSelectBtn(tomorrowBtn)
            unSelectBtn(dayAfterTomorrowBtn)
            bindDay(day: todayModel)
        case 21:
            selectBtn(tomorrowBtn)
            unSelectBtn(todayBtn)
            unSelectBtn(dayAfterTomorrowBtn)
            bindDay(day: tomorrowModel)
        case 22:
            selectBtn(dayAfterTomorrowBtn)
            unSelectBtn(todayBtn)
            unSelectBtn(tomorrowBtn)
            bindDay(day: dayAfterTomorrowModel)
        default:
            break
        }
    }
    
    private func selectBtn(_ btn: UIButton) {
        btn.backgroundColor = UIColor.uclaBlue
        btn.setTitleColor(.white, for: .normal)
    }
    private func unSelectBtn(_ btn: UIButton) {
        btn.backgroundColor = .clear
        btn.setTitleColor(UIColor.uclaBlue, for: .normal)
    }
    
    private func bindDay(day: DayModel){
        delegate?.setDate(day: day)
    }
    
    private func getDays() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let todayDate = Date()
        let tomorrowDate = Date().tomorrow
        let dayAfterTomorrowDate = Date().afterTomorrow
        
        let dayAfterTomorrowName = Date().afterTomorrow.getShortDayName()
        
        todayModel = DayModel(Strings.sharedInstance.todayTitle, dateFormatter.string(from: todayDate), true, getDateTimestamp(todayDate))
        tomorrowModel = DayModel(Strings.sharedInstance.tomorrowTitle, dateFormatter.string(from: tomorrowDate), false, getDateTimestamp(tomorrowDate))
         dayAfterTomorrowModel = DayModel(dayAfterTomorrowName, dateFormatter.string(from: dayAfterTomorrowDate), false, getDateTimestamp(dayAfterTomorrowDate))
        
    }
    
    func getDateTimestamp(_ date: Date)->String {
        let myTimeStamp = Int(date.timeIntervalSince1970)
        return String(myTimeStamp)
    }
}

extension CreateEventDateCell: UITextFieldDelegate {
    
}

