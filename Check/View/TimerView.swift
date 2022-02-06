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
                    Text("Pomodoro Timer View").foregroundColor(.white)

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
                    }.padding(.top, 100)
                case 1:
                    Text("Short Break Timer View").foregroundColor(.white)

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
                    }.padding(.top, 100)
                case 2:
                    Text("Long Break Timer View").foregroundColor(.white)

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
                    }.padding(.top, 100)
                case 3:
                    Text("Custom Timer View").foregroundColor(.white)

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
                    }.padding(.top, 100)
                default:
                    Text("Error on Timer View").foregroundColor(.white)
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


                    }
                    .shadow(radius: 6)

                    Button(action: {

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
                

            }).edgesIgnoringSafeArea(.vertical)
            .padding(.top, -150)
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
    }
}
