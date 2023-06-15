//
//  TimerView.swift
//  Timer
//
//  Created by 井上智輝 on 2023-06-15.
//

import SwiftUI

struct TimerView: View {
    @StateObject var model: TimerViewModel = .init()
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
                    Text("\(model.hour) h")
                    
                    Text("\(model.minute) m")
                    
                    Text("\(model.second) s")
                }
                
            } else {
                HStack(spacing: 0) {
                    Group {
                        Picker(selection: $hour) {
                            ForEach(0 ..< 24) { num in
                                Text("\(num)")
                            }
                            
                        } label: {
                            Text("TIME")
                        }
                        
                        Picker(selection: $minute) {
                            ForEach(0 ..< 60) { num in
                                Text("\(num)")
                            }
                            
                        } label: {
                            Text("TIME")
                        }
                        
                        Picker(selection: $second) {
                            ForEach(0 ..< 60) { num in
                                Text("\(num)")
                            }
                            
                        } label: {
                            Text("TIME")
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                }
            }
            
            Spacer()
            HStack {
                Button {
                    model.cancel()
                    screenSwitching = false
                    notation = "Start"
                    frag = false
                    
                } label: {
                    Text("Cancel")
                }
                .padding()
                
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
                    Text(notation)
                }
                .padding()
            }
            
            Spacer()
        }
        .preferredColorScheme(.dark)
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
    }
}
