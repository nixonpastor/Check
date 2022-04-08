//
//  ReminderModel.swift
//  Check
//
//  Created by Nixon Pastor on 3/7/22.
//

import Foundation

class ReminderModel: ObservableObject, Identifiable, Codable{
    
    let id: String
    var reminder: String
    var time: Date
    var reminderDate: Date
    
    
    init(id: String = UUID().uuidString, reminder: String, time: Date, reminderDate: Date){
        self.id = id
        self.reminder = reminder
        self.time = time
        self.reminderDate = reminderDate
    }
    
}
