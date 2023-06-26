//
//  ContentView.swift
//  Timer
//
//  Created by 井上智輝 on 2023-06-15.
//

import SwiftUI

// TODO: selectionによってツールバーが変更できるか確かめる
struct ContentView: View {
    @StateObject var model: TimerManager = .init()
    @State var selection: Int = 2
    @State var hour: Int = 0
    @State var minute: Int = 0
    @State var second: Int = 0
    @State var isShowRecordView: Bool = false

    var body: some View {
        
        NavigationStack {
            TabView(selection: $selection) {
                StopWatchView(model: model)
                    .tabItem {
                        Label("StopWatch", systemImage: "stopwatch")
                            .foregroundColor(.cyan)
                    }
                    .tag(1)
                
                TimerView(model: model,
                          hour: $hour,
                          minute: $minute,
                          second: $second)
                    .tabItem {
                        Label("Timer", systemImage: "timer")
                            .foregroundColor(.cyan)
                    }
                    .tag(2)
                
                FolderView(selection: $selection,
                           hour: $hour,
                           minute: $minute,
                           second: $second)
                .tabItem {
                    Label("フォルダー", systemImage: "folder")
                        .foregroundColor(.cyan)
                }
                .tag(3)
            }
            .toolbar {
                Button {
                    isShowRecordView.toggle()
                    
                } label: {
                    Label("追加", systemImage: "plus")
                }
                .sheet(isPresented: $isShowRecordView) {
                    NavigationStack {
                        RecordView(isShowRecordView: $isShowRecordView)
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
