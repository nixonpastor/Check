//
//  CalendarView.swift
//  Check
//
//  Created by Nixon Pastor on 1/6/22.
//

import SwiftUI

struct CalendarView: View {
    
    @State var currentDate:  Date = Date()
    
    var body: some View {
        Color(0x070707).overlay(
            ScrollView(.vertical, showsIndicators: false){
                VStack(spacing:20){
                    
                    //Date Picker Custom View
                    DatePickerCustom(currentDate: $currentDate)
                }
            }
        ).edgesIgnoringSafeArea(.vertical)
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
    }
}
