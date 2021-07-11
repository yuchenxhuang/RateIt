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
    @State private var newColor = "black"

    var body: some View {
        ZStack {
            
            // CATEGORIES LIST
            VStack {
                List {
                    ForEach(allLists) { category in
                        NavigationLink(destination: CategoryDetailView(category: category)) {
                            HStack() {
                                IconView(icon: "star.circle.fill", color: category.color!)
                                    //.padding(.leading)
                                    .font(.title)
                                Text(" \(category.title!)")
                                    .padding(.top).padding(.bottom)
                                    //.padding(.top).padding(.bottom).padding(.trailing)
                                    .font(.headline)
                                    //.foregroundColor( Color.black )
                            }

                        }
                        //.listRowBackground( getColor(color: category.color ?? "white"))
                    }
                    .onDelete(perform: { indexSet in
                        PersistenceProvider.default.delete(allLists.get(indexSet))
                    })
                }
                
                // ADD CATEGORY VIEW
                .sheet(isPresented: $isPresented) {
                    NavigationView {
                        CategoryAddView(title: $newName, color: $newColor)
                            .navigationTitle("New Category")
                            .navigationBarItems(leading: Button("Cancel") {
                                isPresented = false
                                newName = ""
                                newColor = "black"
                            }, trailing: Button("Done") {
                                isPresented = false
                                if (newName != "") {PersistenceProvider.default.createCategory(with: newName, with: newColor)}
                                newName = ""
                                newColor = "black"
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
