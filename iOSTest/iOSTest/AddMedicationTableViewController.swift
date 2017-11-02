//
//  AddMedicationTableViewController.swift
//  iOSTest
//
//  Created by Apple on 2017-10-30.
//  Copyright © 2017 Brandon Chester. All rights reserved.
//

import UIKit

class AddMedicationTableViewController: UITableViewController {

    @IBOutlet weak var endRepeatCell: UITableViewCell!
    @IBOutlet weak var repeatCell: UITableViewCell!
    @IBOutlet weak var startDateCell: UITableViewCell!
    @IBOutlet weak var startDatePicker: UIDatePicker!
    var startDateCellHeight:CGFloat = 0
    var endRepeatCellHeight:CGFloat = 0
    
    var endDate:Date? = nil {
        didSet {
            if let date = endDate {
                let formatter = DateFormatter()
                formatter.dateStyle = .medium
                endRepeatCell.detailTextLabel?.text = formatter.string(from: date)
            } else {
                endRepeatCell.detailTextLabel?.text = "Never"
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let endRepeatVC = segue.destination as? MedicationEndRepeatTableViewController {
            endRepeatVC.previousViewController = self
            endRepeatVC.endDate = endDate
        }
    }
    
    @IBAction func didTapRepeat(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        sender.backgroundColor = sender.isSelected ? UIColor.pillBlue : UIColor.clear
    }
    
    @IBAction func didTapAdd(_ sender: UIBarButtonItem) {
    }
    
    @IBAction func didSelectDate(_ sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        startDateCell.detailTextLabel?.text = formatter.string(from: sender.date)
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if cell === startDateCell {
            let formatter = DateFormatter()
            formatter.timeStyle = .short
            startDateCell.detailTextLabel?.text = formatter.string(from: startDatePicker.date)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        if indexPath.section == 1 && indexPath.row == 0 {
            if startDateCellHeight == 0 {
                cell.detailTextLabel?.textColor = UIColor.pillBlue
                startDateCellHeight = 200
            } else {
                cell.detailTextLabel?.textColor = UIColor.black
                startDateCellHeight = 0
            }
            tableView.beginUpdates()
            tableView.endUpdates()
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 1 && indexPath.row == 1 {
            return startDateCellHeight
        } else {
            return UITableViewAutomaticDimension
        }
    }
}
