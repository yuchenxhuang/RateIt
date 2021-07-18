//
//  TodoListsListView.swift
//  RateIt
//
//  Created by Yu-Chen Huang on 7/8/21.
//

import SwiftUI

struct HomeView: View {
    @FetchRequest(fetchRequest: PersistenceProvider.default.newestCategoriesRequest) var newestCategories: FetchedResults<Category>
    @FetchRequest(fetchRequest: PersistenceProvider.default.oldestCategoriesRequest) var oldestCategories: FetchedResults<Category>
    @FetchRequest(fetchRequest: PersistenceProvider.default.atozCategoriesRequest) var atozCategories: FetchedResults<Category>
    @FetchRequest(fetchRequest: PersistenceProvider.default.ztoaCategoriesRequest) var ztoaCategories: FetchedResults<Category>
    @FetchRequest(fetchRequest: PersistenceProvider.default.touchedCategoriesRequest) var touchedCategories: FetchedResults<Category>
    @FetchRequest(fetchRequest: PersistenceProvider.default.untouchedCategoriesRequest) var untouchedCategories: FetchedResults<Category>
    @FetchRequest(fetchRequest: PersistenceProvider.default.rainbowCategoriesRequest) var rainbowCategories: FetchedResults<Category>
    @FetchRequest(fetchRequest: PersistenceProvider.default.allItemsRequest(sortedBy: "newest")) var newestItems: FetchedResults<Item>

    @State private var isPresented = false
    @State private var name = ""
    @State private var color = "black"
    @State private var icon = "circle.fill"
    @State private var sortedBy = "newest"
    @State private var itemsSortedBy = "newest"
    @State private var isSearching = false
    @State private var searchText = ""

    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.font : UIFont(name: "JosefinSans-Bold", size: 34)!]
    }

    private func reset() {
        isPresented = false
        name = ""
        color = "black"
        icon = "circle.fill"
    }
    
    private func sortedCats(sortedCats: String) -> FetchedResults<Category> {
        if sortedBy == "newest" { return newestCategories }
        else if sortedBy == "oldest" { return oldestCategories }
        else if sortedBy == "atoz" { return atozCategories }
        else if sortedBy == "ztoa" { return ztoaCategories }
        else if sortedBy == "touched" { return touchedCategories }
        else if sortedBy == "untouched" { return untouchedCategories }
        else if sortedBy == "rainbow" { return rainbowCategories }
        else { return newestCategories }
    }
    
    var body: some View {
        ZStack {
            
            // CATEGORIES LIST
            
            VStack {
                List {
                    //SearchBar(text: $searchText)
                    NavigationLink(destination: AllItemsCategoryView()) {
                        HStack{
                            Text("All Ratings")
                                .padding(.top).padding(.bottom)
                                .font(.custom("JosefinSans-Regular", size: 20, relativeTo: .headline))
                            Spacer()
                            // @FetchRequest(fetchRequest: PersistenceProvider.default.allItemsRequest()) var allItems: FetchedResults<Item>
                            // Add total count here
                        }
                        .foregroundColor(.black)
                    }
                    ForEach( sortedCats(sortedCats: sortedBy)) { category in
                        NavigationLink(destination: CategoryDetailView(category: category)) {
                            CategoryCardView(category: category)
                        }
                    }
                }
                .listStyle(InsetGroupedListStyle())
                
                // ADD CATEGORY VIEW
                
                .sheet(isPresented: $isPresented) {
                    NavigationView {
                        CategoryAddView(title: $name, color: $color, icon: $icon, isPresented: $isPresented)
                            .navigationTitle("New Category")
                            .navigationBarItems(leading: Button("Cancel") {
                                reset()
                            }, trailing: Button("Done") {
                                if (name != "") {
                                    PersistenceProvider.default.createCategory(with: name, with: color, with: icon)
                                }
                                reset()
                            })
                    }
                }
                
                // SEARCH VIEW
                .fullScreenCover(isPresented: $isSearching) {
                    NavigationView{
                        VStack {
                            SearchBar(text: $searchText, isSearching: $isSearching)
                            Spacer()
                            AllItemsSearchView(items: newestItems, searchText: $searchText )
                        }
                        .navigationTitle("Search")
                    }
                }
            }
            .navigationTitle("Categories")
            .navigationBarItems(trailing: HStack {
                Button( action: {
                    isSearching = true
                }, label: {
                    Image(systemName: "magnifyingglass.circle")
                        .font(.title2)
                })
                Menu( content: {
                    SortingButton(name: "newest", Name: "Newest", sortedBy: $sortedBy)
                    SortingButton(name: "oldest", Name: "Oldest", sortedBy: $sortedBy)
                    SortingButton(name: "atoz", Name: "A → Z", sortedBy: $sortedBy)
                    SortingButton(name: "ztoa", Name: "Z → A", sortedBy: $sortedBy)
                    SortingButton(name: "rainbow", Name: "Rainbow", sortedBy: $sortedBy)
                    SortingButton(name: "touched", Name: "Last Edited", sortedBy: $sortedBy)
                }, label: {
                    Image(systemName: "arrow.up.arrow.down.circle")
                        .font(.title2)
                })
            })
            FloatingButton(isPresented: $isPresented)
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
                .padding(.top).padding(.bottom)
                .font(.custom("JosefinSans-Regular", size: 20, relativeTo: .headline))
            Spacer()
            Text( category.items != nil ? "\(category.items!.count)" : "0" )
        }
        .foregroundColor(.black)
    }
}
