//
//  FolderView.swift
//  Timer
//
//  Created by 井上智輝 on 2023-06-15.
//

import SwiftUI

// TODO: Coredataから取得した文字を表示するところを整える
// TODO: ソート機能
struct FolderView: View {
    @Binding var selection: Int
    @Environment(\.managedObjectContext) private var context
    @FetchRequest(
        entity: Record.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Record.title,
                                           ascending: false)],
        animation: .default
    )
    private var records: FetchedResults<Record>
    
    var body: some View {
        
        List {
            ForEach(records) { record in
                Card()
                    .overlay {
                        VStack(alignment: .leading) {
                            Text(record.title ?? "")
                            
                            HStack {
                                Text("\(record.hour)h")
                                Text("\(record.minute)m")
                                Text("\(record.second)s")
                            }
                        }
                    }
            }
            .onDelete(perform: deleteData)
            .listRowSeparator(.hidden)
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
        FolderView(selection: .constant(0))
    }
}
