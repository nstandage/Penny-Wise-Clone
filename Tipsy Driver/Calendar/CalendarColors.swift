//
//  CalendarColors.swift
//  Tipsy Driver
//
//  Created by Nathan Standage on 11/22/17.
//  Copyright © 2017 Nathan Standage. All rights reserved.
//

import UIKit


class CalendarColors {

    //static let inMonth = UIColor(displayP3Red: 93/255, green: 93/255, blue: 93/255, alpha: 1.0) //Dark
    static let inMonth = UIColor(displayP3Red: 110/255, green: 110/255, blue: 110/255, alpha: 1.0) //Darkgrey
    static let outMonth = UIColor(displayP3Red: 220/255, green: 220/255, blue: 220/255, alpha: 1.0)// light gray
    static let today = UIColor(displayP3Red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)// white
    static let data = UIColor(displayP3Red: 0, green: 137/255, blue: 232/255, alpha: 1.0)// blue
    static let selected = UIColor(displayP3Red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)//white
    
}

enum CalendarThemeColors {
    case blue
    case green
    case red
    case black
    case purpleRed
    case blueGrey
    
    var color: UIColor {
        
        switch self {
        case .blue: return UIColor(displayP3Red: 0, green: 137/255, blue: 232/255, alpha: 1.0)//blue theme
        case .green: return UIColor(displayP3Red: 0, green: 200/255, blue: 116/255, alpha: 1.0)//green theme
        case .red: return UIColor(displayP3Red: 230/255, green: 0, blue: 50/255, alpha: 1.0)//red theme
        case .black: return UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 1.0)//black theme
        case .purpleRed: return UIColor(displayP3Red: 134/255, green: 42/255, blue: 104/255, alpha: 1.0)
        case .blueGrey: return UIColor(displayP3Red: 46/255, green: 70/255, blue: 99/255, alpha: 1.0)
        }
    }
    
}
