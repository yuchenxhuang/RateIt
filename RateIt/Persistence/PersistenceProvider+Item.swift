//
//  PersistenceProvider+Item.swift
//  RateIt
//
//  Created by Yu-Chen Huang on 7/8/21.
//

import CoreData

extension PersistenceProvider {
    func itemsRequest(for category: Category) -> NSFetchRequest<Item> {
        let request: NSFetchRequest<Item> = Item.fetchRequest()
        request.predicate = NSPredicate(format: "%K == %@", #keyPath(Item.category), category)
        request.sortDescriptors = [
            NSSortDescriptor(keyPath: \Item.favorite, ascending: false),
            NSSortDescriptor(keyPath: \Item.creationDate, ascending: false)
        ]
        return request
    }
    
    @discardableResult
    func createItem(with title: String, with rating: Int16, in list: Category) -> Item {
        let item = Item(context: context)
        item.title = title
        item.rating = rating
        item.creationDate = Date()
        item.notes = ""
        item.link = ""
        list.addToItems(item)
        try? context.save()
        return item
    }
    
    func toggle(_ item: Item) {
        item.favorite.toggle()
        try? context.save()
    }
    
    func update(_ item: Item, with title: String, with rating: Int16, with notes: String, with link: String) {
        item.title = title
        item.rating = rating
        item.notes = notes
        item.link = link
        try? context.save()
    }
    
    func delete(_ items: [Item]) {
        for item in items {
            context.delete(item)
        }
        try? context.save()
    }
    
}
