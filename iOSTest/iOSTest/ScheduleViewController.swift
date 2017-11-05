//
//  ScheduleViewController.swift
//  iOSTest
//
//  Created by Apple on 2017-10-23.
//  Copyright © 2017 Brandon Chester. All rights reserved.
//

import UIKit

class ScheduleViewController: UIViewController, MedicationUpdateObserver {
    @IBOutlet weak var twelveAMBar2: UIView!
    @IBOutlet weak var elevenPMBar: UIView!
    @IBOutlet weak var tenPMBar: UIView!
    @IBOutlet weak var ninePMBar: UIView!
    @IBOutlet weak var eightPMBar: UIView!
    @IBOutlet weak var sevenPMBar: UIView!
    @IBOutlet weak var sixPMBar: UIView!
    @IBOutlet weak var fivePMBar: UIView!
    @IBOutlet weak var fourPMBar: UIView!
    @IBOutlet weak var threePMBar: UIView!
    @IBOutlet weak var twoPMBar: UIView!
    @IBOutlet weak var onePMBar: UIView!
    @IBOutlet weak var twelvePMBar: UIView!
    @IBOutlet weak var twelveAMBar: UILabel!
    @IBOutlet weak var elevenAMBar: UIView!
    @IBOutlet weak var tenAMBar: UIView!
    @IBOutlet weak var nineAMBar: UIView!
    @IBOutlet weak var eightAMBar: UIView!
    @IBOutlet weak var sevenAMBar: UIView!
    @IBOutlet weak var sixAMBar: UIView!
    @IBOutlet weak var oneAMBar: UIView!
    @IBOutlet weak var twoAMBar: UIView!
    @IBOutlet weak var threeAMBar: UIView!
    @IBOutlet weak var fourAMBar: UIView!
    @IBOutlet weak var fiveAMBar: UIView!
    
    @IBOutlet weak var scheduleBars: UIStackView!
    @IBOutlet weak var scrollView: UIScrollView!
    private var originalDistance:CGFloat = 32
    @IBOutlet weak var contentView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ScheduleData.shared.register(observer: self)
        addMedicationsToSchedule()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func willMove(toParentViewController parent: UIViewController?) {
        if parent == nil {
            ScheduleData.shared.remove(observer: self)
        }
    }

    
    deinit {
        print("Goodbye schedule")
        for child in childViewControllers {
            child.willMove(toParentViewController: nil)
            child.view.removeFromSuperview()
            child.removeFromParentViewController()
        }
    }
    
    func medicationsDidUpdate() {
        for child in childViewControllers {
            child.willMove(toParentViewController: nil)
            child.view.removeFromSuperview()
            child.removeFromParentViewController()
        }
        addMedicationsToSchedule()
    }
    
    private func addMedicationsToSchedule() {
        let currentDate = Date()
        let formatter = DateFormatter()
        formatter.dateStyle = .full
        let day = formatter.string(from: currentDate).split(separator: ",")[0]
        var dayOption = DateOptions.monday
        if (day == "Tuesday") {
            dayOption = DateOptions.tuesday
        } else if (day == "Wednesday") {
            dayOption = DateOptions.wednesday
        } else if (day == "Thursday") {
            dayOption = DateOptions.thursday
        } else if (day == "Friday") {
            dayOption = DateOptions.friday
        } else if (day == "Saturday") {
            dayOption = DateOptions.saturday
        } else if (day == "Sunday") {
            dayOption = DateOptions.sunday
        }
        for med in ScheduleData.shared.items {
            if let end = med.endDate {
                if Calendar.current.compare(end, to: Date(), toGranularity: .day) == .orderedAscending {
                    continue
                }
            }
            if med.days.contains(dayOption) || med.days.isEmpty {
                addMedicationView(for: med)
            }
        }
    }
    
    private func addMedicationView(for medication:Medication) {
        let medicationVC = UIStoryboard(name: "Schedule", bundle: nil).instantiateViewController(withIdentifier: "ScheduleItemViewController") as! ScheduleMedicationItemViewController
        
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        
        let time = formatter.string(from: medication.time)
        let firstSplit = time.split(separator: ":")
        let hour = firstSplit[0]
        let secondSplit = firstSplit[1].split(separator: " ")
        let minutes = secondSplit[0]
        let period = secondSplit[1]
        
        let numericHour = Int(hour)!
        let numericMinutes = Int(minutes)!
        
        medicationVC.nameString = medication.name
        medicationVC.timeString = time
        let separator = getSeparator(for: numericHour, period: String(period))
        let offset:CGFloat = numericMinutes < 30 ? 0 : 27
        
        addChildViewController(medicationVC)
        let medicationView = medicationVC.view!
        
        if medication.type == .meeting {
            medicationView.backgroundColor = UIColor.pillGreenLowAlpha
            medicationVC.borderView.backgroundColor = UIColor.pillGreen
            medicationVC.name.textColor = UIColor.pillGreen
            medicationVC.time.textColor = UIColor.pillGreen
        }
        
        if medication.type == .event {
            medicationView.backgroundColor = UIColor.pillRedLowAlpha
            medicationVC.borderView.backgroundColor = UIColor.pillRed
            medicationVC.name.textColor = UIColor.pillRed
            medicationVC.time.textColor = UIColor.pillRed
        }
        
        medicationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(medicationView)
        medicationView.widthAnchor.constraint(equalTo: separator.widthAnchor).isActive = true
        medicationView.heightAnchor.constraint(equalToConstant: 23).isActive = true
        medicationView.topAnchor.constraint(equalTo: separator.bottomAnchor, constant: offset).isActive = true
        medicationView.trailingAnchor.constraint(equalTo: separator.trailingAnchor).isActive = true
        medicationVC.didMove(toParentViewController: self)
    }
    
    private func getSeparator(for hour:Int, period:String) -> UIView {
        switch hour {
        case 1:
            return period == "AM" ? oneAMBar : onePMBar
        case 2:
            return period == "AM" ? twoAMBar : twoPMBar
        case 3:
            return period == "AM" ? threeAMBar : threePMBar
        case 4:
            return period == "AM" ? fourAMBar : fourPMBar
        case 5:
            return period == "AM" ? fiveAMBar : fivePMBar
        case 6:
            return period == "AM" ? sixAMBar : sixPMBar
        case 7:
            return period == "AM" ? sevenAMBar : sevenPMBar
        case 8:
            return period == "AM" ? eightAMBar : eightPMBar
        case 9:
            return period == "AM" ? nineAMBar : ninePMBar
        case 10:
            return period == "AM" ? tenAMBar : tenPMBar
        case 11:
            return period == "AM" ? elevenAMBar : elevenPMBar
        case 12:
            return period == "AM" ? twelveAMBar : twelvePMBar
        default:
            return twelveAMBar2
        }
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
