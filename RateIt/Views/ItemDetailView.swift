//
//  ItemDetailView.swift
//  RateIt
//
//  Created by Yu-Chen Huang on 7/8/21.
//

import SwiftUI

struct ItemDetailView: View {
    @ObservedObject var item: Item
    @State private var isPresented = false
    @State private var newName = ""
    @State private var rating = 1.0
    @State private var notes = ""
    @State private var link = ""
    @State private var date = Date()

    var body: some View {
        ScrollView() {
            VStack (alignment: .leading){
                HStack() {
                    Spacer()
                    Text(item.title!)
                        .multilineTextAlignment(. center)
                        .font(.custom("JosefinSans-Bold", size: 34, relativeTo: .title))
                        .fixedSize(horizontal: false, vertical: true)
                    Spacer()
                }
                HStack() {
                    Spacer()
                    IconView(icon: "\(item.rating).circle.fill", color: item.category!.color!)
                        .font(.largeTitle)
                        .foregroundColor(getColor(color: item.category!.color!))
                    Spacer()
                    Text(item.dateAdded!, style: .date)
                    Spacer()
                    Image(systemName: item.favorite ? "star.fill" : "star")
                        .foregroundColor(item.favorite ? Color.yellow : Color.gray)
                        .onTapGesture { PersistenceProvider.default.toggle(item)}
                        .font(.title)
                    Spacer()
                }
                .padding(.leading).padding(.trailing)
                
                Divider()

                Text("Notes")
                    .font(.custom("JosefinSans-Bold", size: 22, relativeTo: .title2))

                Text( (item.notes != nil && item.notes != "") ? item.notes! : "None" )
                    .fixedSize(horizontal: false, vertical: true)

                if ( item.link != nil && item.link != "" ) {
                    Divider()
                    Text("Link")
                        .font(.custom("JosefinSans-Bold", size: 22, relativeTo: .title2))
                    LinkPresentationView(link: item.link!)
                }
            }
            .padding()
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing: HStack {
                Button("Edit") {
                    isPresented = true
                    newName = item.title ?? ""
                    rating = Double(item.rating)
                    notes = item.notes ?? ""
                    link = item.link ?? ""
                }
            })
            .fullScreenCover(isPresented: $isPresented) {
                NavigationView {
                    ItemEditView(name: $newName, rating: $rating, notes: $notes, link: $link, date: $date, color: item.category!.color!)
                        .navigationTitle(item.title ?? "")
                        .navigationBarItems(leading: Button("Cancel") {
                            isPresented = false
                        }, trailing: Button("Done") {
                            isPresented = false
                            if (newName != "") {
                                PersistenceProvider.default.update(item, with: newName, with: Int16(rating), with: notes, with: link, with: date)
                            }
                        })
                }
            }
        }
    }
}
