//
//  Task+CoreDataProperties.swift
//  FoucsApp(ToDo)
//
//  Created by Ebraheem Alnaqer on 12/09/2023.
//
//

import Foundation
import CoreData


extension Task {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task")
    }

    @NSManaged public var date: Date?
    @NSManaged public var desc: String?
    @NSManaged public var isCompleted: Bool
    @NSManaged public var name: String?

}

extension Task : Identifiable {

}
