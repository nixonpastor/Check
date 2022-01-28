//
//  Reminders.swift
//  Check
//
//  Created by Nixon Pastor on 1/27/22.
//

import SwiftUI

// Reminder Model with Samples
// Array of Reminders

struct Reminders: Identifiable{
    var id = UUID().uuidString
    var title: String
    var time: Date = Date()
}


struct RemindersMetaData: Identifiable{
    var id = UUID().uuidString
    var reminders: [Reminders]
    var remindersDate: Date
}

// Sample Date for Testing...
func getSampleDate(offset: Int)->Date{
    let calender = Calendar.current
    
    let date = calender.date(byAdding: .day, value: offset, to: Date())
    
    return date ?? Date()
}

// Sample Reminders
var reminders: [RemindersMetaData] = [

    RemindersMetaData(reminders: [
    
        Reminders(title: "Talk to Sister"),
        Reminders(title: "Another Reminder"),
        Reminders(title: "Workout")
    ], remindersDate: getSampleDate(offset: 1)),
    RemindersMetaData(reminders: [
        
        Reminders(title: "Talk to John Smith")
    ], remindersDate: getSampleDate(offset: -3)),
    RemindersMetaData(reminders: [
        
        Reminders(title: "Meeting with Tom Smith")
    ], remindersDate: getSampleDate(offset: -8)),
    RemindersMetaData(reminders: [
        
        Reminders(title: "Testing")
    ], remindersDate: getSampleDate(offset: 10)),
    RemindersMetaData(reminders: [
        
        Reminders(title: "Testing 3")
    ], remindersDate: getSampleDate(offset: -22)),
    RemindersMetaData(reminders: [
        
        Reminders(title: "Testing 4")
    ], remindersDate: getSampleDate(offset: 15)),
    RemindersMetaData(reminders: [
        
        Reminders(title: "Testing 5")
    ], remindersDate: getSampleDate(offset: -20)),
]
