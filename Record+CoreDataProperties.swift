//
//  Record+CoreDataProperties.swift
//  Timer
//
//  Created by 井上智輝 on 2023-06-26.
//
//

import Foundation
import CoreData


extension Record {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Record> {
        return NSFetchRequest<Record>(entityName: "Record")
    }

    @NSManaged public var title: String?
    @NSManaged public var laptime: NSObject?
    @NSManaged public var time: Double
    @NSManaged public var date: Date?

}

extension Record : Identifiable {

}
