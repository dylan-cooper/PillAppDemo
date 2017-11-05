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
        }
    }
    
    func register(observer: MedicationUpdateObserver) {
        observers.append(observer)
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
