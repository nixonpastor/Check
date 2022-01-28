//
//  Task.swift
//  Check
//
//  Created by Nixon Pastor on 1/27/22.
//

import SwiftUI

// Array of Tasks...
struct Task: Identifiable{
    var id = UUID().uuidString
    var title: String
    var time: Date = Date()
}

// Total Task Meta View...
struct TaskMetaData: Identifiable{
    var id = UUID().uuidString
    var task: [Task]
    var taskDate: Date
}

// Sample Date for Testing
func getSampleDate(offset: Int)->Date{
    let calender = Calendar.current
    
    let date = calender.date(byAdding: .day, value: offset, to: Date())
    
    return date ?? Date()
}

// Sample Tasks
var tasks: [TaskMetaData] = [

    TaskMetaData(task: [
    
        Task(title: "Test 1"),
        Task(title: "Test 2"),
        Task(title: "Test 3")
    ], taskDate: getSampleDate(offset: 1)),
    TaskMetaData(task: [
        
        Task(title: "Test 4")
    ], taskDate: getSampleDate(offset: -3)),
    TaskMetaData(task: [
        
        Task(title: "Test 5")
    ], taskDate: getSampleDate(offset: -8)),
    TaskMetaData(task: [
        
        Task(title: "Test 6")
    ], taskDate: getSampleDate(offset: 10)),
    TaskMetaData(task: [
        
        Task(title: "Test 7")
    ], taskDate: getSampleDate(offset: -22)),
    TaskMetaData(task: [
        
        Task(title: "Test 8")
    ], taskDate: getSampleDate(offset: 15)),
    TaskMetaData(task: [
        
        Task(title: "Test 9")
    ], taskDate: getSampleDate(offset: -20)),
]

