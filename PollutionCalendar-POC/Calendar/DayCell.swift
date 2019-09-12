//
//  DayCell.swift
//  PollutionCalendar-POC
//
//  Created by Kimchheang on 9/12/19.
//  Copyright © 2019 Kimchheang. All rights reserved.
//

import UIKit
import JTAppleCalendar

class DayCell: JTACDayCell {
    
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var aqiIndicatorView: UIView!
    @IBOutlet weak var shadowView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupView()
    }
    
    private func setupView() {
        aqiIndicatorView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.1)
    }
    
    func configCell(cellState: CellState, pollutionType: PollutionType) {
        dayLabel.text = cellState.text
        
        if cellState.day == .sunday || cellState.day == .saturday {
            dayLabel.textColor = UIColor.systemRed
        } else {
            dayLabel.textColor = UIColor.label
        }
        
        if Calendar.current.isDateInToday(cellState.date) {
            dayLabel.textColor = UIColor.white
            shadowView.backgroundColor = UIColor(red: 177/255, green: 192/255, blue: 211/255, alpha: 1)
        } else {
            shadowView.backgroundColor = UIColor.clear
        }
        
        
        
        if cellState.dateBelongsTo == .thisMonth {
            dayLabel.textColor = dayLabel.textColor
            aqiIndicatorView.backgroundColor = pollutionType.getMainColor()
        } else {
            dayLabel.textColor = dayLabel.textColor.withAlphaComponent(0.2)
            aqiIndicatorView.backgroundColor = UIColor.clear//lightGray.withAlphaComponent(0.1)
        }
    }
}
