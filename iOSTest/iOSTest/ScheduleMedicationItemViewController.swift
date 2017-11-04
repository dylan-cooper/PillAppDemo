//
//  ScheduleMedicationItemViewController.swift
//  iOSTest
//
//  Created by Brandon Chester on 2017-11-03.
//  Copyright © 2017 Brandon Chester. All rights reserved.
//

import UIKit

class ScheduleMedicationItemViewController: UIViewController {

    var nameString:String!
    var timeString:String!
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var time: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        name.text = nameString
        time.text = timeString
    }
}
