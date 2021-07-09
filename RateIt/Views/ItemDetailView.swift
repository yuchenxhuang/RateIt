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

    var body: some View {
        VStack() {
            HStack() {
                Text(item.title!)
                    .font(.title).bold()
                    .padding()
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
            .padding(.leading).padding(.leading)
            .padding(.trailing).padding(.trailing)

            List {
                Section(header: Text("Notes").bold()){
                    Text( (item.notes != nil && item.notes != "") ? item.notes! : "No notes yet" )
                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing: HStack {
                Button("Edit") {
                    isPresented = true
                    newName = item.title ?? ""
                    rating = Double(item.rating)
                    notes = item.notes ?? ""
                }
            })
            .fullScreenCover(isPresented: $isPresented) {
                NavigationView {
                    ItemEditView(item: item, name: $newName, rating: $rating, notes: $notes)
                        .navigationTitle(item.title ?? "")
                        .navigationBarItems(leading: Button("Cancel") {
                            isPresented = false
                        }, trailing: Button("Done") {
                            isPresented = false
                            if (newName != "") { PersistenceProvider.default.update(item, with: newName, with: Int16(rating), with: notes) }
                        })
                }
            }
        }
    }
}

struct ItemEditView: View {
    @ObservedObject var item: Item
    @Binding var name: String
    @Binding var rating: Double
    @Binding var notes: String

    var body: some View {
        List {
            Section(header: Text("Title")) {
                TextField("Title", text: $name)
            }
            Section(header: Text("Rating")) {
                HStack {
                    Slider(value: $rating, in: 1...10, step: 1.0) {
                        Text("Rating")
                    }
                    Spacer()
                    Text("\(Int16(rating))")
                }
            }
            Section(header: Text("Notes")){
                TextEditor(text: $notes)
            }
        }
        .listStyle(InsetGroupedListStyle())
    }
}

struct BlankView: View {
    var body: some View {
        Text("")
            .font(.system(size: 1))
    }
}
