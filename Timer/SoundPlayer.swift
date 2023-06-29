//
//  SoundPlayer.swift
//  Timer
//
//  Created by 井上智輝 on 2023-06-29.
//

import SwiftUI
import AudioToolbox

struct SampleView: View {
    var body: some View {
        
        NavigationStack {
            List(0 ..< 2000) { sound in
                Button {
                    AudioServicesPlaySystemSound(SystemSoundID(sound))
                    
                } label: {
                    Text(sound.description)
                }
            }
        }
    }
}

