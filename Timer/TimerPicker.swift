//
//  TimerPicker.swift
//  Timer
//
//  Created by 井上智輝 on 2023-06-15.
//

import SwiftUI

struct TimerPicker: View {
    @Binding var hour: Int
    @Binding var minute: Int
    @Binding var second: Int
    
    var body: some View {
        
        HStack(spacing: -15) {
            Group {
                Picker(selection: $hour) {
                    ForEach(0 ..< 24) { num in
                        Text("\(num)")
                    }
                    
                } label: {
                    Text("TIME")
                }
                
                Picker(selection: $minute) {
                    ForEach(0 ..< 60) { num in
                        Text("\(num)")
                    }
                    
                } label: {
                    Text("TIME")
                }
                
                Picker(selection: $second) {
                    ForEach(0 ..< 60) { num in
                        Text("\(num)")
                    }
                    
                } label: {
                    Text("TIME")
                }
            }
            .pickerStyle(WheelPickerStyle())
        }
    }
}

struct TimerPicker_Previews: PreviewProvider {
    static var previews: some View {
        TimerPicker(hour: .constant(0), minute: .constant(0), second: .constant(0))
    }
}
