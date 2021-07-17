//
//  TodoListDetailView.swift
//  RateIt
//
//  Created by Yu-Chen Huang on 7/8/21.
//

import SwiftUI

struct CategoryDetailView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
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

    @State private var sortedBy = "newest"
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
    
    @State var isSearching: Bool = false
    @State var searchText: String = ""

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
                    items: sortedCats(sortedCats: sortedBy).wrappedValue
                    /*
                    ,onDelete: { items in
                        PersistenceProvider.default.delete(items)
                    }*/
                )
            }
            .buttonStyle(PlainButtonStyle())
            .navigationTitle(category.title ?? "")
            .navigationBarItems(trailing: HStack {
                Button( action: {
                    isPresented = true
                    catName = category.title ?? ""
                    catColor = category.color ?? "black"
                    catIcon = category.icon ?? "circle.fill"
                }, label:{
                    Image(systemName: "ellipsis.circle")
                        .font(.title2)
                })
                Button( action: {
                    isSearching = true
                }, label: {
                    Image(systemName: "magnifyingglass.circle")
                        .font(.title2)
                })
                Menu(content: {
                    SortingButton(name: "favorite", Name: "Favorite", sortedBy: $sortedBy)
                    SortingButton(name: "newest", Name: "Newest", sortedBy: $sortedBy)
                    SortingButton(name: "oldest", Name: "Oldest", sortedBy: $sortedBy)
                    SortingButton(name: "best", Name: "10 → 1", sortedBy: $sortedBy)
                    SortingButton(name: "worst", Name: "1 → 10", sortedBy: $sortedBy)
                    SortingButton(name: "atoz", Name: "A → Z", sortedBy: $sortedBy)
                    SortingButton(name: "ztoa", Name: "Z → A", sortedBy: $sortedBy)
                    SortingButton(name: "touched", Name: "Last Edited", sortedBy: $sortedBy)
                }, label: {
                    Image(systemName: "arrow.up.arrow.down.circle")
                        .font(.title2)
                })
                
            })
            
            // EDIT VIEW
            
            .sheet(isPresented: $isPresented) {
                NavigationView {
                    CategoryEditView(category: category, presentationMode: presentationMode, title: $catName, color: $catColor, icon: $catIcon, isPresented: $isPresented)
                        .navigationTitle(category.title ?? "")
                        .navigationBarItems(leading: Button("Cancel") {
                            isPresented = false
                        }, trailing: Button("Done") {
                            isPresented = false
                            if (catName != "") {
                                PersistenceProvider.default.update(category, with: catName, with: catColor, with: catIcon)
                            }
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
            
            // SEARCH
            
            .fullScreenCover(isPresented: $isSearching) {
                NavigationView{
                    VStack {
                        SearchBar(text: $searchText, isSearching: $isSearching)
                        Spacer()
                        AllItemsSearchView(items: newestItems.wrappedValue, searchText: $searchText )
                    }
                    .navigationTitle("Search")
                }
            }
            FloatingButton(isPresented: $isAdding)
        }
    }
}

struct AllItemsCategoryView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @FetchRequest(fetchRequest: PersistenceProvider.default.allItemsRequest()) var allItems: FetchedResults<Item>
    @State var isSearching: Bool = false
    @State var searchText: String = ""
    
    var body: some View {
        VStack {
            AllItemsView(
                items: allItems
            )
        }
        .buttonStyle(PlainButtonStyle())
        .navigationTitle("All Ratings")
        .navigationBarItems(trailing: HStack {
            Button( action: {
                isSearching = true
            }, label: {
                Image(systemName: "magnifyingglass.circle")
                    .font(.title2)
            })
        })
        .fullScreenCover(isPresented: $isSearching) {
            NavigationView{
                VStack {
                    SearchBar(text: $searchText, isSearching: $isSearching)
                    Spacer()
                    AllItemsSearchView(items: allItems, searchText: $searchText )
                }
                .navigationTitle("Search")
            }
        }
    }
}
