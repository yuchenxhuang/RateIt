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
    @State private var showAlert = false
    @State private var delete = false

    var body: some View {
        VStack{
            HStack {
                Spacer()
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    Image(systemName: "xmark.circle.fill")
                        .font(.largeTitle)
                        .foregroundColor(.gray)
                })
            }
            .padding(.trailing).padding(.top)

            ZoomableScrollView {
                Image(uiImage: UIImage(data: picture.data! as Data) ?? UIImage())
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .contextMenu {
                        Button("Save Image", action: {
                            UIImageWriteToSavedPhotosAlbum(UIImage(data: picture.data! as Data) ?? UIImage(), nil, nil, nil)
                        })
                    }
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
            Button(action: {
                showAlert = true
                //presentationMode.wrappedValue.dismiss()
                //PersistenceProvider.default.delete([picture])
            }, label: {
                Image(systemName: "trash.circle.fill")
                    .font(.largeTitle)
                    .foregroundColor(.red)
            })
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Delete photo?"),
                      message: Text("You cannot undo this action."),
                      primaryButton: .default (Text("OK")) {
                        showAlert = false
                        presentationMode.wrappedValue.dismiss()
                        PersistenceProvider.default.delete([picture])
                      },
                      secondaryButton: .cancel()
                )
            }
    }
}
