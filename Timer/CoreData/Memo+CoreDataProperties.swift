//
//  Memo+CoreDataProperties.swift
//  Timer
//
//  Created by 井上智輝 on 2023-06-15.
//
//

import Foundation
import CoreData


extension Record {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Record> {
        return NSFetchRequest<Record>(entityName: "Record")
    }

    @NSManaged public var title: String?
    @NSManaged public var hour: Int16
    @NSManaged public var minute: Int16
    @NSManaged public var second: Int16
    @NSManaged public var memo: String?

}

extension Record : Identifiable {
    
}
