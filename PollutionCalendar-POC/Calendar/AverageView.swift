//
//  AverageView.swift
//  PollutionCalendar-POC
//
//  Created by Kimchheang on 9/12/19.
//  Copyright © 2019 Kimchheang. All rights reserved.
//

import UIKit

class AverageView: UIView {
    
    @IBOutlet weak var aqiIndicatorView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupView()
    }
    
    // MARK: - Private
    private func setupView() {
        layer.cornerRadius = 4
        layer.masksToBounds = true
        
        aqiIndicatorView.layer.cornerRadius = 4
        aqiIndicatorView.layer.masksToBounds = true
        aqiIndicatorView.backgroundColor = PollutionType.sensitiveGroup.getMainColor()
    }
}
