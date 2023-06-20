//
//  RecordView.swift
//  Timer
//
//  Created by 井上智輝 on 2023-06-19.
//

import SwiftUI

// TODO: Viewを整える
// TODO: タイトルとメモ欄に文字制限
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
                
                TextEditor(text: $memo)
                    .border(.white)
                    .frame(height: 200)
                    .padding()
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
        // ここは後で入力できるようにする
        let newRecord = Record(context: context)
        newRecord.title =  workingTitle
        newRecord.hour = Int16(hour)
        newRecord.minute = Int16(minute)
        newRecord.second = Int16(second)
        newRecord.memo = memo
        
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
