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

/*
struct IconChoice_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            HStack{
                Image(systemName: "folder.circle.fill")
                Image(systemName: "book.circle.fill")
                Image(systemName: "bookmark.circle.fill")
                Image(systemName: "paperclip.circle.fill")
                Image(systemName: "person.circle.fill")
                Image(systemName: "person.2.circle.fill")
                Image(systemName: "sun.max.circle.fill")
                Image(systemName: "moon.circle.fill")
                Image(systemName: "play.circle.fill")
                Image(systemName: "music.mic.circle.fill")
            }
            HStack{
                Image(systemName: "speaker.wave.2.circle.fill")
                Image(systemName: "magnifyingglass.circle.fill")
                Image(systemName: "heart.circle.fill")
                Image(systemName: "star.circle.fill")
                Image(systemName: "flag.circle.fill")
                Image(systemName: "location.circle.fill")
                Image(systemName: "tag.circle.fill")
                Image(systemName: "camera.circle.fill")
                Image(systemName: "phone.circle.fill")
                Image(systemName: "bag.circle.fill")
            }
            HStack{
                Image(systemName: "cart.circle.fill")
                Image(systemName: "hammer.circle.fill")
                Image(systemName: "briefcase.circle.fill")
                Image(systemName: "house.circle.fill")
                Image(systemName: "building.2.circle.fill")
                Image(systemName: "mappin.circle.fill")
                Image(systemName: "pin.circle.fill")
                Image(systemName: "tv.circle.fill")
                Image(systemName: "headphones.circle.fill")
                Image(systemName: "car.circle.fill")
            }
 
            HStack{
                Image(systemName: "airplane.circle.fill")
                Image(systemName: "bicycle.circle.fill")
                Image(systemName: "leaf.circle.fill")
                Image(systemName: "photo.circle.fill")
                Image(systemName: "film.circle.fill")
                Image(systemName: "fork.knife.circle.fill")
                Image(systemName: "staroflife.circle.fill")
                Image(systemName: "gift.circle.fill")
                Image(systemName: "at.circle.fill")
                Image(systemName: "questionmark.circle.fill")
            }

            HStack{
                Image(systemName: "exclamationmark.circle.fill")
                Image(systemName: "number.circle.fill")
                Image(systemName: "dollarsign.circle.fill")
                Image(systemName: "pawprint.circle.fill")
                Image(systemName: "bolt.circle.fill")
                Image(systemName: "globe.americas.fill")
                Image(systemName: "globe.europe.africa.fill")
                Image(systemName: "globe.asia.australia.fill")
                Image(systemName: "clock.fill")
                Image(systemName: "face.smiling.fill")
            }
        }
    }
}
*/
