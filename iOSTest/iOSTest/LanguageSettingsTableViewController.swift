//
//  LanguageSettingsTableViewController.swift
//  iOSTest
//
//  Created by Brandon Chester on 2017-11-02.
//  Copyright © 2017 Brandon Chester. All rights reserved.
//

import UIKit

class LanguageSettingsTableViewController: UITableViewController {
    
    @IBOutlet weak var frenchCell: UITableViewCell!
    @IBOutlet weak var englishCell: UITableViewCell!
    
    weak var previousViewController:SettingsTableViewController!
    var selectedLanguage = "English" {
        didSet {
            guard frenchCell != nil && englishCell != nil else { return }
            setCellSelection()
        }
    }
    
    override func viewDidLoad() {
        setCellSelection()
    }
    
    private func setCellSelection() {
        englishCell.accessoryType = selectedLanguage == "English" ? .checkmark : .none
        frenchCell.accessoryType = selectedLanguage == "French" ? .checkmark : .none
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) else { return }
        tableView.deselectRow(at: indexPath, animated: true)
        selectedLanguage = cell.textLabel!.text!
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        previousViewController.languageCell.detailTextLabel?.text = selectedLanguage
    }
}
