//
//  TimerViewModel.swift
//  Timer
//
//  Created by 井上智輝 on 2023-06-15.
//

import Foundation

class TimerModel: ObservableObject {
    @Published var timer: Timer?
    @Published var hour: Int = 0
    @Published var minute10: Int = 0
    @Published var minute: Int = 0
    @Published var second10: Int = 0
    @Published var second: Int = 0
    var count: [Int] = []
    
    
    func start(hour: Int, minute: Int, second: Int) {
        count.removeAll()
        count.append(second)
        count.append(minute)
        count.append(hour)
        
        self.hour = hour
        
        if minute >= 10 {
            self.minute10 = Int(String(minute).prefix(1)) ?? 0
            self.minute = Int(String(minute).suffix(1)) ?? 0
        } else {
            self.minute10 = 0
            self.minute = minute
        }
        
        if second >= 10 {
            self.second10 = Int(String(second).prefix(1)) ?? 0
            self.second = Int(String(second).suffix(1)) ?? 0
        } else {
            self.second10 = 0
            self.second = second
        }
        
        stop()
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            if self.second > 0 {
                self.second -= 1
                
            } else if self.second10 > 0 {
                self.second10 -= 1
                self.second = 9
                
            } else if minute > 0 && self.minute > 0 {
                self.minute -= 1
                self.second = 9
                self.second10 = 5
                
            } else if self.minute10 > 0 {
                self.minute10 -= 1
                self.minute = 9
                
            } else if hour > 0 {
                self.hour -= 1
                self.minute = 9
                self.minute10 = 5
                self.second = 9
                self.second10 = 5
                
            } else {
                self.timer?.invalidate()
            }
        }
    }
    
    func stop() {
        timer?.invalidate()
    }
    
    func cancel() {
        timer?.invalidate()
        second = count[0]
        minute = count[1]
        hour = count[2]
    }
}
