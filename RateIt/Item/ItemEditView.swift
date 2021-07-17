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
                    TextEditor(text: $name)
                        .onChange(of: name) { value in
                            if value.contains("\n") {
                                name = value.replacingOccurrences(of: "\n", with: "")
                                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                            }
                        }
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
                        .onChange(of: link) { value in
                            if value.contains("\n") {
                                link = value.replacingOccurrences(of: "\n", with: "")
                                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                            }
                        }
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
            .navigationTitle(name == "" ? Text("New Item") : Text("\(name)"))
            .buttonStyle(BorderlessButtonStyle())
            .listStyle(InsetGroupedListStyle())
        }
    }
}
