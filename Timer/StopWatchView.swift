//
//  StopWatchView.swift
//  Timer
//
//  Created by 井上智輝 on 2023-06-19.
//

import SwiftUI

struct StopWatchView: View {
    @ObservedObject var model: TimerManager
    @State private var formatter = TimerFormatter()
    @State private var startButton: String = "Start"
    @State private var resetButton: String = "Reset"
    @State private var isStarting: Bool = false
    
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

                            model.reseStopWatch()
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
            
            List(model.laptimeArray, id: \.self) { lap in
                Text(NSNumber(value: lap), formatter: formatter)
            }
            
            Spacer()
        }
    }
}

struct StopWatchView_Previews: PreviewProvider {
    static var previews: some View {
        StopWatchView(model: TimerManager())
    }
}
