//
//  DatePickerCustom.swift
//  Check
//
//  Created by Nixon Pastor on 1/26/22.
//
//stopped at 10:45 

import SwiftUI

struct DatePickerCustom: View {
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
                        .font(.caption)
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
            }
                
            Button{
                withAnimation{
                    currentMonth += 1
                }
                } label: {
                    Image(systemName: "chevron.right")
                        .font(.title2)
                }
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
                }
            }.onChange(of: currentMonth){
                newValue in
                
                //update month
                currentDate = getCurrentMonth()
            }
            
        }.padding(.top, 150)
    }
    
    @ViewBuilder
    func CardView(value: DateObject)-> some View{

        VStack{
            if value.day != -1{
                                            Text("\(value.day)")
                                                .foregroundColor(.white)
                                                .font(.title3.bold())
            }
        }
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
        CalendarView()
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
