//
//  Delegate+CoreDataProperties.swift
//  FoucsApp(ToDo)
//
//  Created by Ebraheem Alnaqer on 12/09/2023.
//
//

import Foundation
import CoreData


extension Delegate {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Delegate> {
        return NSFetchRequest<Delegate>(entityName: "Delegate")
    }

    @NSManaged public var isCompleted: Bool
    @NSManaged public var desc: String?
    @NSManaged public var name: String?
    @NSManaged public var date: Date?

}

extension Delegate : Identifiable {

}
