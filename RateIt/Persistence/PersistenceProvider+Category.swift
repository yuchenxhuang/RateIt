//
//  PersistenceProvider+Category.swift
//  RateIt
//
//  Created by Yu-Chen Huang on 7/8/21.
//

import Foundation
import CoreData

extension PersistenceProvider {
    
    // DATE ADDED
    var newestCategoriesRequest: NSFetchRequest<Category> {
        let request: NSFetchRequest<Category> = Category.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Category.dateAdded, ascending: false)]
        return request
    }
    
    var oldestCategoriesRequest: NSFetchRequest<Category> {
        let request: NSFetchRequest<Category> = Category.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Category.dateAdded, ascending: true)]
        return request
    }
    
    // DATE EDITED
    var touchedCategoriesRequest: NSFetchRequest<Category> {
        let request: NSFetchRequest<Category> = Category.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Category.dateModified, ascending: false)]
        return request
    }
    
    var untouchedCategoriesRequest: NSFetchRequest<Category> {
        let request: NSFetchRequest<Category> = Category.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Category.dateModified, ascending: true)]
        return request
    }
    
    // ALPHABETICAL
    var atozCategoriesRequest: NSFetchRequest<Category> {
        let request: NSFetchRequest<Category> = Category.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Category.title, ascending: true)]
        return request
    }
    
    var ztoaCategoriesRequest: NSFetchRequest<Category> {
        let request: NSFetchRequest<Category> = Category.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Category.title, ascending: false)]
        return request
    }
    
    @discardableResult
    func createCategory(with title: String, with color: String, with icon: String) -> Category {
        let category = Category(context: context)
        category.title = title
        category.color = color
        category.dateAdded = Date()
        category.dateModified = Date()
        category.icon = icon
        try? context.save()
        return category
    }
    
    func update(_ category: Category, with title: String, with color: String, with icon: String) {
        category.title = title
        category.color = color
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
