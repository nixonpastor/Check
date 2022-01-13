//
//  ContentView.swift
//  Check
//
//  Created by Nixon Pastor on 1/6/22.
//

import SwiftUI

enum Tabs: String{
    case notes
    case calendar
    case timer
}

struct ContentView: View {
    
    init(){
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.orange]
        
        UITabBar.appearance().unselectedItemTintColor = UIColor.white
        
         UITabBar.appearance().backgroundColor = UIColor(Color(0x212423))

    }
    
    @State var selectedTab: Tabs = .calendar
    
    var body: some View {
        NavigationView{
            TabView(selection: $selectedTab) {
                NotesView().tabItem{
                    Label("Notes", systemImage: "note")
                }.tag(Tabs.notes)
                CalendarView().tabItem{
                    Label("Calendar", systemImage: "calendar")
                }.tag(Tabs.calendar)
                TimerView().tabItem{
                    Label("Timer", systemImage: "timer")
                }.tag(Tabs.timer)
            }.navigationTitle(selectedTab.rawValue.capitalized)
            .accentColor(Color(0x26C598))
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


