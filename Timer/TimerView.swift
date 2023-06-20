//
//  TimerView.swift
//  Timer
//
//  Created by 井上智輝 on 2023-06-15.
//

import SwiftUI

struct TimerView: View {
    @StateObject var model: TimerModel = .init()
    @State private var screenSwitching: Bool = false
    @State private var frag: Bool = false
    @State private var notation: String = "Start"
    @State private var hour: Int = 0
    @State private var minute: Int = 0
    @State private var second: Int = 0
    
    var body: some View {
        
        VStack {
            Spacer()
            if screenSwitching {
                HStack {
                    Group {
                        Text("\(model.hour) h")
                        
                        Text("\(model.minute10)\(model.minute) m")
                        
                        Text("\(model.second10)\(model.second) s")
                    }
                    .font(.largeTitle)
                }
                
            } else {
                TimerPicker(hour: $hour, minute: $minute, second: $second)
            }
            
            Spacer()
            HStack {
                Button {
                    model.cancel()
                    screenSwitching = false
                    notation = "Start"
                    frag = false
                    
                } label: {
                    Circle()
                        .fill(.blue)
                        .frame(width: 100)
                        .opacity(0.5)
                        .overlay {
                            Text("Cancel")
                                .foregroundColor(.white)
                                .font(.title2)
                                .fontWeight(.bold)
                        }
                }
                .padding()
                .disabled(!screenSwitching)
                
                Spacer()
                Button {
                    if !screenSwitching {
                        screenSwitching = true
                        model.start(hour: hour, minute: minute, second: second)
                        notation = "Stop"
                        
                    } else if frag {
                        model.stop()
                        notation = "Start"
                        
                    } else {
                        model.start(hour: hour, minute: minute, second: second)
                        notation = "Stop"
                    }
                    
                    frag.toggle()
                    
                } label: {
                    Circle()
                        .fill(.orange)
                        .opacity(0.3)
                        .frame(width: 100)
                        .overlay {
                            Text(notation)
                                .foregroundColor(.orange)
                                .font(.title)
                                .fontWeight(.heavy)
                        }
                }
                .padding()
                .disabled(hour <= 0 && minute <= 0 && second <= 0)
            }
            
            Spacer()
        }
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
    }
}
