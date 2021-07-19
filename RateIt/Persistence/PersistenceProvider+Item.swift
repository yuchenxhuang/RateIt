//
//  PersistenceProvider+Item.swift
//  RateIt
//
//  Created by Yu-Chen Huang on 7/8/21.
//

import CoreData

extension PersistenceProvider {
    
    func allItemsRequest( sortedBy: String ) -> NSFetchRequest<Item> {
        let request: NSFetchRequest<Item> = Item.fetchRequest()
        if sortedBy == "favorite" {  request.sortDescriptors = [
            NSSortDescriptor(keyPath: \Item.favorite, ascending: false),
            NSSortDescriptor(keyPath: \Item.rating, ascending: false), ]
        }
        else if sortedBy == "newest" { request.sortDescriptors = [ NSSortDescriptor(keyPath: \Item.dateAdded, ascending: false), ] }
        else if sortedBy == "oldest" { request.sortDescriptors = [ NSSortDescriptor(keyPath: \Item.dateAdded, ascending: true), ] }
        else if sortedBy == "best" { request.sortDescriptors = [ NSSortDescriptor(keyPath: \Item.rating, ascending: false), ]  }
        else if sortedBy == "worst" { request.sortDescriptors = [ NSSortDescriptor(keyPath: \Item.rating, ascending: true), ] }
        else if sortedBy == "atoz" { request.sortDescriptors = [ NSSortDescriptor(keyPath: \Item.title, ascending: true), ] }
        else if sortedBy == "ztoa" { request.sortDescriptors = [ NSSortDescriptor(keyPath: \Item.title, ascending: false), ] }
        else if sortedBy == "touched" { request.sortDescriptors = [ NSSortDescriptor(keyPath: \Item.dateModified, ascending: false), ] }
        else { request.sortDescriptors = [ NSSortDescriptor(keyPath: \Item.dateAdded, ascending: false), ] }
        return request
    }
    
    func favoriteItemsRequest(for category: Category) -> NSFetchRequest<Item> {
        let request: NSFetchRequest<Item> = Item.fetchRequest()
        request.predicate = NSPredicate(format: "%K == %@", #keyPath(Item.category), category)
        request.sortDescriptors = [
            NSSortDescriptor(keyPath: \Item.favorite, ascending: false),
            NSSortDescriptor(keyPath: \Item.rating, ascending: false)
        ]
        return request
    }
    
    func newestItemsRequest(for category: Category) -> NSFetchRequest<Item> {
        let request: NSFetchRequest<Item> = Item.fetchRequest()
        request.predicate = NSPredicate(format: "%K == %@", #keyPath(Item.category), category)
        request.sortDescriptors = [
            NSSortDescriptor(keyPath: \Item.dateAdded, ascending: false)
        ]
        return request
    }
    
    func oldestItemsRequest(for category: Category) -> NSFetchRequest<Item> {
        let request: NSFetchRequest<Item> = Item.fetchRequest()
        request.predicate = NSPredicate(format: "%K == %@", #keyPath(Item.category), category)
        request.sortDescriptors = [
            NSSortDescriptor(keyPath: \Item.dateAdded, ascending: true)
        ]
        return request
    }
    
    func bestItemsRequest(for category: Category) -> NSFetchRequest<Item> {
        let request: NSFetchRequest<Item> = Item.fetchRequest()
        request.predicate = NSPredicate(format: "%K == %@", #keyPath(Item.category), category)
        request.sortDescriptors = [
            NSSortDescriptor(keyPath: \Item.rating, ascending: false)
        ]
        return request
    }
    
    func worstItemsRequest(for category: Category) -> NSFetchRequest<Item> {
        let request: NSFetchRequest<Item> = Item.fetchRequest()
        request.predicate = NSPredicate(format: "%K == %@", #keyPath(Item.category), category)
        request.sortDescriptors = [
            NSSortDescriptor(keyPath: \Item.rating, ascending: true)
        ]
        return request
    }
    
    func atozItemsRequest(for category: Category) -> NSFetchRequest<Item> {
        let request: NSFetchRequest<Item> = Item.fetchRequest()
        request.predicate = NSPredicate(format: "%K == %@", #keyPath(Item.category), category)
        request.sortDescriptors = [
            NSSortDescriptor(keyPath: \Item.title, ascending: true)
        ]
        return request
    }
    
    func ztoaItemsRequest(for category: Category) -> NSFetchRequest<Item> {
        let request: NSFetchRequest<Item> = Item.fetchRequest()
        request.predicate = NSPredicate(format: "%K == %@", #keyPath(Item.category), category)
        request.sortDescriptors = [
            NSSortDescriptor(keyPath: \Item.title, ascending: false)
        ]
        return request
    }
    
    func touchedItemsRequest(for category: Category) -> NSFetchRequest<Item> {
        let request: NSFetchRequest<Item> = Item.fetchRequest()
        request.predicate = NSPredicate(format: "%K == %@", #keyPath(Item.category), category)
        request.sortDescriptors = [
            NSSortDescriptor(keyPath: \Item.dateModified, ascending: false)
        ]
        return request
    }
    
    @discardableResult
    func createItem(with title: String, with rating: Int16, with notes: String, with link: String, in list: Category) -> Item {
        let item = Item(context: context)
        item.title = title
        item.rating = rating
        item.dateAdded = Date()
        item.dateModified = Date()
        item.notes = notes
        item.link = link
        item.favorite = false
        list.addToItems(item)
        item.category!.dateModified = Date()
        try? context.save()
        return item
    }
    
    func toggle(_ item: Item) {
        item.favorite.toggle()
        try? context.save()
    }
    
    func update(_ item: Item, with title: String, with rating: Int16, with notes: String, with link: String, with dateAdded: Date) {
        item.title = title
        item.rating = rating
        item.notes = notes
        item.link = link
        item.dateModified = Date()
        item.dateAdded = dateAdded
        try? context.save()
    }
    
    func updateDate(_ item: Item, with dateAdded: Date) {
        item.dateModified = Date()
        item.dateAdded = dateAdded
        try? context.save()
    }
    
    func updateRating(_ item: Item, with rating: Double) {
        item.dateModified = Date()
        item.rating = Int16(rating)
        try? context.save()
    }
    
    func updateNotes(_ item: Item, with notes: String) {
        item.dateModified = Date()
        item.notes = notes
        try? context.save()
    }
    
    func updateTitle(_ item: Item, with title: String) {
        item.dateModified = Date()
        item.title = title
        try? context.save()
    }
    
    func updateLink(_ item: Item, with link: String) {
        item.dateModified = Date()
        item.link = link
        try? context.save()
    }
    
    func delete(_ items: [Item]) {
        context.perform {
            for item in items {
                self.context.delete(item)
            }
            try? self.context.save()
        }
    }

}
