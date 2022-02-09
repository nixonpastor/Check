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
    
    var body: some Scene {
        WindowGroup {
            NavigationView{
                ContentView()
            }.environmentObject(listViewModel)
                .padding(.top, -150)
        }
    }
}
