//
//  IconChoice.swift
//  RateIt
//
//  Created by Yu-Chen Huang on 7/10/21.
//

import SwiftUI

struct IconChoice: View {
    @Binding var icon: String
    var color: String
    
    let icons1 = ["circle.fill", "star.circle.fill", "heart.circle.fill", "face.smiling.fill", "exclamationmark.circle.fill", "questionmark.circle.fill", "number.circle.fill","at.circle.fill", "dollarsign.circle.fill", "staroflife.circle.fill"]
    let icons2 = ["folder.circle.fill", "book.circle.fill", "bookmark.circle.fill", "person.circle.fill", "pin.circle.fill", "cart.circle.fill", "airplane.circle.fill", "tv.circle.fill", "house.circle.fill", "bolt.circle.fill"]

    var body: some View {
        VStack {
            HStack{
                ForEach(icons1, id: \.self) { choice in
                    Button(action: {
                        icon = choice
                    }, label: {
                        Image(systemName: choice)
                            .foregroundColor(getColor(color: color))
                            .font( icon == choice ? .title : .title3 )
                    })
                }
            }
            .padding(.bottom, 2)
            HStack{
                ForEach(icons2, id: \.self) { choice in
                    Button(action: {
                        icon = choice
                    }, label: {
                        Image(systemName: choice)
                            .foregroundColor(getColor(color: color))
                            .font( icon == choice ? .title : .title3 )
                    })
                }
            }
        }
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

struct IconChoice_Previews: PreviewProvider {
    static var previews: some View {
        IconChoice(icon: .constant("circle.fill"), color: "black")
    }
}
