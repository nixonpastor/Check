//
//  TimerView.swift
//  Check
//
//  Created by Nixon Pastor on 1/6/22.
//

import SwiftUI

struct TimerView: View {
    
    @State var start = false
    @State var to : CGFloat = 0
    @State var count = 0
    @State var time = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        Color(0x070707).overlay(
            VStack{
                HStack{
                    Text("Pomodoro")
                        .foregroundColor(.white)
                        .font(.system(size: 20))
                    Text("Short Break")
                        .foregroundColor(.white)
                        .font(.system(size: 20))
                    Text("Long Break")
                        .foregroundColor(.white)
                        .font(.system(size: 20))
                    Text("Custom")
                        .foregroundColor(.white)
                        .font(.system(size: 20))
                }.padding(.bottom, 55)
                ZStack{
                    
                    Circle().trim(from: 0, to: 1)
                        .stroke(Color.white.opacity(0.09), style: StrokeStyle(lineWidth: 35, lineCap: .round))
                        .frame(width: 280, height: 280)
                    
                    Circle().trim(from: 0, to: self.to)
                        .stroke(Color.red, style: StrokeStyle(lineWidth: 35, lineCap: .round))
                        .frame(width: 280, height: 280)
                        .rotationEffect(.init(degrees: -90))

                    
                    VStack{
                        Text("\(self.count)")
                            .font(.system(size: 65))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                                  
                    }
                }
                
                HStack(spacing: 20){
                    Button(action: {
                        
                    }){
                        HStack(spacing: 15){
                            Image(systemName: self.start ? "pause.fill" : "play.fill")
                                .foregroundColor(.white)
                            Text(self.start ? "Pause" : "Play")
                                .foregroundColor(.white)
                        }
                        .padding(.vertical)
                        .frame(width: (UIScreen.main.bounds.width / 2) - 55)
                        .background(Color.green)
                        .clipShape(Capsule())
                        .shadow(radius: 6)
                        
                        HStack(spacing: 15){
                            Image(systemName: "arrow.clockwise")
                                .foregroundColor(Color.green)
                            Text("Restart")
                                .foregroundColor(Color.green)
                        }
                        .padding(.vertical)
                        .frame(width: (UIScreen.main.bounds.width / 2) - 55)
                        
                        .background(
                        Capsule()
                            .stroke(Color.green, lineWidth: 2))
                    }
                    .shadow(radius: 6)
                    
                }
                .padding(.top, 55)
                
                
            }).edgesIgnoringSafeArea(.vertical)
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
    }
}
