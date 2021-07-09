//
//  TodoListView.swift
//  RateIt
//
//  Created by Yu-Chen Huang on 7/8/21.
//

import SwiftUI

struct ItemsView: View {
    let items: FetchedResults<Item>
    let onSelect: (Item) -> Void
    let onDelete: ([Item]) -> Void
    
    @State var showAlertDelete = false
    
    var body: some View {
        List {
            ForEach(items) { item in
                NavigationLink(destination: ItemDetailView(item: item)) {
                    ItemCardView(item: item)
                }
            }
            .onDelete { indexSet in onDelete(items.get(indexSet)) }
        }
        .listStyle(InsetGroupedListStyle())

    }
}

struct ItemCardView: View {
    @ObservedObject var item: Item
    
    var body: some View {
        HStack{
            Text("\(item.rating)  ")
                .font(.title)
                .foregroundColor(.blue)
            Text(item.title ?? "")
                .font(.headline)
            Spacer()
            if (item.favorite) {
                Image(systemName: "star.fill")
                    .foregroundColor(Color.yellow )
            }
        }
        .padding()
        .foregroundColor(.black)
    }
}
