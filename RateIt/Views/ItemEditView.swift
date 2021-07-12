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
    @Binding var date: Date
    var color: String

    var body: some View {
        VStack {
            List {
                Section(header: Text("Title")) {
                    TextField("Title", text: $name)
                        .fixedSize(horizontal: false, vertical: true)
                }
                Section(header: Text("Rating")) {
                    NumberChoice(rating: $rating)
                        .foregroundColor(getColor(color:color))
                }
                Section(header: Text("Notes")){
                    TextEditor(text: $notes)

                }
                Section(header: Text("Link")){
                    TextEditor(text: $link)
                }
                Section(header: Text("Date")) {
                    DatePicker(
                        "Date",
                        selection: $date,
                        displayedComponents: [.date]
                    )
                    .labelsHidden()
                }
            }
            .buttonStyle(BorderlessButtonStyle())
            .listStyle(InsetGroupedListStyle())
        }
    }
}
