//
//  TimerViewModel.swift
//  Timer
//
//  Created by 井上智輝 on 2023-06-15.
//

import Foundation

class TimerViewModel: ObservableObject {
    @Published var timer: Timer?
    @Published var hour: Int = 1
    @Published var minute: Int = 1
    @Published var second: Int = 1
    var count: [Int] = []
    
    
    func start(hour: Int, minute: Int, second: Int) {
        count.removeAll()
        count.append(second)
        count.append(minute)
        count.append(hour)
        
        self.hour = hour
        self.minute = minute
        self.second = second
        
        timer?.invalidate()
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            if self.second > 0 {
                self.second -= 1
                
            } else if self.minute > 0 {
                self.second = 59
                self.minute -= 1
                
            } else if self.hour > 0 {
                self.second = 59
                self.minute = 59
                self.hour -= 1
                
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
