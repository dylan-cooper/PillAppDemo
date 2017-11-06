//
//  AddContactTableViewController.swift
//  iOSTest
//
//  Created by Brandon Chester on 2017-11-05.
//  Copyright © 2017 Brandon Chester. All rights reserved.
//

import UIKit

class AddContactTableViewController: UITableViewController {

    @IBOutlet weak var sendButton: UIBarButtonItem!
    @IBOutlet weak var emailField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func emailTextDidChange(_ sender: UITextField) {
        if sender.hasText {
            sendButton.isEnabled = true
        } else {
            sendButton.isEnabled = false
        }
    }
    
    
    
}
