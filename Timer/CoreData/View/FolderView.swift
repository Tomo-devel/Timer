//
//  FolderView.swift
//  Timer
//
//  Created by 井上智輝 on 2023-06-15.
//

import SwiftUI

// TODO: ストップウォッチの記録も残せるようにピッカーのセグメントを用意する。

enum Tool: CaseIterable {
    case stopwatch
    case timer
    
    func changeJP() -> String {
        switch self {
        case .stopwatch:
            return "StopWatch"
            
        case .timer:
            return "Timer"
        }
    }
}

struct FolderView: View {
    @State private var pickerSelection: Tool = .timer
    @Binding var isShowRecordView: Bool
    @Binding var tabSelection: TabMenu
    @Binding var hour: Int
    @Binding var minute: Int
    @Binding var second: Int
    @Environment(\.managedObjectContext) private var context
    @FetchRequest(
        entity: Folder.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Folder.title,
                                           ascending: true)],
        animation: .default
    )
    private var folders: FetchedResults<Folder>

    @FetchRequest(
        entity: Record.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Record.title,
                                           ascending: true)],
        animation: .default
    )
    private var records: FetchedResults<Record>
    
    
    var body: some View {
        
        VStack {
            if pickerSelection == .stopwatch {
                List {
                    ForEach(records) { record in
                        Text(record.title ?? "読み込み中")
                    }
                }
                
            } else {
                List {
                    ForEach(folders) { folder in
                        Button {
                            hour = Int(folder.hour)
                            minute = Int(folder.minute)
                            second = Int(folder.second)
                            tabSelection = .timer
                            
                        } label: {
                            HStack() {
                                Text(folder.title ?? "読み込む中")
                                    .font(.title3)
                                    .fontWeight(.bold)
                                    .lineLimit(1)
                                
                                Spacer()
                                HStack {
                                    Text("\(folder.hour)h")
                                    Text("\(folder.minute)m")
                                    Text("\(folder.second)s")
                                }
                                .font(.title3)
                                .fontWeight(.heavy)
                                .foregroundColor(.cyan)
                            }
                            .padding()
                        }
                    }
                    .onDelete(perform: deleteData)
                    .listRowSeparatorTint(.gray)
                }
                .listStyle(.plain)
            }
        }
        .toolbar {
            if tabSelection == .folder {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        isShowRecordView.toggle()
                        
                    } label: {
                        Label("追加", systemImage: "plus")
                    }
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Picker(selection: $pickerSelection) {
                        ForEach(Tool.allCases, id: \.self) { tool in
                            Text(tool.changeJP())
                                .tag(tool)
                        }
                        
                    } label: {
                        Text("change")
                    }
                    .pickerStyle(.segmented)
                }
            }
        }
    }
    
    private func deleteData(offsets: IndexSet) {
        for index in offsets {
            context.delete(folders[index])
        }
        
        do {
            try context.save()
            
        } catch {
            print(error)
        }
    }
}

struct FolderView_Previews: PreviewProvider {
    static var previews: some View {
        FolderView(isShowRecordView: .constant(false),
                   tabSelection: .constant(.folder),
                   hour: .constant(0),
                   minute: .constant(0),
                   second: .constant(0))
    }
}
