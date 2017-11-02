//
//  ScheduleViewController.swift
//  iOSTest
//
//  Created by Apple on 2017-10-23.
//  Copyright © 2017 Brandon Chester. All rights reserved.
//

import UIKit

class ScheduleViewController: UIViewController {

    @IBOutlet weak var scheduleBars: UIStackView!
    @IBOutlet weak var scrollView: UIScrollView!
    private var originalDistance:CGFloat = 32
    @IBOutlet weak var contentView: UIView!
    
    var medications = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func unwindToSchedule(_ sender: UIStoryboardSegue) {
        
    }
    
    @IBAction func userDidPinchSchedule(_ sender: UIPinchGestureRecognizer) {
       /* print("Scale: \(sender.scale)")
        if sender.state == .began {
            originalDistance = scheduleBars.spacing
        } else if sender.state == .changed {
            let oldOffset = scrollView.contentOffset.y
            scrollView.contentOffset = CGPoint(x: 0, y: oldOffset)
            scheduleBars.spacing = sender.scale*originalDistance
        }*/
    }
}
