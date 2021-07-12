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
    @State private var icon = "circle.fill"

    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.font : UIFont(name: "JosefinSans-Bold", size: 34)!]
    }

    var body: some View {
        ZStack {
            
            // CATEGORIES LIST
            VStack {
                List {
                    ForEach(allLists) { category in
                        NavigationLink(destination: CategoryDetailView(category: category)) {
                            CategoryCardView(category: category)
                        }
                    }
                    .onDelete(perform: { indexSet in
                        PersistenceProvider.default.delete(allLists.get(indexSet))
                    })
                }
                .listStyle(InsetGroupedListStyle())
                
                // ADD CATEGORY VIEW
                .sheet(isPresented: $isPresented) {
                    NavigationView {
                        CategoryAddView(title: $newName, color: $newColor, icon: $icon)
                            .navigationTitle("New Category")
                            .navigationBarItems(leading: Button("Cancel") {
                                isPresented = false
                                newName = ""
                                newColor = "black"
                                icon = "circle.fill"
                            }, trailing: Button("Done") {
                                isPresented = false
                                if (newName != "") {PersistenceProvider.default.createCategory(with: newName, with: newColor, with: icon)}
                                newName = ""
                                newColor = "black"
                                icon = "circle.fill"
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

struct CategoryCardView: View {
    @ObservedObject var category: Category

    var body: some View {
        HStack{
            IconView(icon: category.icon ?? "circle.fill", color: category.color ?? "black")
                .font(.title)
            Text(category.title ?? "")
                //.font(.headline)
                .padding(.top).padding(.bottom)
                .font(.custom("JosefinSans-Regular", size: 20, relativeTo: .headline))
        }
        .foregroundColor(.black)
    }
}
