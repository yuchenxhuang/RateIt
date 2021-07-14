//
//  ItemDetailView.swift
//  RateIt
//
//  Created by Yu-Chen Huang on 7/8/21.
//

import SwiftUI

struct ItemDetailView: View {
    @Environment(\.scenePhase) private var scenePhase
    @ObservedObject var item: Item
    @State var date: Date
    @State var name: String
    @State var rating: Double
    @State var notes: String
    @State var link: String
    @State var isRating = false

    var body: some View {
        ScrollView() {
            VStack (alignment: .leading){
                
                // TITLE
                
                TextEditor(text: $name)
                    .multilineTextAlignment(. center)
                    .font(.custom("JosefinSans-Bold", size: 34, relativeTo: .title))
                    .fixedSize(horizontal: false, vertical: true)

                    .onChange(of: name) { value in
                        if value.contains("\n") {
                            name = value.replacingOccurrences(of: "\n", with: "")
                            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                            if name.trimmingCharacters(in: .whitespacesAndNewlines) != "" {
                                PersistenceProvider.default.updateTitle(item, with: name)
                            } else {
                                name = item.title!
                            }
                        }
                    }
                    /*
                    .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)) { _ in
                        if name != "" {
                            PersistenceProvider.default.updateTitle(item, with: name)
                        }
                     }
                    */
                
                // TOOLBAR
                
                HStack() {
                    VStack{
                        Button(action: {
                            isRating = !isRating
                        }, label: {
                            Image(systemName: "\(item.rating).circle.fill")
                                .font(.largeTitle)
                                .foregroundColor(getColor(color: item.category!.color!))
                        })
                        .onChange(of: rating, perform: { _ in
                            PersistenceProvider.default.updateRating(item, with: rating)
                        })
                    }
                    .frame(maxWidth: .infinity)
                    
                    VStack (alignment: .center){
                        //Text(item.dateAdded!, style: .date)
                        DatePicker(
                            "Date",
                            selection: $date,
                            displayedComponents: [.date]
                        )
                        .labelsHidden()
                        .accentColor(.black)
                        .id(date) // fixes short/medium format switching
                        .onChange(of: date, perform: { _ in
                            PersistenceProvider.default.updateDate(item, with: date)
                            //PersistenceProvider.default.toggle(item)
                        })
                    }
                    .frame(maxWidth: .infinity)
                    
                    VStack{
                        Image(systemName: item.favorite ? "star.fill" : "star")
                            .foregroundColor(item.favorite ? Color.yellow : Color.gray)
                            .onTapGesture { PersistenceProvider.default.toggle(item)}
                            .font(.title)
                    }
                    .frame(maxWidth: .infinity)
                }
                .padding(.leading).padding(.trailing)
                .padding(.bottom, 10)
                
                // RATING DROPDOWN
                
                if isRating {
                    VStack(spacing: 10){
                        Divider()
                        HStack(){
                            Spacer()
                            NumberChoice2(rating: $rating, isRating: $isRating)
                                .foregroundColor(getColor(color: item.category!.color!))
                            Spacer()
                        }
                    }
                }
                Divider()
                    .padding(.bottom, 10)

                // NOTES
                
                VStack(alignment: .leading) {
                    Text("Notes")
                        .font(.custom("JosefinSans-Bold", size: 22, relativeTo: .title2))

                    ZStack(alignment: .leading) {
                        if notes == "" {
                           Text("Add a note...")
                        }
                        TextEditor(text: $notes)
                            .fixedSize(horizontal: false, vertical: true)
                            .opacity( notes == "" ? 0.5 : 1.0)
                            .onChange(of: notes) { value in
                                if value.last == "\n" {
                                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                                    PersistenceProvider.default.updateNotes(item, with: notes)
                                }
                            }
                    }
                    Divider()
                }

                // LINK
                
                VStack(alignment: .leading) {
                    Text("Link")
                        .font(.custom("JosefinSans-Bold", size: 22, relativeTo: .title2))
                    
                    if ( item.link != nil && item.link != "" ) {
                        LinkPresentationView(link: item.link!)
                    }
                    
                    ZStack(alignment: .leading) {
                        if link == "" {
                           Text("Add a link...")
                        }
                        TextEditor(text: $link)
                            .fixedSize(horizontal: false, vertical: true)
                            .opacity( link == "" ? 0.5 : 1.0)
                            .onChange(of: link) { value in
                                if value.contains("\n") {
                                    link = value.replacingOccurrences(of: "\n", with: "")
                                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                                    PersistenceProvider.default.updateLink(item, with: link)
                                }
                            }
                    }
                    Divider()
                }
            }
            .padding()
            .navigationBarTitleDisplayMode(.inline)
        }
        .onDisappear(perform: {
            if name.trimmingCharacters(in: .whitespacesAndNewlines) != "" {
                PersistenceProvider.default.updateTitle(item, with: name)
            }
            PersistenceProvider.default.updateNotes(item, with: notes)
        })
        .onChange(of: scenePhase) { phase in
            if phase == .inactive {
                PersistenceProvider.default.update(item, with: name, with: Int16(rating), with: notes, with: link, with: date)
            }
        }
    }
}
