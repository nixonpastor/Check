//
//  EditCalendarReminderView.swift
//  Check
//
//  Created by Nixon Pastor on 4/8/22.
//

//
//  AddCalendarReminderView.swift
//  Check
//
//  Created by Nixon Pastor on 3/7/22.
//

import SwiftUI

struct EditCalendarReminderView: View {
    
    
    //To Navigate back to notes page
    @Environment(\.presentationMode) var presentationMode
    
    @EnvironmentObject var calendarViewModel: CalendarViewModel
    @ObservedObject var currentReminder: ReminderModel

    @State var textFieldString: String = ""
    @State var date: Date = Date()
    @State var time: Date = Date()
    
    @State var alertTitle: String = ""
    @State var showAlert: Bool = false
    
    var body: some View {
        ScrollView{
            VStack{
                TextEditor(text: $currentReminder.reminder)
                    .padding(.horizontal)
                    .padding()
                    .frame(height: 100)
                    .foregroundColor(.white)
                    .background(Color(0x212423))
                    .cornerRadius(10)
                
                
                DatePicker("Please enter a date", selection: $currentReminder.reminderDate, in: Date.now..., displayedComponents: .date)
                    .id(date)
                    .padding()
                
                DatePicker("Please enter a time", selection: $currentReminder.time, in: Date.now..., displayedComponents: .hourAndMinute)
                    .padding()
                
                Button(action: saveEditButtonPressed, label: {
                    Text("Save Edit".uppercased())
                        .frame(height: 55)
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .background(Color.orange)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                })
            }
            .padding(16)
            
            
            
        }.padding(.top, 100)
        .navigationTitle("Edit Reminder")
        .alert(isPresented: $showAlert, content: getAlert)
    }
    
    //add note to calendarViewModel
    func saveEditButtonPressed(){
        if isAppropriateText() {
            calendarViewModel.updateReminder(reminder: currentReminder)
            print("testing save edit reminder button")
            presentationMode.wrappedValue.dismiss()
        }
    }
    
    //check if 3 characters or more
    func isAppropriateText() -> Bool {
        if currentReminder.reminder.count < 3 {
            alertTitle = "Note must be at least 3 characters long."
            showAlert.toggle()
            return false
        }
        return true
    }
    
    func getAlert() -> Alert {
        return Alert(title: Text(alertTitle))
    }
}

struct EditCalendarView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
//        AddNoteView()
        }.environmentObject(CalendarViewModel())
    }
}





