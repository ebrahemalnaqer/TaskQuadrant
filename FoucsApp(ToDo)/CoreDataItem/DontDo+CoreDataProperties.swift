//
//  DontDo+CoreDataProperties.swift
//  FoucsApp(ToDo)
//
//  Created by Ebraheem Alnaqer on 12/09/2023.
//
//

import Foundation
import CoreData


extension DontDo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DontDo> {
        return NSFetchRequest<DontDo>(entityName: "DontDo")
    }

    @NSManaged public var isCompleted: Bool
    @NSManaged public var desc: String?
    @NSManaged public var name: String?
    @NSManaged public var date: Date?

}

extension DontDo : Identifiable {

}
