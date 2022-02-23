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
    @State var selectedPicker : Int = 3
    @State var hours: Int = 0
    @State var minutes: Int = 0
    @State var seconds: Int = 0
    @State var isSelected = false
    
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
           let hours = currentTime / 3600
           let minutes = (currentTime % 3600)/60
           let seconds = (currentTime % 3600)%60
        
        if(hours > 0){
            return "\(hours):\(minutes < 10 ? "0" : "")\(minutes):\(seconds < 10 ? "0" : "")\(seconds)"
        }
        
           return "\(minutes < 10 ? "0" : "")\(minutes):\(seconds < 10 ? "0" : "")\(seconds)"
       }
    
    func countToProgress() -> CGFloat {
            return (CGFloat(count) / CGFloat(to ))
        }
    
    func completed() -> Bool {
            return countToProgress() == 1
        }
    
    func getSeconds() -> Int{
        let currentHours = hours * 3600
        let currentMinutes = minutes * 60
        
        return currentHours + currentMinutes + seconds
    }
    
    @ViewBuilder
    func CustomTimerView() -> some View{
        ZStack{
            Circle()
                        .fill(Color.clear)
                        .frame(width: 400, height: 400)
                        .overlay(
                            Circle().stroke(Color.white.opacity(0.09), lineWidth: 15)
                            
                    )
            
            Circle()
                        .fill(Color.clear)
                        .frame(width: 400, height: 400)
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
                isSelected ?
                AnyView(
                    VStack{
                    Text(countToMinutes())
                    .font(.system(size: 65))
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.top, 70)
                        
                        Button(action: {
                            isSelected = false
                            self.to = -1
                            seconds = 0
                            hours = 0
                            minutes = 0
                            self.count = 0
                            start.toggle()
                        }){
                            HStack{
                            
                            Text("Reset")
                                .foregroundColor(Color.red)
                        }
                        .padding(.vertical)
                                                }
                        
                    }
                
                )
                :
                AnyView(
                    HStack {
                    Spacer()
                                Picker("", selection: $hours){
                                    ForEach(0..<24, id: \.self) { i in
                                        Text("\(i) hours").tag(i).foregroundColor(.white)
                                    }
                                }.pickerStyle(WheelPickerStyle())
                            .frame(width: 110).clipped().compositingGroup()
                    
                                Picker("", selection: $minutes){
                                    ForEach(0..<60, id: \.self) { i in
                                        Text("\(i) min").tag(i)
                                    }.foregroundColor(.white)
                                }.pickerStyle(WheelPickerStyle())
                            .frame(width: 110).clipped().compositingGroup()
                    
                                Picker("", selection: $seconds){
                                    ForEach(0..<60, id: \.self) { i in
                                        Text("\(i) sec").tag(i)
                                    }.foregroundColor(.white)
                                }.pickerStyle(WheelPickerStyle())
                            .frame(width: 110).clipped().compositingGroup()
                    Spacer()
            }.padding(.horizontal)
                    .padding(.top, -10)
                    )

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
                            isSelected = false
                        }
                    }
                    else{
                        self.count += 1
                    }
                }
                else{
                    withAnimation(.default){
                        self.to = -1
                        self.count = 0
                        isSelected = false
                        seconds = 0
                        minutes = 0
                        hours = 0
                    }
                    self.start.toggle()
                }
                
               
            }
        }
        .onAppear{
            isSelected = false
            self.to = -1
            self.count = 0
            self.start = false
            minutes = 0
            hours = 0
            seconds = 0
        }
        .padding(.top, 50)

        
        HStack(spacing: 20){
            Button(action: {
                if(getSeconds() > 0){
                    self.to = getSeconds()
                    isSelected = true
                }
                if(self.count == self.to){
                    self.count = 0
                    withAnimation(.default){
                        self.to = -1
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
                
                if(start == true){
                    start.toggle()
                }
                self.count = 0
                self.to = self.to
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
    func PomodoroTimerView() -> some View{
        ZStack{
            Circle()
                        .fill(Color.clear)
                        .frame(width: 400, height: 400)
                        .overlay(
                            Circle().stroke(Color.white.opacity(0.09), lineWidth: 15)
                            
                    )
            
            Circle()
                        .fill(Color.clear)
                        .frame(width: 400, height: 400)
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
        .padding(.top, 50)
        
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
                if(start == true){
                    start.toggle()
                }
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
                        .frame(width: 400, height: 400)
                        .overlay(
                            Circle().stroke(Color.white.opacity(0.09), lineWidth: 15)
                            
                    )
            
            Circle()
                        .fill(Color.clear)
                        .frame(width: 400, height: 400)
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
        .padding(.top, 50)
        
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
                if(start == true){
                    start.toggle()
                }
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
                        .frame(width: 400, height: 400)
                        .overlay(
                            Circle().stroke(Color.white.opacity(0.09), lineWidth: 15)
                            
                    )
            
            Circle()
                        .fill(Color.clear)
                        .frame(width: 400, height: 400)
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
        .padding(.top, 50)
        
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
                if(start == true){
                    start.toggle()
                }
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


