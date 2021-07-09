//
//  PersistenceProvider+Category.swift
//  RateIt
//
//  Created by Yu-Chen Huang on 7/8/21.
//

import Foundation
import CoreData

extension PersistenceProvider {
    var allCategoriesRequest: NSFetchRequest<Category> {
        let request: NSFetchRequest<Category> = Category.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Category.creationDate, ascending: false)]
        return request
    }
    
    @discardableResult
    func createCategory(with title: String) -> Category {
        let category = Category(context: context)
        category.title = title
        category.creationDate = Date()
        try? context.save()
        return category
    }
    
    func update(_ category: Category, with title: String) {
        category.title = title
        try? context.save()
    }
    
    func refresh(_ category: Category?) {
        try? context.save()
    }
    
    func delete(_ categories: [Category]) {
        for category in categories {
            context.delete(category)
        }
        try? context.save()
    }
    
    
}
