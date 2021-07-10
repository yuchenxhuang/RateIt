//
//  ItemEditView.swift
//  RateIt
//
//  Created by Yu-Chen Huang on 7/10/21.
//

import SwiftUI

struct ItemEditView: View {
    @Binding var name: String
    @Binding var rating: Double
    @Binding var notes: String
    @Binding var link: String

    var body: some View {
        VStack {
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
                Section(header: Text("Link")){
                    TextEditor(text: $link)
                }
            }
            .listStyle(InsetGroupedListStyle())
        }
    }
}
