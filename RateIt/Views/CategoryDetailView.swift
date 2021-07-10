//
//  TodoListDetailView.swift
//  RateIt
//
//  Created by Yu-Chen Huang on 7/8/21.
//

import SwiftUI

struct CategoryDetailView: View {
    var category: Category
    var items: FetchRequest<Item>
    
    @State private var isPresented = false
    @State private var isAdding = false
    @State private var catName = ""
    @State private var catColor = "white"
    @State private var itemName = ""
    @State private var itemRating = 1.0
    @State private var itemNotes = ""
    @State private var itemLink = ""

    init(category: Category) {
        self.category = category
        self.items = FetchRequest<Item>(fetchRequest: PersistenceProvider.default.itemsRequest(for: category))
    }
    
    var body: some View {
        ZStack {
            
            // ITEMS LIST
            VStack {
                ItemsView(
                    items: items.wrappedValue,
                    onSelect: { item in
                        //PersistenceProvider.default.update(item, with: "Edited")
                    },
                    onDelete: { items in
                        PersistenceProvider.default.delete(items)
                    }
                )
            }
            .navigationTitle(category.title ?? "")
            .navigationBarItems(trailing: HStack {
                Button("Edit") {
                    isPresented = true
                    catName = category.title ?? ""
                    catColor = category.color ?? "white"
                }
            })
            
            // EDIT VIEW
            .fullScreenCover(isPresented: $isPresented) {
                NavigationView {
                    CategoryEditView(category: category, title: $catName, color: $catColor)
                        .navigationTitle(category.title ?? "")
                        .navigationBarItems(leading: Button("Cancel") {
                            isPresented = false
                        }, trailing: Button("Done") {
                            isPresented = false
                            if (catName != "") { PersistenceProvider.default.update(category, with: catName, with: catColor) }
                        })
                }
            }
            
            // ADDING NEW ITEM
            .sheet(isPresented: $isAdding) {
                NavigationView {
                    AddItemView(itemText: $itemName, rating: $itemRating, notes: $itemNotes, link: $itemLink)
                        .navigationTitle(category.title ?? "")
                        .navigationBarItems(leading: Button("Cancel") {
                            isAdding = false
                            itemName = ""
                            itemRating = 1.0
                            itemNotes = ""
                        }, trailing: Button("Done") {
                            isAdding = false
                            if (itemName != "") {PersistenceProvider.default.createItem(with: itemName, with: Int16(itemRating), in: category)}
                            itemName = ""
                            itemRating = 1.0
                            itemNotes = ""
                            
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
                        Image(systemName: "plus.circle.fill")
                        .font(.system(size: 50))
                        .foregroundColor(Color.blue)
                    })
                    .padding(.trailing, 20)
                }
            }
        }
    }
}

struct CategoryEditView: View {
    @ObservedObject var category: Category
    @Binding var title: String
    @Binding var color: String

    var body: some View {
        List {
            Section(header: Text("Title")) {
                TextField(category.title ?? "Title", text: $title)
            }
            Section(header: Text("Color")) {
                ColorChoice(color: $color)
            }
        }
        .buttonStyle(BorderlessButtonStyle())
        .listStyle(InsetGroupedListStyle())
    }
}

struct AddItemView: View {
    @Binding var itemText: String
    @Binding var rating: Double
    @Binding var notes: String
    @Binding var link: String

    var body: some View {
        List {
            Section(header: Text("Title")) {
                TextField("Title", text: $itemText)
            }
            Section(header: Text("Rating")) {
                HStack {
                    Slider(value: $rating, in: 1...10, step: 1.0) {
                        Text("Rating")
                    }
                    Spacer()
                    Text("\(Int16(rating))")
                }
            }
            Section(header: Text("Notes")){
                TextEditor(text: $notes)
            }
            Section(header: Text("Link")){
                TextField("Link", text: $link)
            }
        }
        .listStyle(InsetGroupedListStyle())
    }
}
