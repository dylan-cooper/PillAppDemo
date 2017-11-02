//
//  PasswordResetViewController.swift
//  iOSTest
//
//  Created by Brandon Chester on 2017-10-22.
//  Copyright © 2017 Brandon Chester. All rights reserved.
//

import UIKit

class AccountAccessViewController: UIViewController {
    
    enum AccessType {
        case username, password
    }

    @IBOutlet weak var emailSeparator: UIView!
    @IBOutlet weak var emailField: UITextField!
    var accessType:AccessType!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailField.addDoneButton()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didTapNext(_ sender: UIButton) {
        if emailField.hasText && accessType == .password {
            performSegue(withIdentifier: "showEmailConfirmation", sender: nil)
        }
    }
    
    @IBAction func didEndEditingEmail(_ sender: UITextField) {
        unHighlight(separator: emailSeparator)
    }
    
    @IBAction func didBeginEditingEmail(_ sender: UITextField) {
        highlight(separator: emailSeparator)
    }
    
    private func highlight(separator:UIView) {
        separator.backgroundColor = UIColor(red: 0.009, green: 0.427, blue: 0.706, alpha: 1)
    }
    
    private func unHighlight(separator:UIView) {
        separator.backgroundColor = UIColor(red: 0.723, green: 0.723, blue: 0.723, alpha: 1)
    }
}
