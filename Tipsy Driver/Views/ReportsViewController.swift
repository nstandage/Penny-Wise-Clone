//
//  ReportsViewController.swift
//  Tipsy Driver
//
//  Created by Nathan Standage on 6/28/18.
//  Copyright © 2018 Nathan Standage. All rights reserved.
//

import UIKit

class ReportsViewController: UIViewController {
    @IBOutlet weak var ExportCSVButton: UIButton!
    
    var dataSource: DataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func backButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    

    @IBAction func exportCSV() {
        let fileName = "exportedCSV.csv"
        let path = NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(fileName)
        let entries = dataSource.fetchEntries()
        var text = "Date, Tips, Hours\n"
        
        guard let unwrappedEntries = entries else {
            CalendarError.presentErrorWith(title: .exportError, message: .exportError, view: self)
            return
        }
        
        for entry in unwrappedEntries {
            let newLine = "\(Helper.removeTimeStamp(fromDate: entry.date!)), \(entry.tips), \(entry.hours)\n"
            text.append(newLine)
        }
        
        do {
            
            try text.write(to: path!, atomically: true, encoding: String.Encoding.utf8)
        } catch {
            print(error)
            CalendarError.presentErrorWith(title: .exportError, message: .exportError, view: self)
        }
            // Lets the CSV be shared
        let vc = UIActivityViewController(activityItems: [path], applicationActivities: [])
        present(vc, animated: true, completion: nil)
    }
    
    
}

