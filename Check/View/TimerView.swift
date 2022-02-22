//
//  TimerView.swift
//  Check
//
//  Created by Nixon Pastor on 1/6/22.
//

import SwiftUI

struct TimerView: View {
    
    @State var start = false
    @State var to : Int = 1500
    @State var count = 0
    @State var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State var selectedPicker : Int = 0
    
    init(){
        UISegmentedControl.appearance().backgroundColor = UIColor(Color(0x070707))
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.black], for: .selected)
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(Color.green)
                                                                    

    }
    
    var body: some View {
        Color(0x070707).overlay(
            VStack{

                Picker(selection: $selectedPicker, label: Text("")){
                    Text("Pomodoro").tag(0)
                    Text("Short Break").tag(1)
                    Text("Long Break").tag(2)
                    Text("Custom").tag(3)
                }.pickerStyle(SegmentedPickerStyle())
                
                
                switch selectedPicker {
                case 0:
                    PomodoroTimerView()
                case 1:
                    ShortBreakTimerView()
                case 2:
                    LongBreakTimerView()
                case 3:
                    CustomTimerView()
                default:
                    Text("Error on Timer View").foregroundColor(.white)
                }
                
                
            }).edgesIgnoringSafeArea(.vertical)
            .padding(.top, -120)
    }
    
    
    func countToMinutes() -> String {
           let currentTime = to - count
           let seconds = currentTime % 60
           let minutes = Int(currentTime / 60)
           
           return "\(minutes):\(seconds < 10 ? "0" : "")\(seconds)"
       }
    
    func countToProgress() -> CGFloat {
            return (CGFloat(count) / CGFloat(to ))
        }
    
    func completed() -> Bool {
            return countToProgress() == 1
        }
    
    @ViewBuilder
    func CustomTimerView() -> some View{
        
        Text("Testing Custom Timer View Function").foregroundColor(.white)

        ZStack{
            Circle().trim(from: 0, to: 1)
                .stroke(Color.white.opacity(0.09), style: StrokeStyle(lineWidth: 35, lineCap: .round))
                .frame(width: 280, height: 280)

            Circle().trim(from: 0, to: countToProgress())
                .stroke(Color.red, style: StrokeStyle(lineWidth: 35, lineCap: .round))
                .frame(width: 280, height: 280)
                .rotationEffect(.init(degrees: -90))


            VStack{
                Text("\(self.count)")
                    .font(.system(size: 65))
                    .fontWeight(.bold)
                    .foregroundColor(.white)

            }
        }.padding(.top, 100)
    }
    
    @ViewBuilder
    func PomodoroTimerView() -> some View{
        ZStack{
            Circle()
                        .fill(Color.clear)
                        .frame(width: 350, height: 350)
                        .overlay(
                            Circle().stroke(Color.white.opacity(0.09), lineWidth: 15)
                            
                    )
            
            Circle()
                        .fill(Color.clear)
                        .frame(width: 350, height: 350)
                        .overlay(
                            Circle().trim(from:0, to: countToProgress())
                                .stroke(
                                    style: StrokeStyle(
                                        lineWidth: 15,
                                        lineCap: .round,
                                        lineJoin:.round
                                    )
                            )
                                .rotationEffect(.init(degrees: -90))
                                .foregroundColor(
                                    (completed() ? Color.green : Color.orange)
                            ).animation(
                                .easeInOut(duration: 0.2)
                            )
                    )


            VStack{
                Text(countToMinutes())
                    .font(.system(size: 65))
                    .fontWeight(.bold)
                    .foregroundColor(.white)

            }
        }.onReceive(self.timer) { (time) in
            if(self.start){

                if (self.count <= self.to - 1 ) {
                    print("count2")
                    print(self.count)
                    print("to2")
                    print(self.to - 1 )
                    if (self.count == self.to){
                        withAnimation(Animation.default){
                            self.count = 0
                            self.start.toggle()
                        }
                    }
                    else{
                        self.count += 1
                    }
                }
                else{
                    withAnimation(.default){
                        self.to = 1500
                    }
                    self.start.toggle()
                }
                
               
            }
        }
        .onAppear{
            self.to = 1500
            self.count = 0
            self.start = false
        }
        .padding(.top, 100)
        
        HStack(spacing: 20){
            Button(action: {
                
                if(self.count == 1500){
                    self.count = 0
                    withAnimation(.default){
                        self.to = 1500
                    }
                }
                self.start.toggle()
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


            }
            .shadow(radius: 6)

            Button(action: {
                self.count = 0
                self.to = 1500
            }){
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
        }
        .padding(.top, 90)
    }
    
    @ViewBuilder
    func ShortBreakTimerView() -> some View{
        ZStack{
            Circle()
                        .fill(Color.clear)
                        .frame(width: 350, height: 350)
                        .overlay(
                            Circle().stroke(Color.white.opacity(0.09), lineWidth: 15)
                            
                    )
            
            Circle()
                        .fill(Color.clear)
                        .frame(width: 350, height: 350)
                        .overlay(
                            Circle().trim(from:0, to: countToProgress())
                                .stroke(
                                    style: StrokeStyle(
                                        lineWidth: 15,
                                        lineCap: .round,
                                        lineJoin:.round
                                    )
                            )
                                .rotationEffect(.init(degrees: -90))
                                .foregroundColor(
                                    (completed() ? Color.green : Color.orange)
                            ).animation(
                                .easeInOut(duration: 0.2)
                            )
                    )


            VStack{
                Text(countToMinutes())
                    .font(.system(size: 65))
                    .fontWeight(.bold)
                    .foregroundColor(.white)

            }
        }.onReceive(self.timer) { (time) in
            if(self.start){

                if (self.count <= self.to - 1 ) {
                    if (self.count == self.to){
                        withAnimation(Animation.default){
                            self.count = 0
                            self.start.toggle()
                        }
                    }
                    else{
                        self.count += 1
                    }
                }
                else{
                    withAnimation(.default){
                        self.to = 300
                    }
                    self.start.toggle()
                }
                
               
            }
        }
        .onAppear{
            self.to = 300
            self.count = 0
            self.start = false
        }
        .padding(.top, 100)
        
        HStack(spacing: 20){
            Button(action: {
                
                if(self.count == 300){
                    self.count = 0
                    withAnimation(.default){
                        self.to = 300
                    }
                }
                self.start.toggle()
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


            }
            .shadow(radius: 6)

            Button(action: {
                self.count = 0
                self.to = 300
            }){
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
        }
        .padding(.top, 90)
    }
    
    @ViewBuilder
    func LongBreakTimerView() -> some View{
        ZStack{
            Circle()
                        .fill(Color.clear)
                        .frame(width: 350, height: 350)
                        .overlay(
                            Circle().stroke(Color.white.opacity(0.09), lineWidth: 15)
                            
                    )
            
            Circle()
                        .fill(Color.clear)
                        .frame(width: 350, height: 350)
                        .overlay(
                            Circle().trim(from:0, to: countToProgress())
                                .stroke(
                                    style: StrokeStyle(
                                        lineWidth: 15,
                                        lineCap: .round,
                                        lineJoin:.round
                                    )
                            )
                                .rotationEffect(.init(degrees: -90))
                                .foregroundColor(
                                    (completed() ? Color.green : Color.orange)
                            ).animation(
                                .easeInOut(duration: 0.2)
                            )
                    )


            VStack{
                Text(countToMinutes())
                    .font(.system(size: 65))
                    .fontWeight(.bold)
                    .foregroundColor(.white)

            }
        }.onReceive(self.timer) { (time) in
            if(self.start){

                if (self.count <= self.to - 1 ) {
                    if (self.count == self.to){
                        withAnimation(Animation.default){
                            self.count = 0
                            self.start.toggle()
                        }
                    }
                    else{
                        self.count += 1
                    }
                }
                else{
                    withAnimation(.default){
                        self.to = 900
                    }
                    self.start.toggle()
                }
                
               
            }
        }
        .onAppear{
            self.to = 900
            self.count = 0
            self.start = false
        }
        .padding(.top, 100)
        
        HStack(spacing: 20){
            Button(action: {
                
                if(self.count == 900){
                    self.count = 0
                    withAnimation(.default){
                        self.to = 900
                    }
                }
                self.start.toggle()
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


            }
            .shadow(radius: 6)

            Button(action: {
                self.count = 0
                self.to = 900
            }){
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
        }
        .padding(.top, 90)
    }

}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
    }
}

