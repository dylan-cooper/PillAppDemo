//
//  ScheduleTableViewController.swift
//  iOSTest
//
//  Created by Brandon Chester on 2017-11-04.
//  Copyright © 2017 Brandon Chester. All rights reserved.
//

import UIKit

class ScheduleTableViewController: UITableViewController, MedicationUpdateObserver{

    var formatter = DateFormatter()
    var timeFormatter = DateFormatter()
    var dates = [Date]()
    
    var medications = [Date : [Medication]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ScheduleData.shared.register(observer: self)
        timeFormatter.timeStyle = .short
        populateData()
    }
    
    override func willMove(toParentViewController parent: UIViewController?) {
        if parent == nil {
            ScheduleData.shared.remove(observer: self)
        }
    }

    deinit {
        print("Goodbye schedule table.")
    }
    
    private func populateData() {
        let today = Date()
        var currentDate = Calendar.current.date(byAdding: .year, value: -1, to: today)!
        let endDate = Calendar.current.date(byAdding: .year, value: 1, to: today)!
        while Calendar.current.compare(currentDate, to: endDate, toGranularity: .day) == .orderedAscending {
            // Get the day of the week
            let dayOfWeekComponent = Calendar.current.component(.weekday, from: currentDate) - 1
            let currentDayOfWeek = DateOptions(rawValue: 1 << dayOfWeekComponent)
            for med in ScheduleData.shared.items {
                if med.days.contains(currentDayOfWeek) {
                    if Calendar.current.compare(med.time, to: currentDate, toGranularity: .day) != .orderedDescending {
                        if med.endDate == nil || Calendar.current.compare(med.endDate!, to: currentDate, toGranularity: .day) != .orderedAscending {
                            if medications[currentDate] == nil {
                                // Add entry to table view section data source.
                                dates.append(currentDate)
                                // Add array for medications to row data source.
                                medications[currentDate] = [Medication]()
                            }
                            medications[currentDate]!.append(med)
                        }
                    }
                }
            }
            currentDate = Calendar.current.date(byAdding: .day, value: 1, to: currentDate)!
        }
        for item in medications {
            // Sort the medications for each day
            medications[item.key] = item.value.sorted { (first, second) -> Bool in
                let firstHour = Calendar.current.component(.hour, from: first.time)
                let secondHour = Calendar.current.component(.hour, from: second.time)
                if firstHour < secondHour {
                    return true
                } else if firstHour > secondHour {
                    return false
                } else {
                    let firstMin = Calendar.current.component(.minute, from: first.time)
                    let secondMin = Calendar.current.component(.minute, from: second.time)
                    if firstMin > secondMin {
                        return false
                    }
                    return true
                }
            }
        }
    }
    
    func medicationsDidUpdate() {
        dates = [Date]()
        medications = [Date : [Medication]]()
        populateData()
        tableView.reloadData()
    }

    override func viewWillAppear(_ animated: Bool) {
        if let index = dates.index(where: { return Calendar.current.compare(Date(), to: $0, toGranularity: .day) == .orderedSame }) {
            tableView.scrollToRow(at: IndexPath(row: 0, section: index), at: .top, animated: false)
        } else if let index = dates.index(where: { return Calendar.current.compare(Date(), to: $0, toGranularity: .weekOfMonth) == .orderedSame }) {
            tableView.scrollToRow(at: IndexPath(row: 0, section: index), at: .top, animated: false)
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return dates.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let date = dates[section]
        return medications[date]!.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "scheduleCell", for: indexPath) as! ScheduleTableViewCell
        let date = dates[indexPath.section]
        let medication = medications[date]![indexPath.row]
        cell.titleLabel.text = medication.name
        cell.timeLabel.text = timeFormatter.string(from: medication.time)
        switch medication.type {
        case .event:
            cell.separator.backgroundColor = UIColor.pillRed
        case .meeting:
            cell.separator.backgroundColor = UIColor.pillGreen
        case .medication:
            cell.separator.backgroundColor = UIColor.pillBlue
        }
        return cell
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if Calendar.current.compare(Date(), to: dates[section], toGranularity: .year) == .orderedSame {
            formatter.dateFormat = "EE  MMM dd"
        } else {
            formatter.dateFormat = "EE  MMM dd YYY"
        }
        return formatter.string(from: dates[section])
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        if Calendar.current.isDateInToday(dates[section]) {
            header.textLabel?.textColor = UIColor.pillBlue
        } else {
            header.textLabel?.textColor = UIColor.black
        }
        header.textLabel?.font = UIFont.boldSystemFont(ofSize: 14)
    }
}
