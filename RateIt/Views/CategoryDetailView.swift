//
//  TodoListDetailView.swift
//  RateIt
//
//  Created by Yu-Chen Huang on 7/8/21.
//

import SwiftUI

struct CategoryDetailView: View {
    @ObservedObject var category: Category
    //var favoriteItems, bestItems, worstItems, newestItems, oldestItems, atozItems, ztoaItems, touchedItems: FetchRequest<Item>
    
    var favoriteItems: FetchRequest<Item>
    var bestItems: FetchRequest<Item>
    var worstItems: FetchRequest<Item>
    var newestItems: FetchRequest<Item>
    var oldestItems: FetchRequest<Item>
    var atozItems: FetchRequest<Item>
    var ztoaItems: FetchRequest<Item>
    var touchedItems: FetchRequest<Item>
    @State private var sortedBy = "oldest"
    
    @State private var isPresented = false
    @State private var isAdding = false
    @State private var catName = ""
    @State private var catColor = "black"
    @State private var catIcon = "circle.fill"
    
    @State private var itemName = ""
    @State private var itemRating = 1.0
    @State private var itemNotes = ""
    @State private var itemLink = ""
    @State private var itemDate = Date()

    init(category: Category) {
        self.category = category
        self.favoriteItems = FetchRequest<Item>(fetchRequest: PersistenceProvider.default.favoriteItemsRequest(for: category))
        self.newestItems = FetchRequest<Item>(fetchRequest: PersistenceProvider.default.newestItemsRequest(for: category))
        self.oldestItems = FetchRequest<Item>(fetchRequest: PersistenceProvider.default.oldestItemsRequest(for: category))
        self.bestItems = FetchRequest<Item>(fetchRequest: PersistenceProvider.default.bestItemsRequest(for: category))
        self.worstItems = FetchRequest<Item>(fetchRequest: PersistenceProvider.default.worstItemsRequest(for: category))
        self.atozItems = FetchRequest<Item>(fetchRequest: PersistenceProvider.default.atozItemsRequest(for: category))
        self.ztoaItems = FetchRequest<Item>(fetchRequest: PersistenceProvider.default.ztoaItemsRequest(for: category))
        self.touchedItems = FetchRequest<Item>(fetchRequest: PersistenceProvider.default.touchedItemsRequest(for: category))
    }
    
    private func reset() {
        isAdding = false
        itemName = ""
        itemRating = 1.0
        itemNotes = ""
        itemLink = ""
    }
    
    private func sortedCats(sortedCats: String) -> FetchRequest<Item> {
        if sortedBy == "favorite" { return favoriteItems }
        else if sortedBy == "newest" { return newestItems }
        else if sortedBy == "oldest" { return oldestItems }
        else if sortedBy == "best" { return bestItems }
        else if sortedBy == "worst" { return worstItems }
        else if sortedBy == "atoz" { return atozItems }
        else if sortedBy == "ztoa" { return ztoaItems }
        else if sortedBy == "touched" { return touchedItems }
        else { return newestItems }
    }
    
    var body: some View {
        ZStack {
            
            // ITEMS LIST
            
            VStack {
                ItemsView(
                    category: category,
                    items: sortedCats(sortedCats: sortedBy).wrappedValue,
                    onDelete: { items in
                        PersistenceProvider.default.delete(items)
                    }
                )
            }
            .buttonStyle(PlainButtonStyle())
            .navigationTitle(category.title ?? "")
            .navigationBarItems(trailing: HStack {
                Button("Edit") {
                    isPresented = true
                    catName = category.title ?? ""
                    catColor = category.color ?? "black"
                    catIcon = category.icon ?? "circle.fill"
                }
                Menu("Sort") {
                    Button("Favorite", action: {sortedBy = "favorite"})
                    Button("Newest", action: {sortedBy = "newest"})
                    Button("Oldest", action: {sortedBy = "oldest"})
                    Button("10 → 1", action: {sortedBy = "best"})
                    Button("1 → 10", action: {sortedBy = "worst"})
                    Button("A → Z", action: {sortedBy = "atoz"})
                    Button("Z → A", action: {sortedBy = "ztoa"})
                    Button("Last Edited", action: {sortedBy = "touched"})
                }
            })
            
            // EDIT VIEW
            .fullScreenCover(isPresented: $isPresented) {
                NavigationView {
                    CategoryEditView(category: category, title: $catName, color: $catColor, icon: $catIcon)
                        .navigationTitle(category.title ?? "")
                        .navigationBarItems(leading: Button("Cancel") {
                            isPresented = false
                        }, trailing: Button("Done") {
                            isPresented = false
                            if (catName != "") { PersistenceProvider.default.update(category, with: catName, with: catColor ?? "black", with: catIcon ?? "circle.fill") }
                        })
                }
            }
            
            // ADDING NEW ITEM
            .sheet(isPresented: $isAdding) {
                NavigationView {
                    ItemEditView(name: $itemName, rating: $itemRating, notes: $itemNotes, link: $itemLink, date: $itemDate, color: category.color!)
                        .navigationTitle(category.title ?? "")
                        .navigationBarItems(leading: Button("Cancel") {
                            reset()
                        }, trailing: Button("Done") {
                            if (itemName != "") {
                                PersistenceProvider.default.createItem(with: itemName, with: Int16(itemRating), with: itemNotes, with: itemLink,  in: category)
                            }
                            reset()
                        })
                }
            }
            
            // FLOATING BUTTON
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        isAdding = true
                    }, label: {
                        ZStack {
                            Image(systemName: "circle.fill")
                                .font(.system(size: 50))
                                .foregroundColor(Color.white)
                            Image(systemName: "plus.circle.fill")
                                .font(.system(size: 50))
                                .foregroundColor(Color.blue)
                        }
                    })
                    .padding(.trailing, 20)
                    //.padding(.bottom, 20)
                }
            }
        }
    }
}
