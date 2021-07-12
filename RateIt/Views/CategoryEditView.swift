//
//  CategoryEditView.swift
//  RateIt
//
//  Created by Yu-Chen Huang on 7/10/21.
//

import SwiftUI

struct CategoryEditView: View {
    @ObservedObject var category: Category
    @Binding var title: String
    @Binding var color: String
    @Binding var icon: String

    var body: some View {
        List {
            Section(header: Text("Title")) {
                TextField("Title", text: $title)
            }
            Section(header: Text("Color")) {
                ColorChoice(color: $color)
            }
            Section(header: Text("Icon")) {
                IconChoice(icon: $icon, color: color)
            }
        }
        .buttonStyle(BorderlessButtonStyle())
        .listStyle(InsetGroupedListStyle())
    }
}

struct CategoryAddView: View {
    @Binding var title: String
    @Binding var color: String
    @Binding var icon: String

    var body: some View {
        List {
            Section(header: Text("Title")) {
                TextField("Title", text: $title)
            }
            Section(header: Text("Color")) {
                ColorChoice(color: $color)
            }
            Section(header: Text("Icon")) {
                IconChoice(icon: $icon, color: color)
            }
        }
        .buttonStyle(BorderlessButtonStyle())
        .listStyle(InsetGroupedListStyle())
    }
}
