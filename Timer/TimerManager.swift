//
//  TimerViewModel.swift
//  Timer
//
//  Created by 井上智輝 on 2023-06-15.
//

import Foundation
import SwiftUI
import AudioToolbox

// TODO: 音を選べるようにするか決める
class TimerManager: ObservableObject {
    private var timerclass: Timer?
    private var total = 0
    private var moment_time: Double = 0.0
    @Published var timer = "0:00:00"
    @Published var stopwatch: Double = 0.0
    @Published var laptime: [Double] = []
    @Published var isShowAlert: Bool = false
    
    
    // FIXME: Timer -
    func startTimer(hour: Int, minute: Int, second: Int, screenSwitching: Bool) {
        stop()
        
        if !screenSwitching {
            total = second + ((minute + (hour * 60)) * 60)
        }
        
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .positional
        formatter.allowedUnits = [.hour, .minute, .second]
        timer = formatter.string(from: TimeInterval(self.total)) ?? ""
        
        timerclass = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            if self.total <= 0 {
                self.isShowAlert = true
                AudioServicesPlaySystemSound(SystemSoundID(1427))
                return
            }
            
            self.total -= 1
            self.timer = formatter.string(from: TimeInterval(self.total)) ?? ""
            print(self.timer)
        }
    }
    
    func stop() {
        timerclass?.invalidate()
    }
    
    // FIXME: StopWatch -
    func startStopWatch() {
        timerclass = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { _ in
            self.stopwatch += 0.01
            print(self.stopwatch)
        }
        
        RunLoop.current.add(timerclass!, forMode: .common)
    }
    
    func getLaptime() {
        if laptime.isEmpty {
            laptime.append(stopwatch)
            
        } else {
            laptime.append(stopwatch - moment_time)
        }
        
        moment_time = stopwatch
    }
    
    func resetStopWatch() {
        timerclass?.invalidate()
        stopwatch = 0.0
        laptime.removeAll()
    }
}


