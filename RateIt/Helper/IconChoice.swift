//
//  IconChoice.swift
//  RateIt
//
//  Created by Yu-Chen Huang on 7/10/21.
//

import SwiftUI

struct IconChoice: View {
    @Binding var icon: String
    
    var body: some View {
        HStack{
            Button(action: {
                icon = "white"
            }, label: {
                Image(systemName: "circle")
                    .font( icon == "white" ? .title : .title3 )
            })
            Button(action: {
                icon = "red"
            }, label: {
                Image(systemName: "circle.fill")
                    .font( icon == "red" ? .title : .title3 )

            })
            Button(action: {
                icon = "orange"
            }, label: {
                Image(systemName: "circle.fill")
                    .font( icon == "orange" ? .title : .title3 )

            })
            Button(action: {
                icon = "yellow"
            }, label: {
                Image(systemName: "circle.fill")
                    .font( icon == "yellow" ? .title : .title3 )

            })
            Button(action: {
                icon = "green"
            }, label: {
                Image(systemName: "circle.fill")
                    .font( icon == "green" ? .title : .title3 )

            })
            Button(action: {
                icon = "blue"
            }, label: {
                Image(systemName: "circle.fill")
                    .font( icon == "blue" ? .title : .title3 )

            })
            Button(action: {
                icon = "purple"
            }, label: {
                Image(systemName: "circle.fill")
                    .font( icon == "purple" ? .title : .title3 )

            })
            Button(action: {
                icon = "black"
            }, label: {
                Image(systemName: "circle.fill")
                    .font( icon == "black" ? .title : .title3 )
            })
        }
    }
}

struct IconChoice_Previews: PreviewProvider {
    static var previews: some View {
        Text("hello")
        //IconChoice(icon: "folder")
    }
}

struct IconView: View {
    var icon: String
    var color: String

    var body: some View {
        Image(systemName: icon)
            .foregroundColor(getColor(color:color) )
    }
}

