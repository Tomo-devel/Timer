//
//  LapView.swift
//  Timer
//
//  Created by 井上智輝 on 2023-07-03.
//

import SwiftUI

struct LapView: View {
    @State private var formatter = StopWatchFormatter()
    let title: String
    let date: String
    let time: Double
    let laptime: [Double]
    
    var body: some View {
        
        VStack {
            List {
                Section("タイム") {
                    Text(NSNumber(value: time), formatter: formatter)
                }
        
                Section("ラップタイム") {
                    ForEach(laptime, id: \.self) { lap in
                        Text(NSNumber(value: lap), formatter: formatter)
                            .foregroundColor(minimum_max_colour(lap: lap,
                                                                laptime: laptime))
                    }
                }
            }
        }
        .navigationTitle(title)
    }
    
    private func minimum_max_colour(lap: Double, laptime: [Double]) -> Color {
        var max = laptime[0]
        var min = laptime[0]
        
        for lap in laptime {
            if lap > max {
                max = lap
            } else if lap < min {
                min = lap
            }
        }
        
        if max == lap {
            return .red
            
        } else if min == lap {
            return .cyan
            
        } else {
            return .white
        }
    }
}

struct LapView_Previews: PreviewProvider {
    static var previews: some View {
        LapView(title: "",
                date: "",
                time: 0.0,
                laptime: [])
    }
}
