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
    private weak var observer:MedicationUpdateObserver?
    
    static let shared = ScheduleData()
    
    init() {
        if let data = UserDefaults.standard.data(forKey: "Medication") {
            if let medication = try? JSONDecoder().decode([Medication].self, from: data) {
                items = medication
            }
        }
    }
    
    func register(observer: MedicationUpdateObserver) {
        self.observer = observer
    }
    
    func add(medication: Medication) {
        items.append(medication)
        observer?.didAddMedication(medication)
        guard let data = try? JSONEncoder().encode(items) else { return }
        UserDefaults.standard.set(data, forKey: "Medication")
    }
    
    func remove(medication: Medication) {
        if let index = items.index(of: medication) {
            items.remove(at: index)
            observer?.didRemoveMedication(medication)
            guard let data = try? JSONEncoder().encode(items) else { return }
            UserDefaults.standard.set(data, forKey: "Medication")
        }
    }
}

protocol MedicationUpdateObserver: AnyObject {
    func didAddMedication(_ medication: Medication)
    func didRemoveMedication(_ medication: Medication)
}
