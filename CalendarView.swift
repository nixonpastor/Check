//
//  CalendarView.swift
//  Check
//
//  Created by Nixon Pastor on 1/6/22.
//

import SwiftUI

struct CalendarView: View {
    var body: some View {
        Color(0x070707).overlay(
            VStack(spacing:20){
                Text("Calendar View").foregroundColor(.white)
                Image(systemName: "calendar").resizable().frame(width: 60, height: 60, alignment: .center)
                    .foregroundColor(.white)
            }
        ).edgesIgnoringSafeArea(.vertical)
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
    }
}
