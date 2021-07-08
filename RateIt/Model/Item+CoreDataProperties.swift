//
//  Item+CoreDataProperties.swift
//  RateIt
//
//  Created by Yu-Chen Huang on 7/7/21.
//
//

import Foundation
import CoreData


extension Item {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item")
    }

    @NSManaged public var name: String?
    @NSManaged public var rating: Int16
    @NSManaged public var date: Date?
    @NSManaged public var favorite: Bool
    @NSManaged public var notes: String?
    @NSManaged public var id: UUID?
    @NSManaged public var category: Category?

}

extension Item : Identifiable {

}
