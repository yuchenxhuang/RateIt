//
//  AllItemsView.swift
//  RateIt
//
//  Created by Yu-Chen Huang on 7/17/21.
//

import SwiftUI

struct AllItemsView: View {
    let items: FetchedResults<Item>

    var body: some View {
        VStack {
            List {
                ForEach(items) { item in
                    NavigationLink(destination: ItemDetailView(item: item)  ) {
                        AllItemCardView(item: item)
                    }
                }
            }
            .buttonStyle(BorderlessButtonStyle())
            .listStyle(InsetGroupedListStyle())
        }
    }
}

struct AllItemsSearchView: View {
    let items: FetchedResults<Item>
    @Binding var searchText: String

    var body: some View {
        VStack {
            List {
                ForEach(items) { item in
                    if searchText == "" || item.title!.lowercased().contains(searchText.lowercased()) {
                        NavigationLink(destination: ItemDetailView(item: item)  ) {
                            AllItemCardView(item: item)
                        }
                    }
                }
            }
            .buttonStyle(BorderlessButtonStyle())
        }
    }
}

struct AllItemCardView: View {
    @ObservedObject var item: Item

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
