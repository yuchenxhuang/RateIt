//
//  PicturesView.swift
//  RateIt
//
//  Created by Yu-Chen Huang on 7/16/21.
//

import SwiftUI

struct FullScreenPictureView: View {
    @Environment(\.presentationMode) var presentationMode
    let picture: Picture
    
    var body: some View {
        VStack{
            Button("Exit View", action: {
                presentationMode.wrappedValue.dismiss()
            })
            ZoomableScrollView {
                Image(uiImage: UIImage(data: picture.data! as Data) ?? UIImage())
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .onTapGesture(perform: {
                        presentationMode.wrappedValue.dismiss()
                    })
                    .gesture(DragGesture(minimumDistance: 10, coordinateSpace: .local)
                        .onEnded({ value in
                            if value.translation.height > 10 {
                                presentationMode.wrappedValue.dismiss()
                            }
                        })
                    )
                }
            }
            Button("Delete Image", action: {
                presentationMode.wrappedValue.dismiss()
                PersistenceProvider.default.delete([picture])
            })
    }
}
