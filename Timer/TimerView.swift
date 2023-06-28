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
    @State private var startButton: String = "Start"
    @Binding var tabSelection: TabMenu
    @Binding var isShowRecordView: Bool
    @Binding var hour: Int
    @Binding var minute: Int
    @Binding var second: Int
    
    var body: some View {
        
        VStack {
            if screenSwitching {
                HStack {
                    Text(model.timer)
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
                    model.stop()
                    screenSwitching = false
                    startButton = "Start"
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
                        model.startTimer(hour: hour,
                                     minute: minute,
                                     second: second, screenSwitching: screenSwitching)
                        
                        screenSwitching = true
                        startButton = "Stop"
                        
                    } else if frag {
                        model.stop()
                        startButton = "Start"
                        
                    } else {
                        model.startTimer(hour: hour,
                                     minute: minute,
                                     second: second, screenSwitching: screenSwitching)
                        
                        startButton = "Stop"
                    }
                    
                    frag.toggle()
                    
                } label: {
                    Circle()
                        .fill(.orange)
                        .opacity(0.3)
                        .frame(width: 100)
                        .overlay {
                            Text(startButton)
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
        .toolbar {
            if tabSelection == .timer {
                Button {
                    isShowRecordView.toggle()
                    
                } label: {
                    Label("追加", systemImage: "plus")
                }
            }
        }
    }
}

struct TimerView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView(model: TimerManager(),
                  tabSelection: .constant(.timer),
                  isShowRecordView: .constant(false),
                  hour: .constant(0),
                  minute: .constant(0),
                  second: .constant(0))
    }
}
