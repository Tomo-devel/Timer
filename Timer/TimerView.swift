//
//  TimerView.swift
//  Timer
//
//  Created by 井上智輝 on 2023-06-15.
//

import SwiftUI

struct TimerView: View {
    @ObservedObject var model: TimerManager
    @State private var screenSwitching: Bool = false
    @State private var frag: Bool = false
    @State private var notation: String = "Start"
    @Binding var hour: Int
    @Binding var minute: Int
    @Binding var second: Int
    
    var body: some View {
        
        VStack {
            if screenSwitching {
                HStack {
                    Group {
//                        Text(model.samleString)
                        Text("\(model.hour) h")

                        Text("\(model.minute10)\(model.minute) m")

                        Text("\(model.second10)\(model.second) s")
                    }
                    .font(Font(UIFont.monospacedDigitSystemFont(ofSize: 50,
                                                                weight: .light)))
                }
                
            } else {
                TimerPicker(hour: $hour,
                            minute: $minute,
                            second: $second)
            }
            
            HStack {
                Button {
                    model.cancel()
                    screenSwitching = false
                    notation = "Start"
                    frag = false
                    
                } label: {
                    Circle()
                        .fill(.cyan)
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
//                        model.sample(hour: hour, minute: minute, second: second)
                        model.startTimer(hour: hour,
                                         minute: minute,
                                         second: second)
                        notation = "Stop"
                        
                    } else if frag {
                        model.stop()
                        notation = "Start"
                        
                    } else {
//                        model.sample(hour: hour, minute: minute, second: second)
                        model.startTimer(hour: hour, minute: minute, second: second)
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
        TimerView(model: TimerManager(),
                  hour: .constant(0),
                  minute: .constant(0),
                  second: .constant(0))
    }
}
