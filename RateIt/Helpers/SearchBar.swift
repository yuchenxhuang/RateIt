//
//  SearchBar.swift
//  RateIt
//
//  Created by Yu-Chen Huang on 7/17/21.
//

import SwiftUI
 
struct SearchBar: View {
    @Binding var text: String
    @Binding var isSearching: Bool
    @State private var isEditing = false
 
    var body: some View {
        HStack {
            TextField("Search...", text: $text)
                .padding(10)
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .onTapGesture {
                    self.isEditing = true
                }
 
            Button(action: {
                isSearching = false
                self.text = ""

            }) {
                Image(systemName: "xmark.circle")
                    .font(.title2)
            }
        }
        .padding(.leading, 15).padding(.trailing, 10)
    }
}
