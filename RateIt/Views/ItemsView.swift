//
//  TodoListView.swift
//  RateIt
//
//  Created by Yu-Chen Huang on 7/8/21.
//

import SwiftUI

struct ItemsView: View {
    let category: Category
    let items: FetchedResults<Item>
    let onSelect: (Item) -> Void
    let onDelete: ([Item]) -> Void
    
    @State var showAlertDelete = false

    var body: some View {
        List {
            ForEach(items) { item in
                NavigationLink(destination: ItemDetailView(item: item)) {
                    ItemCardView(item: item, category: category)
                }
            }
            .onDelete { indexSet in onDelete(items.get(indexSet)) }
        }
        .listStyle(InsetGroupedListStyle())

    }
}

struct ItemCardView: View {
    @ObservedObject var item: Item
    @ObservedObject var category: Category

    var body: some View {
        HStack{
            IconView(icon: "\(item.rating).circle.fill", color: item.category!.color!)
                .font(.title)
            Text(item.title ?? "")
                //.font(.headline)
                .padding(.top).padding(.bottom)
                .font(.custom("JosefinSans-Regular", size: 20, relativeTo: .headline))

            Spacer()
            if (item.favorite) {
                Image(systemName: "star.fill")
                    .foregroundColor(Color.yellow )
            }
        }
        .foregroundColor(.black)
    }
}

