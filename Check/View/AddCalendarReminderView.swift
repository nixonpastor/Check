//
//  AddCalendarReminderView.swift
//  Check
//
//  Created by Nixon Pastor on 3/7/22.
//

import SwiftUI

struct AddCalendarReminderView: View {
    init() {
            UITextView.appearance().backgroundColor = .clear
        }
    
    //To Navigate back to notes page
    @Environment(\.presentationMode) var presentationMode
    
    @EnvironmentObject var calendarViewModel: CalendarViewModel
    
    @State var textFieldString: String = ""
    @State var date: Date = Date()
    @State var time: Date = Date()
    
    @State var alertTitle: String = ""
    @State var showAlert: Bool = false
    
    var body: some View {
        ScrollView{
            VStack{
                TextEditor(text: $textFieldString)
                    .placeholder(when: textFieldString.isEmpty){
                        Text("Enter Reminder Here").foregroundColor(.white)
                            .opacity(0.6)
                            .padding(.bottom, 30)
                            .padding(.horizontal, 6)
                    }
                    .padding(.horizontal)
                    .padding()
                    .frame(height: 100)
                    .foregroundColor(.white)
                    .background(Color(0x212423))
                    .cornerRadius(10)
                
                
                DatePicker("Please enter a date", selection: $date, in: Date.now..., displayedComponents: .date)
                      .id(date)
                    .padding()
                
                DatePicker("Please enter a time", selection: $time, in: Date.now..., displayedComponents: .hourAndMinute)
                    .padding()
                
                Button(action: saveButtonPressed, label: {
                    Text("Save".uppercased())
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
        .navigationTitle("Add a Reminder")
        .alert(isPresented: $showAlert, content: getAlert)
    }
    
    //add note to calendarViewModel
    func saveButtonPressed(){
        if isAppropriateText() {
//            print(textFieldString)
//            print(date)
//            let formatter = DateFormatter()
//            formatter.dateFormat = "HH:mm"
//            let currentTime = formatter.string(from: time)
//            print(currentTime)
            calendarViewModel.addReminder(reminder: textFieldString, time: time, reminderDate: date)
            print(calendarViewModel.reminders)
            presentationMode.wrappedValue.dismiss()
        }
    }
    
    //check if 3 characters or more
    func isAppropriateText() -> Bool {
        if textFieldString.count < 3 {
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

struct AddCalendarReminderView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
        AddNoteView()
        }.environmentObject(CalendarViewModel())
    }
}




