//
//  ReportsTableViewController.swift
//  Tipsy Driver
//
//  Created by Nathan Standage on 7/31/18.
//  Copyright © 2018 Nathan Standage. All rights reserved.
//

import UIKit

class ReportsTableViewController: UITableViewController {

    var dataSource: DataSource!
    var entries: [Entry]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        entries = dataSource.fetchEntries()
        print(entries.count)
        return entries.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if entries == nil {
            print("ENTRIES was equal to nil")
            fatalError()
        }
        
        let cell = Bundle.main.loadNibNamed("ReportsCell", owner: self, options: nil)?.first as! ReportsCell
        let currentEntry = entries[indexPath.row]
        
        cell.hoursLabel.text = String(currentEntry.hours)
        cell.tipsLabel.text = Calculate.format(number: currentEntry.tips)
        cell.dateLabel.text = CalendarFormatter.formatWith(date: currentEntry.date!, style: .display)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
    }

    @IBAction func exportButton(_ sender: UIBarButtonItem) {
        let fileName = "exported_tip_data.csv"
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
    
    @IBAction func doneButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
