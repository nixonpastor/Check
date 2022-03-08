//
//  DatePickerCustom.swift
//  Check
//
//  Created by Nixon Pastor on 1/26/22.
//

import SwiftUI

struct DatePickerCustom: View {
    
    @EnvironmentObject var calendarViewModel: CalendarViewModel
    @Binding var currentDate: Date
    
    //Current Month based on arrow CTA
    @State var currentMonth: Int = 0
    var body: some View {
        
        VStack(spacing: 35){
            
            //Days of the week
            let days: [String] = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
            
            //Month and Arrows View
            HStack(spacing: 20){
                VStack(alignment: .leading, spacing: 10){
                    Text(getYearAndMonth()[0])
//                        .font(.caption)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                    
                    Text(getYearAndMonth()[1])
                        .font(.title.bold())
                        .foregroundColor(.white)
                    
                }
            Spacer(minLength: 0)
             
            Button{
                withAnimation{
                    currentMonth -= 1
                }
            } label: {
                Image(systemName: "chevron.left")
                    .font(.title2)
                    .foregroundColor(Color.green)
            }
                
            Button{
                withAnimation{
                    currentMonth += 1
                }
                } label: {
                    Image(systemName: "chevron.right")
                        .font(.title2)
                        .foregroundColor(Color.green)
                }
                
                NavigationLink("Add", destination: AddCalendarReminderView()).foregroundColor(Color.green)
                
            }.padding(.horizontal)
            
            //View for Row of Days
            HStack(spacing: 0){
                ForEach(days, id: \.self){ day in
                    Text(day)
                        .font(.callout)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(.white)
                }
            }
            
            //View for numbered days
            let columns = Array(repeating: GridItem(.flexible()), count: 7)
            
            LazyVGrid(columns: columns, spacing: 15){
                ForEach(getDates()){
                    value in
                    CardView(value: value)
                        .background(Capsule()
                                        .fill(Color(UIColor.orange))
                                        .padding(.horizontal, 8)
                                        .opacity(isSameDay(date1:
                                                            value.date, date2:
                                                            currentDate) ? 1 : 0))
                        .onTapGesture {
                            currentDate = value.date
                        }
                
                }
                
                
            }.onChange(of: currentMonth){
                newValue in
                
                //update month
                currentDate = getCurrentMonth()
            }
            VStack(spacing: 15){
                Text("Reminders")
                    .font(.title2.bold())
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.vertical, 10)
                
                if let reminder = calendarViewModel.reminders.first(where: {
                    reminder in
                    
                    return isSameDay(date1: reminder.reminderDate, date2: currentDate)
                }){
                    
                    ForEach(calendarViewModel.reminders){
                    reminder in
                        if(isSameDay(date1: reminder.reminderDate, date2: currentDate)){
                            VStack(alignment: .leading, spacing: 10){
                        //display reminders
                        Text(reminder.time, style: .time)
                            .foregroundColor(.white)
                        Text(reminder.reminder)
                            .font(.title2.bold())
                            .foregroundColor(.white)
                        
                    }
                            .padding(.vertical, 10)
                            .padding(.horizontal)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(
                                Color(UIColor.orange)
                                    .opacity(0.9)
                                    .cornerRadius(10)
                            )
                        }
                    }
                }
                else{
                    Text("No Reminders For Today")
                        .foregroundColor(.white)
                }
            }
            .padding()

        }.padding(.top, 0)
            .padding(.bottom, 90)
    }
    
    //Display individual day
    @ViewBuilder
    func CardView(value: DateObject)-> some View{

        VStack{
            if value.day != -1{
                if let reminder = calendarViewModel.reminders.first(where: {
                    reminder in
                    
                    return isSameDay(date1: reminder.reminderDate, date2: value.date)
                }){
                    Text("\(value.day)")
                    //change color based on selected dates
                        .foregroundColor(isSameDay(date1: reminder.reminderDate, date2: currentDate) ? .white : Color(UIColor.orange))
                        .font(.title3.bold())
                        .frame(maxWidth: .infinity)
                    
                    
                    Spacer()
                    
                    Circle()
                        .fill(isSameDay(date1: reminder.reminderDate, date2: currentDate) ? .white : Color(UIColor.orange))
                        .frame(width: 8, height: 8)
                        
                }
                else{
                    Text("\(value.day)")
                        .foregroundColor(.white)
                        .font(.title3.bold())
                        .frame(maxWidth: .infinity)
                    Spacer()
                }
            }
        }
        .padding(.vertical, 9)
        .frame(height: 60, alignment: .top)
    }
    
    //check dates
    func isSameDay(date1: Date, date2: Date)->Bool{
        let calendar = Calendar.current
        
        return calendar.isDate(date1, inSameDayAs: date2)
    }
    
    //get year and month to display
    func getYearAndMonth()->[String]{
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY MMMM"
        
        let date = formatter.string(from: currentDate)
        
        return date.components(separatedBy: " ")
    }
    
    func getCurrentMonth()->Date{
        let calendar = Calendar.current

        // Get Current Month Date
        guard let currentMonth = calendar.date(byAdding: .month, value: self.currentMonth, to: Date())
        else{
            return Date()
        }
        
        return currentMonth
    }
    
    func getDates()->[DateObject]{
        let calendar = Calendar.current

        // Get Current Month Date
        let currentMonth = getCurrentMonth()
        
       var days = currentMonth.getAllDates().compactMap{
            date -> DateObject
            in
            
            //get day
            let day = calendar.component(.day, from: date)
            return DateObject(day:day, date: date)
        }
        
        //add offset to days to get current week and last month
        let firstWeekday = calendar.component(.weekday, from: days.first?.date ?? Date())
        
        for _ in 0..<firstWeekday - 1{
            days.insert(DateObject(day: -1, date: Date()), at:0)
        }
        
        return days
    }
}

struct DatePickerCustom_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView().environmentObject(CalendarViewModel())
    }
}


//Date Extension for Current Month
extension Date{
    func getAllDates()->[Date]{
        let calendar = Calendar.current
        
        //get begginning of date
        let startDate = calendar.date(from: Calendar.current.dateComponents([.year, .month], from: self))!
        
        let range = calendar.range(of: .day, in: .month, for: startDate)!
        
        // get the dates
        return range.compactMap{
            day -> Date in
            return calendar.date(byAdding: .day, value: day - 1, to: startDate)!
//            return calendar.date(byAdding: .day, value: day, to: startDate)!

        }
    }
}
