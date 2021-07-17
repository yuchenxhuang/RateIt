//
//  PersistenceProvider+Picture.swift
//  RateIt
//
//  Created by Yu-Chen Huang on 7/16/21.
//

import Foundation
import CoreData

extension PersistenceProvider {
    
    func picturesRequest(for item: Item) -> NSFetchRequest<Picture> {
        let request: NSFetchRequest<Picture> = Picture.fetchRequest()
        request.predicate = NSPredicate(format: "%K == %@", #keyPath(Picture.item), item)
        request.sortDescriptors = [
            NSSortDescriptor(keyPath: \Picture.dateAdded, ascending: false),
        ]
        return request
    }
    
    func allPicturesRequest() -> NSFetchRequest<Picture> {
        let request: NSFetchRequest<Picture> = Picture.fetchRequest()
        request.sortDescriptors = [
            NSSortDescriptor(keyPath: \Picture.dateAdded, ascending: false),
        ]
        return request
    }
 
    @discardableResult
    func createPicture(with data: Data, in item: Item) -> Picture {
        let picture = Picture(context: context)
        picture.data = data
        picture.dateAdded = Date()
        item.addToPictures(picture)
        try? context.save()
        return picture
    }
    
    func delete(_ pictures: [Picture]) {
        context.perform {
            for picture in pictures {
                self.context.delete(picture)
            }
            try? self.context.save()
        }
    }
}
