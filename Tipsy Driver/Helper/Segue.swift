//
//  Segue.swift
//  Tipsy Driver
//
//  Created by Nathan Standage on 11/30/17.
//  Copyright © 2017 Nathan Standage. All rights reserved.
//

import Foundation
import UIKit




class Segue {
    
    static func prepareWith(segue: Segue, view: UIViewController) {
        // code...
    }
}

enum SegueIdentifier: String {
    
    case moreButtonSegue
    case detailSegue
    case addItem
    case settings
    case settingsTheme
    case settingsIcon
    case settingsHourlyWage
    case settingsTutorial
    case settingsTipDeveloper
    case settingsSendFeedback
    case settingsAbout
}
