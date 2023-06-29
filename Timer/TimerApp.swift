//
//  TimerApp.swift
//  Timer
//
//  Created by 井上智輝 on 2023-06-15.
//

import SwiftUI

@main
struct TimerApp: App {
    private let persistence = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
                        ContentView()
                            .environment(\.managedObjectContext, persistence.container.viewContext)
                            .preferredColorScheme(.dark)
//            SampleView()
        }
    }
}
