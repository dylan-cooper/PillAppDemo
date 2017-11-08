//
//  ScheduleData.swift
//  iOSTest
//
//  Created by Brandon Chester on 2017-11-03.
//  Copyright © 2017 Brandon Chester. All rights reserved.
//

import UIKit

class ScheduleData {
    var items = [Medication]()
    private var observers = [MedicationUpdateObserver]()
    
    static let shared = ScheduleData()
    
    init() {
        if let data = UserDefaults.standard.data(forKey: "Medication") {
            if let medication = try? JSONDecoder().decode([Medication].self, from: data) {
                items = medication
            }
        } else {
            reset()
        }
    }
    
    func register(observer: MedicationUpdateObserver) {
        observers.append(observer)
    }
    
    func reset() {
        items.removeAll()
        items.append(Medication(name: "Meeting with CLC worker.",
                                type: .meeting,
                                time: Date(timeIntervalSince1970: 1509575400),
                                endDate: nil,
                                days: [.wednesday]))
        
        items.append(Medication(name: "Concert with Mike.",
                                type: .event,
                                time: Date(timeIntervalSince1970: 1510366800),
                                endDate: Date(timeIntervalSince1970: 1510366800),
                                days: [.friday]))
        
        items.append(Medication(name: "Going to see The Room!",
                                type: .event,
                                time: Date(timeIntervalSince1970: 1510189500),
                                endDate: Date(timeIntervalSince1970: 1510189500),
                                days: [.wednesday]))
        
        items.append(Medication(name: "Take 5mg Zoloft.",
                                type: .medication,
                                time: Date(timeIntervalSince1970: 1509976800),
                                endDate: nil,
                                days: [.tuesday, .thursday]))
        
        items.append(Medication(name: "Take 10mg Adderall.",
                                type: .medication,
                                time: Date(timeIntervalSince1970: 1506875400),
                                endDate: nil,
                                days: [.sunday,
                                       .monday,
                                       .tuesday,
                                       .wednesday,
                                       .thursday,
                                       .friday,
                                       .saturday]))
        
        items.append(Medication(name: "Community support group.",
                                type: .meeting,
                                time: Date(timeIntervalSince1970: 1506885300),
                                endDate: Date(timeIntervalSince1970: 1514664900),
                                days: [.monday, .thursday]))
        
        items.append(Medication(name: "Pick up prescriptions.",
                                type: .event,
                                time: Date(timeIntervalSince1970: 1510176000),
                                endDate: Date(timeIntervalSince1970: 1510176000),
                                days: [.wednesday]))
        
        items.append(Medication(name: "Call Mike to organize carpool.",
                                type: .event,
                                time: Date(timeIntervalSince1970: 1510153200),
                                endDate: Date(timeIntervalSince1970: 1510153200),
                                days: [.wednesday]))
        
        guard let data = try? JSONEncoder().encode(items) else { return }
        UserDefaults.standard.set(data, forKey: "Medication")
    }
    
    func remove(observer: MedicationUpdateObserver) {
        observers = observers.filter { return $0 !== observer }
    }
    
    func add(medication: Medication) {
        items.append(medication)
        for observer in observers {
            observer.medicationsDidUpdate()
        }
        guard let data = try? JSONEncoder().encode(items) else { return }
        UserDefaults.standard.set(data, forKey: "Medication")
    }
    
    func remove(medication: Medication) {
        if let index = items.index(of: medication) {
            items.remove(at: index)
            for observer in observers {
                observer.medicationsDidUpdate()
            }
            guard let data = try? JSONEncoder().encode(items) else { return }
            UserDefaults.standard.set(data, forKey: "Medication")
        }
    }
}

protocol MedicationUpdateObserver: AnyObject {
    func medicationsDidUpdate()
}
