//
//  TodoListDetailView.swift
//  RateIt
//
//  Created by Yu-Chen Huang on 7/8/21.
//

import SwiftUI

struct CategoryDetailView: View {
    @ObservedObject var category: Category
    var items: FetchRequest<Item>
    
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
        self.items = FetchRequest<Item>(fetchRequest: PersistenceProvider.default.itemsRequest(for: category))
    }
    
    var body: some View {
        ZStack {
            
            // ITEMS LIST
            
            VStack {
                ItemsView(
                    category: category,
                    items: items.wrappedValue,
                    //onSelect: { item in
                        //PersistenceProvider.default.update(item, with: "Edited")
                    //},
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
                            isAdding = false
                            itemName = ""
                            itemRating = 1.0
                            itemNotes = ""
                            itemLink = ""
                        }, trailing: Button("Done") {
                            isAdding = false
                            if (itemName != "") {PersistenceProvider.default.createItem(with: itemName, with: Int16(itemRating), with: itemNotes, with: itemLink,  in: category)}
                            itemName = ""
                            itemRating = 1.0
                            itemNotes = ""
                            itemLink = ""
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
                }
            }
        }
    }
}
