//
//  FolderView.swift
//  Timer
//
//  Created by 井上智輝 on 2023-06-15.
//

import SwiftUI

struct FolderView: View {
    @Binding var selection: Int
    @Binding var hour: Int
    @Binding var minute: Int
    @Binding var second: Int
    @Environment(\.managedObjectContext) private var context
    @FetchRequest(
        entity: Record.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Record.title,
                                           ascending: true)],
        animation: .default
    )
    private var records: FetchedResults<Record>
    
    var body: some View {
        
        List {
            ForEach(records) { record in
                Button {
                    hour = Int(record.hour)
                    minute = Int(record.minute)
                    second = Int(record.second)
                    selection = 2
                    
                } label: {
                    HStack() {
                        Text(record.title ?? "読み込む中")
                            .font(.title3)
                            .fontWeight(.bold)
                            .lineLimit(1)
                        
                        Spacer()
                        HStack {
                            Text("\(record.hour)h")
                            Text("\(record.minute)m")
                            Text("\(record.second)s")
                        }
                        .font(.title3)
                        .fontWeight(.heavy)
                        .foregroundColor(.cyan)
                    }
                    .padding()
                }
            }
            .onDelete(perform: deleteData)
        }
        .listStyle(.plain)
    }
    
    private func deleteData(offsets: IndexSet) {
        for index in offsets {
            context.delete(records[index])
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
        FolderView(selection: .constant(0),
                   hour: .constant(0),
                   minute: .constant(0),
                   second: .constant(0))
    }
}
