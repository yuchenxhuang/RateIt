//
//  PicturesView.swift
//  RateIt
//
//  Created by Yu-Chen Huang on 7/16/21.
//

import SwiftUI

struct PicturesView: View {
    @ObservedObject var item: Item
    let pictures: FetchedResults<Picture>
    let onDelete: ([Picture]) -> Void
    
    @State var fullSize = false
    @State var fullPicture : Picture?

    var body: some View {
        ForEach(pictures) { picture in
            Button( action: {
                fullSize = true
                fullPicture = picture
            }) {
                Image(uiImage: UIImage(data: picture.data! as Data) ?? UIImage())
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }

        }
        .onDelete { indexSet in onDelete(pictures.get(indexSet)) }
        .fullScreenCover(isPresented: $fullSize, content: {
            if fullPicture != nil {
                Image(uiImage: UIImage(data: fullPicture!.data! as Data) ?? UIImage())
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .onTapGesture(perform: {
                        fullSize = false
                    })
            }
        })
    }
}


