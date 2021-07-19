//
//  TodoListsListView.swift
//  RateIt
//
//  Created by Yu-Chen Huang on 7/8/21.
//

import SwiftUI

struct HomeView: View {
    @FetchRequest(fetchRequest: PersistenceProvider.default.allCategoriesRequest(sortedBy: "newest")) var newestCategories: FetchedResults<Category>
    @FetchRequest(fetchRequest: PersistenceProvider.default.allCategoriesRequest(sortedBy: "oldest")) var oldestCategories: FetchedResults<Category>
    @FetchRequest(fetchRequest: PersistenceProvider.default.allCategoriesRequest(sortedBy: "atoz")) var atozCategories: FetchedResults<Category>
    @FetchRequest(fetchRequest: PersistenceProvider.default.allCategoriesRequest(sortedBy: "ztoa")) var ztoaCategories: FetchedResults<Category>
    @FetchRequest(fetchRequest: PersistenceProvider.default.allCategoriesRequest(sortedBy: "touched")) var touchedCategories: FetchedResults<Category>
    @FetchRequest(fetchRequest: PersistenceProvider.default.allCategoriesRequest(sortedBy: "rainbow")) var rainbowCategories: FetchedResults<Category>
    @FetchRequest(fetchRequest: PersistenceProvider.default.allItemsRequest(sortedBy: "newest")) var newestItems: FetchedResults<Item>

    @State private var isPresented = false
    @State private var name = ""
    @State private var color = "black"
    @State private var icon = "circle.fill"
    //@State private var sortedBy = "newest"
    @State private var itemsSortedBy = "newest"
    @State private var isSearching = false
    @State private var searchText = ""
    @State private var showAlert = false
    
    static let catSortKey = "category_sort"
    @AppStorage(Self.catSortKey) var catSort: String = "newest"

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
        if catSort == "newest" { return newestCategories }
        else if catSort == "oldest" { return oldestCategories }
        else if catSort == "atoz" { return atozCategories }
        else if catSort == "ztoa" { return ztoaCategories }
        else if catSort == "touched" { return touchedCategories }
        else if catSort == "rainbow" { return rainbowCategories }
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
                    ForEach( sortedCats(sortedCats: catSort)) { category in
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
                                if name.trimmingCharacters(in: .whitespacesAndNewlines) != "" {
                                //if (name != "") {
                                    PersistenceProvider.default.createCategory(with: name, with: color, with: icon)
                                    reset()
                                } else {
                                    showAlert = true
                                }
                            })
                            .alert(isPresented: $showAlert) {
                                Alert(title: Text("Please enter a title")
                                )
                            }
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
                    CatSortButton(name: "newest", Name: "Newest")
                    CatSortButton(name: "oldest", Name: "Oldest")
                    CatSortButton(name: "atoz", Name: "A → Z")
                    CatSortButton(name: "ztoa", Name: "Z → A")
                    CatSortButton(name: "rainbow", Name: "Rainbow")
                    CatSortButton(name: "touched", Name: "Last Updated")
//                    SortingButton(name: "newest", Name: "Newest", sortedBy: $catSort)
//                    SortingButton(name: "oldest", Name: "Oldest", sortedBy: $catSort)
//                    SortingButton(name: "atoz", Name: "A → Z", sortedBy: $catSort)
//                    SortingButton(name: "ztoa", Name: "Z → A", sortedBy: $catSort)
//                    SortingButton(name: "rainbow", Name: "Rainbow", sortedBy: $catSort)
//                    SortingButton(name: "touched", Name: "Last Edited", sortedBy: $catSort)
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
