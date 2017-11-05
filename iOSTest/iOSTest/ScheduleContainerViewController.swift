//
//  ScheduleContainerViewController.swift
//  iOSTest
//
//  Created by Brandon Chester on 2017-11-02.
//  Copyright © 2017 Brandon Chester. All rights reserved.
//

import UIKit

class ScheduleContainerViewController: UIViewController {

    @IBOutlet weak var scheduleListButton: UIBarButtonItem!
    @IBOutlet weak var container: UIView!
    var currentView = "Day"
    
    var scheduleChild:ScheduleViewController!
    var scheduleListChild:ScheduleTableViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let currentDate = Date()
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        let split = formatter.string(from: currentDate).split(separator: ",")
        navigationItem.title = String(split[0]) + "," + String(split[1])
        
        scheduleChild = childViewControllers[0] as! ScheduleViewController
        scheduleListChild = UIStoryboard(name: "Schedule", bundle: nil).instantiateViewController(withIdentifier: "ScheduleTableViewController") as! ScheduleTableViewController
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func didTapScheduleListButton(_ sender: UIBarButtonItem) {
        if currentView == "Day" {
            let image = UIImage(imageLiteralResourceName: "ic_list_highlight")
            scheduleListButton.image = image
            addListViewController()
        } else {
            let image = UIImage(imageLiteralResourceName: "ic_list")
            scheduleListButton.image = image
            removeListViewController()
        }
    }
    
    private func addListViewController() {
        addChildViewController(scheduleListChild)
        let childView = scheduleListChild.view!
        childView.translatesAutoresizingMaskIntoConstraints = false
        childView.alpha = 0
        container.addSubview(childView)
        childView.leadingAnchor.constraint(equalTo: container.leadingAnchor).isActive = true
        childView.trailingAnchor.constraint(equalTo: container.trailingAnchor).isActive = true
        childView.topAnchor.constraint(equalTo: container.topAnchor).isActive = true
        childView.bottomAnchor.constraint(equalTo: container.bottomAnchor).isActive = true
        UIView.animate(withDuration: 0.5) {
            childView.alpha = 1
        }
        currentView = "List"
        scheduleListChild.didMove(toParentViewController: self)
    }
    
    private func removeListViewController() {
        UIView.animate(withDuration: 0.5, animations: {
            self.scheduleListChild.view.alpha = 0
        }) { (finished) in
            self.scheduleListChild.willMove(toParentViewController: nil)
            self.scheduleListChild.view.removeFromSuperview()
            self.scheduleListChild.removeFromParentViewController()
            self.currentView = "Day"
        }
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
