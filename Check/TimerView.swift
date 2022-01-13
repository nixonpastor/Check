//
//  TimerView.swift
//  Check
//
//  Created by Nixon Pastor on 1/6/22.
//

import SwiftUI

struct TimerView: View {
    var body: some View {
        Color(0x070707).overlay(
            VStack{
//                Text("Timer View").foregroundColor(.white)
//                Image(systemName: "timer").resizable().frame(width: 60, height: 60, alignment: .center)
//                    .foregroundColor(.white)
                
                ZStack{
                    Circle().trim(from: 0, to: 1)
                        .stroke(Color.white.opacity(0.09), style: StrokeStyle(lineWidth: 35, lineCap: .round))
                        .frame(width: 280, height: 280)
                    
                    Circle().trim(from: 0, to: 0.5)
                        .stroke(Color.red, style: StrokeStyle(lineWidth: 35, lineCap: .round))
                        .frame(width: 280, height: 280)
                        .rotationEffect(.init(degrees: -90))

                    
                    VStack{
                        Text("15")
                            .font(.system(size: 65))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                                  
                    }
                }
                
            }).edgesIgnoringSafeArea(.vertical)
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
    }
}
