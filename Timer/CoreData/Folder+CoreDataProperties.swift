//
//  Folder+CoreDataProperties.swift
//  Timer
//
//  Created by 井上智輝 on 2023-06-26.
//
//

import Foundation
import CoreData


extension Folder {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Folder> {
        return NSFetchRequest<Folder>(entityName: "Folder")
    }

    @NSManaged public var hour: Int16
    @NSManaged public var memo: String?
    @NSManaged public var minute: Int16
    @NSManaged public var second: Int16
    @NSManaged public var title: String?

}

extension Folder : Identifiable {

}
