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

    var body: some View {
        ScrollView() {
            VStack (alignment: .leading, spacing: 10){
                HStack() {
                    Text(item.title!)
                        .font(.largeTitle).bold()
                        //.padding()
                }
                HStack() {
                    Text("\(item.rating) / 10")
                        .font(.title)//.bold()
                        .foregroundColor(Color.blue)
                    Spacer()
                    Text(item.creationDate!, style: .date)
                    Spacer()
                    Image(systemName: item.favorite ? "star.fill" : "star")
                        .foregroundColor(item.favorite ? Color.yellow : Color.gray)
                        .onTapGesture { PersistenceProvider.default.toggle(item)}
                        .font(.title)
                }
                Divider()
                Text("Notes")
                    .bold().font(.title2)
                Text( (item.notes != nil && item.notes != "") ? item.notes! : "No notes yet" )
                
                if ( item.link != nil && item.link != "" ) {
                    Divider()
                    Text("Link")
                        .bold().font(.title2)
                    //Text( (item.link != nil && item.link != "") ? item.link! : "No link yet" )
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
                    ItemEditView(name: $newName, rating: $rating, notes: $notes, link: $link)
                        .navigationTitle(item.title ?? "")
                        .navigationBarItems(leading: Button("Cancel") {
                            isPresented = false
                        }, trailing: Button("Done") {
                            isPresented = false
                            if (newName != "") {
                                PersistenceProvider.default.update(item, with: newName, with: Int16(rating), with: notes, with: link)
                            }
                        })
                }
            }
        }
    }
}
