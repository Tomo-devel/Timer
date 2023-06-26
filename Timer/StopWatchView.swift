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
    
    var body: some View {
        
        VStack {
            Text(NSNumber(value: model.stopwatch), formatter: formatter)
                .font(Font(UIFont.monospacedDigitSystemFont(ofSize: 50, weight: .light)))

            Button {
                model.startStopWatch()
                
            } label: {
                Text("samle")
            }
            .padding()
            
            Button {
                model.stop()
                
            } label: {
                Text("stop")
            }
        }
    }
}

struct StopWatchView_Previews: PreviewProvider {
    static var previews: some View {
        StopWatchView(model: TimerManager())
    }
}
