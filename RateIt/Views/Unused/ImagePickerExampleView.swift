//
//  ImagePickerView.swift
//  RateIt
//
//  Created by Yu-Chen Huang on 7/15/21.
//

//
//  ItemDetailView.swift
//  RateIt
//
//  Created by Yu-Chen Huang on 7/8/21.
//

import SwiftUI
import UIKit

struct ImagePickerExampleView: View {

    @State var camera: Bool = false
    @State var showImagePicker: Bool = false
    @State var image: UIImage?

    var body: some View {
        VStack {
            if image != nil {
                Image(uiImage: image!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            Toggle("Camera?", isOn: $camera)
            if camera {
                Text("Yes!")
            }
            Button("Pick image") {
                self.showImagePicker.toggle()
            }
        }
        .fullScreenCover(isPresented: $showImagePicker) {
            ImagePickerView(sourceType: camera ? .camera : .photoLibrary) { image in
                self.image = image

            }
        }
    }
}
