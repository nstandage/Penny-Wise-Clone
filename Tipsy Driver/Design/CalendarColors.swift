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
    
    static let inMonthDark = UIColor(displayP3Red: 220/255, green: 220/255, blue: 220/255, alpha: 1.0)// light gray
    static let outMonthDark = UIColor(displayP3Red: 110/255, green: 110/255, blue: 110/255, alpha: 1.0) //Darkgrey
    static let todayDark = UIColor(displayP3Red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)// white
    static let dataDark = UIColor(displayP3Red: 0, green: 137/255, blue: 232/255, alpha: 1.0)// blue
    static let selectedDark = UIColor(displayP3Red: 220/255, green: 220/255, blue: 220/255, alpha: 1.0)// light gray
    
    static let backgroundDark = UIColor(displayP3Red: 49/255, green: 50/255, blue: 52/255, alpha: 1.0)
    static let backgroundTrueBlack = UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 1.0)
    
    
    
}

enum CalendarThemeColors {
    case blue
    case green
    case red
    case black
    case purpleRed
    case blueGrey
    case dark
    case trueBlack

    var color: UIColor {
        
        switch self {
        case .blue: return UIColor(displayP3Red: 0, green: 137/255, blue: 232/255, alpha: 1.0)//blue theme
        case .green: return UIColor(displayP3Red: 0, green: 200/255, blue: 116/255, alpha: 1.0)//green theme
        case .red: return UIColor(displayP3Red: 230/255, green: 0, blue: 50/255, alpha: 1.0)//red theme
        case .black: return UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 1.0)//black theme
        case .purpleRed: return UIColor(displayP3Red: 134/255, green: 42/255, blue: 104/255, alpha: 1.0)
        case .blueGrey: return UIColor(displayP3Red: 46/255, green: 70/255, blue: 99/255, alpha: 1.0)
        case .dark: return UIColor(displayP3Red: 49/255, green: 50/255, blue: 52/255, alpha: 1.0)
        case .trueBlack: return UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 1.0)
        }
    }
    
}
