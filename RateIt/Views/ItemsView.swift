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
    //let onSelect: (Item) -> Void
    let onDelete: ([Item]) -> Void
    
    //@Binding var listViewId: UUID
    @State private var listViewId = UUID()
    
    private func refresh() {
        listViewId = UUID()
    }

    var body: some View {
        VStack {
            List {
                ForEach(items) { item in
                    NavigationLink(destination: ItemDetailView(item: item, date: item.dateAdded!, name: item.title!, rating: Double(item.rating), notes: item.notes!, link: item.link!)  ) {

                    //NavigationLink(destination: ItemDetailView(item: item, date: item.dateAdded!) /*.onAppear {refresh()}*/ ) {
                        ItemCardView(item: item, category: category)
                    }
                }
                .onDelete { indexSet in onDelete(items.get(indexSet)) }
            }
            .buttonStyle(BorderlessButtonStyle())
            .listStyle(InsetGroupedListStyle())
            //.id(listViewId)
        }
    }
}

struct ItemCardView: View {
    @ObservedObject var item: Item
    @ObservedObject var category: Category

    var body: some View {
        HStack{
            IconView(icon: "\(item.rating).circle.fill", color: item.category != nil ? item.category!.color! : "black")
                .font(.title)
            Text(item.title ?? "")
                .padding(.top).padding(.bottom)
                .font(.custom("JosefinSans-Regular", size: 20, relativeTo: .headline))

            Spacer()
            if (item.favorite) {
                Image(systemName: "star.fill")
                    .foregroundColor(Color.yellow )
            }
        }
        .buttonStyle(PlainButtonStyle())
        .foregroundColor(.black)
    }
}

