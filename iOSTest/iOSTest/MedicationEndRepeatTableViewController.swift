//
//  MedicationEndRepeatTableViewController.swift
//  iOSTest
//
//  Created by Apple on 2017-10-31.
//  Copyright © 2017 Brandon Chester. All rights reserved.
//

import UIKit

class MedicationEndRepeatTableViewController: UITableViewController {
    
    @IBOutlet weak var endDatePicker: UIDatePicker!
    @IBOutlet weak var onDateCell: UITableViewCell!
    @IBOutlet weak var neverCell: UITableViewCell!
    @IBOutlet weak var endDateCell: UITableViewCell!
    weak var previousViewController:AddMedicationTableViewController!
    var endDateCellHeight:CGFloat = 0
    var hasEndDate = false
    var endDate:Date? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if endDate != nil {
            endDatePicker.date = endDate!
            hasEndDate = true
            endDateCellHeight = 200
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        previousViewController.endDate = hasEndDate ? endDatePicker.date : nil
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if cell === neverCell {
            cell.accessoryType = hasEndDate ? .none : .checkmark
        } else if cell === onDateCell {
            cell.accessoryType = hasEndDate ? .checkmark : .none
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        if cell === neverCell {
            neverCell.accessoryType = .checkmark
            onDateCell.accessoryType = .none
            hasEndDate = false
            endDateCellHeight = 0
        } else if cell === onDateCell {
            neverCell.accessoryType = .none
            onDateCell.accessoryType = .checkmark
            hasEndDate = true
            endDateCellHeight = 200
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 2 {
            return endDateCellHeight
        } else {
            return UITableViewAutomaticDimension
        }
    }
}
