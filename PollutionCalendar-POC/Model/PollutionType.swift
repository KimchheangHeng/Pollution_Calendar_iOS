//
//  PollutionType.swift
//  PollutionCalendar-POC
//
//  Created by Kimchheang on 9/12/19.
//  Copyright © 2019 Kimchheang. All rights reserved.
//

import UIKit

enum PollutionType: Int, CaseIterable {
    case good = 0
    case moderate
    case sensitiveGroup
    case unhealthy
    case veryUnhealthy
    case hazardous
    
    func getMainColor() -> UIColor {
        switch self {
        case .good:
            return UIColor(red: 168/255, green: 224/255 , blue: 95/255, alpha: 1)
        case .moderate:
            return UIColor(red: 253/255, green: 214/255 , blue: 75/255, alpha: 1)
        case .sensitiveGroup:
            return UIColor(red: 255/255, green: 155/255 , blue: 87/255, alpha: 1)
        case .unhealthy:
            return UIColor(red: 254/255, green: 106/255 , blue: 105/255, alpha: 1)
        case .veryUnhealthy:
            return UIColor(red: 169/255, green: 122/255 , blue: 188/255, alpha: 1)
        case .hazardous:
            return UIColor(red: 168/255, green: 115/255 , blue: 131/255, alpha: 1)
        }
    }
}
