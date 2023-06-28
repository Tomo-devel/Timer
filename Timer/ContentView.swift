//
//  ContentView.swift
//  Timer
//
//  Created by 井上智輝 on 2023-06-15.
//

import SwiftUI

enum TabMenu: CaseIterable {
    case stopwatch
    case timer
    case folder
}

struct ContentView: View {
    @StateObject var model: TimerManager = .init()
    @State var tabSelection: TabMenu = .timer
    @State var hour: Int = 0
    @State var minute: Int = 0
    @State var second: Int = 0
    @State var isShowRecordView: Bool = false

    var body: some View {
        
        NavigationStack {
            TabView(selection: $tabSelection) {
                StopWatchView(model: model,
                              tabSelection: $tabSelection)
                    .tabItem {
                        Label("StopWatch", systemImage: "stopwatch")
                            .foregroundColor(.cyan)
                    }
                    .tag(TabMenu.stopwatch)
                
                TimerView(model: model,
                          tabSelection: $tabSelection,
                          isShowRecordView: $isShowRecordView,
                          hour: $hour,
                          minute: $minute,
                          second: $second)
                    .tabItem {
                        Label("Timer", systemImage: "timer")
                            .foregroundColor(.cyan)
                    }
                    .tag(TabMenu.timer)
                
                FolderView(isShowRecordView: $isShowRecordView,
                           tabSelection: $tabSelection,
                           hour: $hour,
                           minute: $minute,
                           second: $second)
                .tabItem {
                    Label("フォルダー", systemImage: "folder")
                        .foregroundColor(.cyan)
                }
                .tag(TabMenu.folder)
            }
        }
        .sheet(isPresented: $isShowRecordView) {
            NavigationStack {
                RecordView(isShowRecordView: $isShowRecordView)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
