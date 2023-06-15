//
//  Memo+CoreDataProperties.swift
//  Timer
//
//  Created by 井上智輝 on 2023-06-15.
//
//

import Foundation
import CoreData


extension Memo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Memo> {
        return NSFetchRequest<Memo>(entityName: "Memo")
    }

    @NSManaged public var title: String?
    @NSManaged public var hour: Int64
    @NSManaged public var minute: Int64
    @NSManaged public var second: Int64
    @NSManaged public var memo: String?

}

extension Memo : Identifiable {
    
}
