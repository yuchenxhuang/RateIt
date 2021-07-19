//
//  PersistenceProvider+Category.swift
//  RateIt
//
//  Created by Yu-Chen Huang on 7/8/21.
//

import Foundation
import CoreData

extension PersistenceProvider {
    
    func allCategoriesRequest( sortedBy: String ) -> NSFetchRequest<Category> {
        let request: NSFetchRequest<Category> = Category.fetchRequest()
        if sortedBy == "newest" { request.sortDescriptors = [ NSSortDescriptor(keyPath: \Category.dateAdded, ascending: false) ] }
        else if sortedBy == "oldest" { request.sortDescriptors = [ NSSortDescriptor(keyPath: \Category.dateAdded, ascending: true) ] }
        else if sortedBy == "atoz" { request.sortDescriptors = [ NSSortDescriptor(keyPath: \Category.title, ascending: true) ] }
        else if sortedBy == "ztoa" { request.sortDescriptors = [ NSSortDescriptor(keyPath: \Category.title, ascending: false) ] }
        else if sortedBy == "rainbow" { request.sortDescriptors = [NSSortDescriptor(keyPath: \Category.colorOrder, ascending: true) ] }
        else if sortedBy == "touched" { request.sortDescriptors = [ NSSortDescriptor(keyPath: \Category.dateModified, ascending: false) ] }
        else { request.sortDescriptors = [ NSSortDescriptor(keyPath: \Category.dateAdded, ascending: false) ] }
        return request
    }

    @discardableResult
    func createCategory(with title: String, with color: String, with icon: String) -> Category {
        let category = Category(context: context)
        category.title = title
        category.color = color
        category.colorOrder = getColorOrder(color: color)
        category.dateAdded = Date()
        category.dateModified = Date()
        category.icon = icon
        try? context.save()
        return category
    }
    
    func update(_ category: Category, with title: String, with color: String, with icon: String) {
        category.title = title
        category.color = color
        category.colorOrder = getColorOrder(color: color)
        category.icon = icon
        category.dateModified = Date()
        try? context.save()
    }
    
    func delete(_ categories: [Category]) {
        for category in categories {
            context.delete(category)
        }
        try? context.save()
    }
}
