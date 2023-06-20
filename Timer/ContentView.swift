//
//  ContentView.swift
//  Timer
//
//  Created by 井上智輝 on 2023-06-15.
//

import SwiftUI

struct ContentView: View {
    @State var selection: Int = 2
    @State var isShowRecordView: Bool = false
    
    var body: some View {
        
        NavigationStack {
            TabView(selection: $selection) {
                StopWatchView()
                    .tabItem {
                        Label("StopWatch", systemImage: "stopwatch")
                    }
                    .tag(1)
                
                TimerView()
                    .tabItem {
                        Label("Timer", systemImage: "timer")
                    }
                    .tag(2)
                
                FolderView(selection: $selection)
                    .tabItem {
                        Label("フォルダー", systemImage: "folder")
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
