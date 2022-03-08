//
//  CheckApp.swift
//  Check
//
//  Created by Nixon Pastor on 1/6/22.
//

import SwiftUI

@main
struct CheckApp: App {
    
    @State var listViewModel: ListViewModel = ListViewModel()
    @State var calendarViewModel: CalendarViewModel = CalendarViewModel()
    
    var body: some Scene {
        WindowGroup {
            NavigationView{
                ContentView()
            }.environmentObject(listViewModel)
                .environmentObject(calendarViewModel)
                .padding(.top, -150)
        }
    }
}
