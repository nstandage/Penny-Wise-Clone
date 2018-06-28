//
//  CalendarDisplay.swift
//  Tipsy Driver
//
//  Created by Nathan Standage on 1/17/18.
//  Copyright © 2018 Nathan Standage. All rights reserved.
//

import Foundation
import UIKit
import JTAppleCalendar

enum CellStyle {
    case data
    case selected
    case today
    case inMonth
    case outMonth
    case todaySelected
    case todayData
    
    var image: UIImage? {
        switch self {
        case .today, .todayData, .todaySelected: return #imageLiteral(resourceName: "today_circle")
        case .data, .inMonth, .outMonth, .selected: return nil
        }
    }
    
    var textColor: UIColor {
        switch self {
        case .inMonth, .today: return CalendarColors.inMonth
        case .outMonth: return CalendarColors.outMonth
        case .todaySelected: return CalendarColors.today
        case .selected: return CalendarColors.selected
        case .data, .todayData: return CalendarColors.data
        }
    }
}

class CalendarDisplay {

    static func setDisplayFor(cell: JTAppleCell, cellState: CellState, dataSource: DataSource, selectedCellStates: [CellState]) {
        // out month?
        let isThisMonth = doesDateBelongToCurrentMonth(cellState: cellState)
        //Data?
        let doesHaveData = dataSource.doesCellHaveData(cellState: cellState)
        //Today?
        let isDateToday = Helper.isCellToday(cellState: cellState)
        
        // Selected?
        let isSelected = Helper.isDateSelected(selectedStates: selectedCellStates, stateInQuestion: cellState)
        
        setCellStyleFor(cell: cell, data: doesHaveData, today: isDateToday, selected: isSelected, inMonth: isThisMonth)
    }
    private static func setCellStyleFor(cell: JTAppleCell, data: Bool, today: Bool, selected: Bool, inMonth: Bool) {
        
        //outMonth
        if inMonth == false {
            setDisplayForGivenCell(cell: cell, style: .outMonth)
            return
        }
        
        //inMonth
        if data == false && today == false && selected == false {
            setDisplayForGivenCell(cell: cell, style: .inMonth)
            return
        }
        
        //data
        if data == true && today == false && selected == false {
            setDisplayForGivenCell(cell: cell, style: .data)
            return
        }
        
        // selected
        if today == false && selected == true {
            setDisplayForGivenCell(cell: cell, style: .selected)
            return
        }
        
        //Today
        if data == false && today == true && selected == false {
            setDisplayForGivenCell(cell: cell, style: .today)
            return
        }
        //Today Selected
        if today == true && selected == true {
            setDisplayForGivenCell(cell: cell, style: .todaySelected)
            return
            
        }
        //Today Data
        if data == true && today == true {
            setDisplayForGivenCell(cell: cell, style: .todayData)
            return
        }
        
        print("YOU'RE MISSING SOMETHING!!! THE DISPLAY CELL ISN'T FUNTIONING PROPERLY!!!!")
        
    }
    
    private static func doesDateBelongToCurrentMonth(cellState: CellState) -> Bool {
        if cellState.dateBelongsTo == .thisMonth {
            return true
        } else {
            return false
        }
    }
    
    
    
    private static func setDisplayForGivenCell(cell: JTAppleCell, style: CellStyle) {
        
        let calCell = castAppleCellToCalendarCell(cell: cell)
        var isSelected = false
        
        switch style {
        case .outMonth:
            calCell.dateLabel.textColor = CellStyle.outMonth.textColor
            calCell.dateLabel.font = UIFont.systemFont(ofSize: 17)
            calCell.todayIndicator.image = CellStyle.outMonth.image
        case .inMonth:
            calCell.dateLabel.textColor = CellStyle.inMonth.textColor
            calCell.dateLabel.font = UIFont.systemFont(ofSize: 17)
            calCell.todayIndicator.image = CellStyle.inMonth.image
        case .data:
            calCell.dateLabel.textColor = Helper.setTextColor()
            calCell.dateLabel.font = UIFont.boldSystemFont(ofSize: 19)
            calCell.todayIndicator.image = CellStyle.data.image
        case .today:
            calCell.dateLabel.textColor = CellStyle.today.textColor
            calCell.dateLabel.font = UIFont.systemFont(ofSize: 17)
            calCell.todayIndicator.image = CellStyle.today.image
        case .selected:
            calCell.dateLabel.textColor = CellStyle.selected.textColor
            calCell.dateLabel.font = UIFont.boldSystemFont(ofSize: 19)
            calCell.todayIndicator.image = CellStyle.selected.image
            isSelected = true
        case .todaySelected:
            calCell.dateLabel.textColor = CellStyle.todaySelected.textColor
            calCell.dateLabel.font = UIFont.boldSystemFont(ofSize: 19)
            calCell.todayIndicator.image = CellStyle.todaySelected.image
            isSelected = true
        case .todayData:
            calCell.dateLabel.textColor = Helper.setTextColor()
            calCell.dateLabel.font = UIFont.boldSystemFont(ofSize: 19)
            calCell.todayIndicator.image = CellStyle.todayData.image
        }
        
        if isSelected == true {
          Helper.setSelectedCircleView(calCell.selectedCircleView)
        } else {
           calCell.selectedCircleView.isHidden = true
        }
    }
    
    //HELPER METHODS
    private static func castAppleCellToCalendarCell(cell: JTAppleCell) -> CalendarCell {
        guard let calCell = cell as? CalendarCell else {
            //ERROR HANDLING
            print("Casting apple cell to calendar cell failed")
            fatalError()
        }
        return calCell
    }


}
