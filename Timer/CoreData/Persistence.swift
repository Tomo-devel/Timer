//
//  Persistence.swift
//  Timer
//
//  Created by 井上智輝 on 2023-06-15.
//

import Foundation
import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        let newFolderModel = Folder(context: viewContext)
        let newRecordModel = Record(context: viewContext)
    
        newFolderModel.title = ""
        newFolderModel.hour = 0
        newFolderModel.minute = 0
        newFolderModel.second = 0
        newFolderModel.memo = ""
        
        newRecordModel.title = ""
        newRecordModel.time = 0.0
        newRecordModel.laptime = [0.0] as NSObject
        newRecordModel.date = Date()
        
        do {
            try viewContext.save()
            
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "RecordModel")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
