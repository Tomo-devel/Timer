//
//  RecordView.swift
//  Timer
//
//  Created by 井上智輝 on 2023-06-19.
//

import SwiftUI

// TODO: 順番をつける処理 DBにソート用の数字を付与
struct RecordView: View {
    @Environment(\.managedObjectContext) private var context
    @State var hour: Int = 0
    @State var minute: Int = 0
    @State var second: Int = 0
    @State var workingTitle: String = ""
    @State var memo: String = ""
    @Binding var isShowRecordView: Bool
    
    var body: some View {
        
        ScrollView {
            VStack {
                TimerPicker(hour: $hour, minute: $minute, second: $second)
                    .padding(.top)
                
                TextField("作業名", text: $workingTitle)
                    .padding()
                    .border(.cyan, width: 3)
                    .opacity(0.6)
                    .cornerRadius(6)
                    .padding()
                    
//                TextEditor(text: $memo)
//                    .border(.white)
//                    .frame(height: 200)
//                    .padding()
            }
            .ignoresSafeArea(.keyboard, edges: .all)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        saveData()
                        isShowRecordView = false
                        
                    } label: {
                        Text("完了")
                    }
                    .disabled(workingTitle.isEmpty || hour == 0 && minute == 0 && second == 0)
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        isShowRecordView = false
                        
                    } label: {
                        Text("キャンセル")
                    }
                }
            }
        }
    }
    
    private func saveData() {
        let newFolder = Folder(context: context)
        newFolder.title =  workingTitle
        newFolder.hour = Int16(hour)
        newFolder.minute = Int16(minute)
        newFolder.second = Int16(second)
        newFolder.memo = memo
        
        do {
            try context.save()
                        
        } catch {
            print(error)
        }
    }
}


struct RecordView_Previews: PreviewProvider {
    static var previews: some View {
        RecordView(isShowRecordView: .constant(false))
    }
}
