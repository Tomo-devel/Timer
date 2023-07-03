//
//  StopWatchView.swift
//  Timer
//
//  Created by 井上智輝 on 2023-06-19.
//

import SwiftUI

struct StopWatchView: View {
    @Environment(\.managedObjectContext) private var context
    @ObservedObject var model: TimerManager
    @State private var formatter = StopWatchFormatter()
    @State private var startButton: String = "Start"
    @State private var resetButton: String = "Reset"
    @State private var isStarting: Bool = false
    @State private var isShowTextFieldAlert: Bool = false
    @State private var title: String = ""
    @Binding var tabSelection: TabMenu
    
    var body: some View {
        
        VStack {
            Text(NSNumber(value: model.stopwatch), formatter: formatter)
                .font(Font(UIFont.monospacedDigitSystemFont(ofSize: 50, weight: .light)))
                .padding()
            
            HStack {
                ZStack {
                    Circle()
                        .fill(.cyan)
                        .frame(width: 100)
                        .opacity(0.5)
                    
                    Button {
                        if isStarting {
                            model.getLaptime()
                            
                        } else {
                            model.resetStopWatch()
                        }
                        
                    } label: {
                        Text(resetButton)
                            .foregroundColor(.white)
                            .font(.title2)
                            .fontWeight(.bold)
                    }
                }
                .padding()
                
                Spacer()
                ZStack {
                    Circle()
                        .fill(.orange)
                        .frame(width: 100)
                        .opacity(0.5)
                    
                    Button {
                        if isStarting {
                            startButton = "Start"
                            resetButton = "Reset"
                            model.stop()
                            isStarting = false
                            
                        } else {
                            startButton = "Stop"
                            resetButton = "Lap"
                            model.startStopWatch()
                            isStarting = true
                        }
                        
                    } label: {
                        Text(startButton)
                            .foregroundColor(.orange)
                            .font(.title)
                            .fontWeight(.heavy)
                    }
                }
                .padding()
            }
            
            List(model.laptime, id: \.self) { lap in
                Text(NSNumber(value: lap), formatter: formatter)
                    .padding(.horizontal)
            }
            
            Spacer()
        }
        .toolbar {
            if tabSelection == .stopwatch {
                Button {
                    isShowTextFieldAlert = true
                    
                } label: {
                    Label("保存", systemImage: "square.and.arrow.down.fill")
                }
                .disabled(model.stopwatch <= 0.0 || isStarting)
            }
        }
        .alert("保存しますか？", isPresented: $isShowTextFieldAlert) {
            TextField("タイトル", text: $title)
                .foregroundColor(.black)
            
            Button("キャンセル", role: .cancel) {
                isShowTextFieldAlert = false
            }
            
            Button("保存") {
                saveData()
                isShowTextFieldAlert = false
                
            }
        }
    }
    
    private func saveData() {
        let newRecord = Record(context: context)
        newRecord.date = Date()
        if title.isEmpty {
            newRecord.title = "無題"
        } else {
            newRecord.title = title
        }
        newRecord.time = model.stopwatch
        newRecord.laptime = model.laptime as NSObject
        
        do {
            try context.save()
            title = ""
            
        } catch {
            print(error)
        }
    }
}

struct StopWatchView_Previews: PreviewProvider {
    static var previews: some View {
        StopWatchView(model: TimerManager(),
                      tabSelection: .constant(.stopwatch))
    }
}
