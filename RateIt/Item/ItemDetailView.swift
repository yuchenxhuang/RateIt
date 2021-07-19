//
//  ItemDetailView.swift
//  RateIt
//
//  Created by Yu-Chen Huang on 7/8/21.
//

import SwiftUI
import UIKit

struct ItemDetailView: View {
    @Environment(\.scenePhase) private var scenePhase
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @ObservedObject var item: Item

    @State var date: Date
    @State var name: String
    @State var rating: Double
    @State var notes: String
    @State var link: String
    
    @State var isRating = false
    @State var isEditing = false
    @State var showCamera: Bool = false
    @State var showLibrary: Bool = false
    @State var image: UIImage?
    @State var fullSize = false
    @State var fullPicture: UIImage?
    @State var pictureReference: Picture?
    @State var showAlert: Bool = false
    
    var pictures: FetchRequest<Picture>
    
    func onDelete(pictureSet : [Picture]) {
        PersistenceProvider.default.delete(pictureSet)
    }
    
    init(item: Item) {
        self.item = item
        _date = State(initialValue: item.dateAdded!)
        _name = State(initialValue: item.title!)
        _rating = State(initialValue: Double(item.rating))
        _notes = State(initialValue: item.notes!)
        _link = State(initialValue: item.link!)
        self.pictures = FetchRequest<Picture>(fetchRequest: PersistenceProvider.default.picturesRequest(for: item))
    }
    
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
                
                // RATING TOOLBAR
                
                RatingToolbar(item: item, date: $date, rating: $rating, isRating: $isRating)
                                
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
                
                // PHOTOS
                
                VStack(alignment: .leading) {
                    HStack(){
                        Text("Photos")
                            .font(.custom("JosefinSans-Bold", size: 22, relativeTo: .title2))
                        Spacer()
                        Menu( content: {
                                Button("Camera") {
                                    self.showCamera.toggle()
                                }
                                Button("Photo Library") {
                                    self.showLibrary.toggle()
                                }
                            }, label: {
                                Image(systemName: "plus.circle.fill")
                                    .foregroundColor(getColor(color: item.category != nil ? item.category!.color! :  "black"))
                                    .font(.title2)
                            }
                        )
                    }

                    //Text("\(pictures.wrappedValue.count)")
                    if pictures.wrappedValue.count > 0 {
                        ScrollView(.horizontal, showsIndicators: false){
                            HStack {
                                ForEach(pictures.wrappedValue, id: \.self) { picture in
                                    Image(uiImage: UIImage(data: picture.data! as Data) ?? UIImage())
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width:100, height: 100)
                                        .cornerRadius(10)
                                        .onTapGesture{
                                            self.pictureReference = picture
                                        }
                                  }
                                  .onDelete { indexSet in onDelete(pictureSet: pictures.wrappedValue.get(indexSet)) }
                            }
                        }
                        .padding(.bottom, 10)
                        .fullScreenCover(item: self.$pictureReference, content: { picture in
                            FullScreenPictureView(picture: picture)
                        })
                    }
                    Divider()
                }

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
        
        // END SCROLL VIEW
        
        .navigationBarItems(trailing: HStack {
            Button( action: {
                    isEditing = true
                }, label: {
                    Image(systemName: "ellipsis.circle")
                        .font(.title2)
                }
            )
//            Menu( content: {
//                Button(action: {
//                    self.presentationMode.wrappedValue.dismiss()
//                    PersistenceProvider.default.delete([item])
//                }, label: {
//                    Text("Delete")
//                        .accentColor(Color.red)
//                })
//            }, label:{
//                Image(systemName: "ellipsis.circle")
//                    .font(.title2)
//            })
        })
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
        .fullScreenCover(isPresented: $showCamera) {
            ImagePickerView(sourceType: .camera) { image in
                self.image = image
                let imageData = image.jpegData(compressionQuality: 1.0)
                PersistenceProvider.default.createPicture(with: imageData!, in: item)
            }
        }
        .fullScreenCover(isPresented: $showLibrary) {
            ImagePickerView(sourceType: .photoLibrary) { image in
                self.image = image
                let imageData = image.jpegData(compressionQuality: 1.0)
                PersistenceProvider.default.createPicture(with: imageData!, in: item)
            }
        }
        .sheet(isPresented: $isEditing) {
            NavigationView{
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
//                VStack{
//                    Button(action: {
//                        self.presentationMode.wrappedValue.dismiss()
//                        PersistenceProvider.default.delete([item])
//                    }, label: {
//                        Image(systemName: "trash.circle.fill")
//                            .foregroundColor(.red)
//                            .font(.largeTitle)
//                    })
//                    Spacer()
//                }
                .navigationBarItems(leading: Button("Cancel") {
                    isEditing = false
                }, trailing: Button("Done") {
                    isEditing = false
                })
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Delete item?"),
                          message: Text("You cannot undo this action."),
                          primaryButton: .default (Text("OK")) {
                            isEditing = false
                            self.presentationMode.wrappedValue.dismiss()
                            PersistenceProvider.default.delete([item])
                          },
                          secondaryButton: .cancel()
                    )
                }
            }
        }
    }
}
