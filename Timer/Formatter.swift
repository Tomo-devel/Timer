//
//  TimerFormatter.swift
//  Timer
//
//  Created by 井上智輝 on 2023-06-26.
//

import Foundation

class StopWatchFormatter: Formatter {
    let componentFormatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.zeroFormattingBehavior = .pad
        return formatter
    }()

    override func string(for obj: Any?) -> String? {
        guard let time = obj as? TimeInterval else {
            return nil
        }
        
        guard let formattedString = componentFormatter.string(from: time) else {
            return nil
        }
        
        let hunredths = Int((time.truncatingRemainder(dividingBy: 1)) * 100)
        let decimalSperator = Locale.current.decimalSeparator ?? "."
        return String(format: "%@%@%.2d", formattedString, decimalSperator, hunredths)
    }
}
