//
//  TimerViewModel.swift
//  Timer
//
//  Created by 井上智輝 on 2023-06-15.
//

import Foundation
import SwiftUI

class TimerManager: ObservableObject {
    private var timerclass: Timer?
    private var total = 0
    @Published var timer = "0:00:00"
    @Published var stopwatch: TimeInterval = 0.0
    @Published var laptime: [TimeInterval] = []
    
    
    // FIXME: Timer -
    func startTimer(hour: Int, minute: Int, second: Int, screenSwitching: Bool) {
        stop()
        
        if !screenSwitching {
            total = second + ((minute + (hour * 60)) * 60)
        }
        
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .positional
        formatter.allowedUnits = [.hour, .minute, .second]
        self.timer = formatter.string(from: TimeInterval(self.total)) ?? ""
        
        timerclass = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            if self.total <= 0 {
                // TODO: 音を鳴らす処理
                return
            }
            
            self.total -= 1
            self.timer = formatter.string(from: TimeInterval(self.total)) ?? ""
        }
    }
    
    func stop() {
        timerclass?.invalidate()
    }
    
    // FIXME: StopWatch -
    func startStopWatch() {
        timerclass = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { _ in
            self.stopwatch += 0.01
        }
        
        RunLoop.current.add(timerclass!, forMode: .common)
    }
    
    func getLaptime() {
        laptime.append(stopwatch)
    }
    
    func resetStopWatch() {
        timerclass?.invalidate()
        stopwatch = 0.0
        laptime.removeAll()
    }
}


