//
//  Schedule+CoreDataProperties.swift
//  FoucsApp(ToDo)
//
//  Created by Ebraheem Alnaqer on 12/09/2023.
//
//

import Foundation
import CoreData


extension Schedule {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Schedule> {
        return NSFetchRequest<Schedule>(entityName: "Schedule")
    }

    @NSManaged public var isCompleted: Bool
    @NSManaged public var desc: String?
    @NSManaged public var name: String?
    @NSManaged public var date: Date?

}

extension Schedule : Identifiable {

}
