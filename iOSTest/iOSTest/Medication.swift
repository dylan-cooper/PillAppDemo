//
//  Medication.swift
//  iOSTest
//
//  Created by Brandon Chester on 2017-11-03.
//  Copyright © 2017 Brandon Chester. All rights reserved.
//

import UIKit

struct Medication: Equatable, Codable {
    static func == (lhs: Medication, rhs: Medication) -> Bool {
        return lhs.name == rhs.name
    }
    
    var name:String
    var type: ReminderType
    var time:Date
    var endDate:Date?
    var days:[DateOptions]
}

enum ReminderType: Int, Codable {
    case medication, meeting, event
}

struct DateOptions: OptionSet, Codable {
    let rawValue: Int
    static let sunday = DateOptions(rawValue: 1 << 0)
    static let monday = DateOptions(rawValue: 1 << 1)
    static let tuesday = DateOptions(rawValue: 1 << 2)
    static let wednesday = DateOptions(rawValue: 1 << 3)
    static let thursday = DateOptions(rawValue: 1 << 4)
    static let friday = DateOptions(rawValue: 1 << 5)
    static let saturday = DateOptions(rawValue: 1 << 6)
}
