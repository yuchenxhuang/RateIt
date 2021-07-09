//
//  TodoListsListView.swift
//  RateIt
//
//  Created by Yu-Chen Huang on 7/8/21.
//

import SwiftUI

struct HomeView: View {
    @FetchRequest(fetchRequest: PersistenceProvider.default.allCategoriesRequest) var allLists: FetchedResults<Category>
    @State private var isPresented = false
    @State private var newName = ""
    @State private var newColor = "white"

    var body: some View {
        ZStack {
            
            // CATEGORIES LIST
            VStack {
                List {
                    ForEach(allLists) { category in
                        NavigationLink(destination: CategoryDetailView(category: category)) {
                            Text(category.title ?? "")
                                .padding()
                                .font(.headline)
                                .foregroundColor( getTextColor(color: category.color ?? "white") )
                        }
                        .listRowBackground( getColor(color: category.color ?? "white"))
                        //.listRowBackground( Color.blue )
                    }
                    .onDelete(perform: { indexSet in
                        PersistenceProvider.default.delete(allLists.get(indexSet))
                    })
                }
                
                // ADD CATEGORY VIEW
                .sheet(isPresented: $isPresented) {
                    NavigationView {
                        AddCategoryView(newName: $newName, newColor: $newColor)
                            .navigationTitle("New Category")
                            .navigationBarItems(leading: Button("Cancel") {
                                isPresented = false
                                newName = ""
                                newColor = "white"
                            }, trailing: Button("Done") {
                                isPresented = false
                                if (newName != "") {PersistenceProvider.default.createCategory(with: newName, with: newColor)}
                                newName = ""
                                newColor = "white"
                            })
                    }
                }
            }
            .navigationTitle("Categories")
            
            // FLOATING BUTTON
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        isPresented = true
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

struct AddCategoryView: View {
    @Binding var newName: String
    @Binding var newColor: String

    var body: some View {
        List {
            Section(header: Text("Title")) {
                TextField("Title", text: $newName)
            }
            Section(header: Text("Color")) {
                ColorChoice(color: $newColor)
            }
        }
        .listStyle(InsetGroupedListStyle())
        .buttonStyle(BorderlessButtonStyle())
    }
}
