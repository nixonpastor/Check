//
//  ReminderModel.swift
//  Check
//
//  Created by Nixon Pastor on 3/7/22.
//

import Foundation

struct ReminderModel: Identifiable, Codable{
    let id: String
    let reminder: String
    let time: Date
    let reminderDate: Date
    
    
    init(id: String = UUID().uuidString, reminder: String, time: Date, reminderDate: Date){
        self.id = id
        self.reminder = reminder
        self.time = time
        self.reminderDate = reminderDate
    }
    
    func updateCompletition() -> ReminderModel {
        return ReminderModel(id: id, reminder: reminder, time: time, reminderDate: reminderDate)
    }
    
}
