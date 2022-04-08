//
//  CalendarViewModel.swift
//  Check
//
//  Created by Nixon Pastor on 3/7/22.
//

import Foundation


class CalendarViewModel: ObservableObject{
    @Published var reminders: [ReminderModel] = []{
        didSet{
            saveItems()
        }
    }
    let remindersKey: String = "reminders_list"
    
    init(){
        getReminders()
    }
    
    func getReminders(){
        guard
            let data = UserDefaults.standard.data(forKey: remindersKey),
            let savedItems = try? JSONDecoder().decode([ReminderModel].self, from: data)
        else {
            return
        }
        
        self.reminders = savedItems
    }
    
    func addReminder(reminder: String, time: Date, reminderDate: Date){
        let newReminder = ReminderModel(reminder: reminder,  time: time, reminderDate: reminderDate)
        reminders.append(newReminder)
    }
    
    func updateReminder(reminder: ReminderModel){
        if let index = reminders.firstIndex(where: { $0.id == reminder.id}){
            reminders[index] = ReminderModel(id: reminder.id, reminder: reminder.reminder, time: reminder.time, reminderDate: reminder.reminderDate)
        }
    }
    
    func deleteReminder(reminder: ReminderModel){
        if let index = reminders.firstIndex(where: { $0.id == reminder.id}){
            reminders.remove(at: index)        }
    }
    
    func saveItems(){
        if let encodedData = try? JSONEncoder().encode(reminders){
            UserDefaults.standard.set(encodedData, forKey: remindersKey)
        }
    }
}
