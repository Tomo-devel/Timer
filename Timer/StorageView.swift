//
//  StorageView.swift
//  Timer
//
//  Created by 井上智輝 on 2023-06-15.
//

import SwiftUI

struct StorageView: View {
    @Environment(\.managedObjectContext) private var context
    @FetchRequest(
        entity: Memo.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Memo.title,
                                         ascending: false)],
        animation: .default
    )
    private var memos: FetchedResults<Memo>
    
    var body: some View {
        
        VStack {
            ForEach(memos) { memo in
                Text(memo.title ?? "")
                Text("\(memo.hour)")
                Text("\(memo.minute)")
                Text("\(memo.second)")
                Text(memo.memo ?? "")
            }
        }

    }
}

struct StorageView_Previews: PreviewProvider {
    static var previews: some View {
        StorageView()
    }
}
