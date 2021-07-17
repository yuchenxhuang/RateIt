//
//  CategoryEditView.swift
//  RateIt
//
//  Created by Yu-Chen Huang on 7/10/21.
//

import SwiftUI

struct CategoryEditView: View {
    @ObservedObject var category: Category
    @Binding var presentationMode: PresentationMode
    @Binding var title: String
    @Binding var color: String
    @Binding var icon: String
    @Binding var isPresented: Bool
    @State var showAlert: Bool = false
    @State var delete: Bool = false

    var body: some View {
        VStack {
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
                HStack {
                    Spacer()
                    Button(action: {
                        showAlert = true
                    }, label: {
                        ZStack{
                            Image(systemName: "circle.fill")
                                .font(.largeTitle)
                                .foregroundColor(.white)
                            Image(systemName: "trash.circle.fill")
                                .font(.largeTitle)
                                .foregroundColor(.red)
                        }
                    })
                    Spacer()
                }
                .listRowBackground(Color(UIColor.systemGray6))

            }
            .navigationTitle(Text("\(title)"))
            .buttonStyle(BorderlessButtonStyle())
            .listStyle(InsetGroupedListStyle())
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Are you sure?"),
                      message: Text("Deleting this category will also delete all items in it."),
                      primaryButton: .default (Text("OK")) {
                        isPresented = false
                        self.presentationMode.dismiss()
                        PersistenceProvider.default.delete([category])
                      },
                      secondaryButton: .cancel()
                )
            }
        }
    }
}

struct CategoryAddView: View {
    @Binding var title: String
    @Binding var color: String
    @Binding var icon: String
    @Binding var isPresented: Bool

    var body: some View {
        VStack {
            List {
                Section(header: Text("Title")) {
                    TextField("Title", text: $title)
                }
                Section(header: Text("Color")) {
                    VStack(alignment: .center){
                        ColorChoice(color: $color)
                    }
                }
                Section(header: Text("Icon")) {
                    VStack(alignment: .center) {
                        IconChoice(icon: $icon, color: color)
                    }
                }
            }
            .navigationTitle(Text( title == "" ? "New Category" : "\(title)"))
            .buttonStyle(BorderlessButtonStyle())
            .listStyle(InsetGroupedListStyle())
        }
    }
}
