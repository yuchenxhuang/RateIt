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
    
    var body: some View {
        
        VStack{
            HStack{
                Button(action: {
                    icon = "circle.fill"
                }, label: {
                    Image(systemName: "circle.fill")
                        .foregroundColor(getColor(color: color))
                        .font( icon == "circle.fill" ? .title : .title3 )
                })
                Button(action: {
                    icon = "star.circle.fill"
                }, label: {
                    Image(systemName: "star.circle.fill")
                        .foregroundColor(getColor(color: color))
                        .font( icon == "star.circle.fill" ? .title : .title3 )
                })
                Button(action: {
                    icon = "heart.circle.fill"
                }, label: {
                    Image(systemName: "heart.circle.fill")
                        .foregroundColor(getColor(color: color))
                        .font( icon == "heart.circle.fill" ? .title : .title3 )
                })
                Button(action: {
                    icon = "face.smiling.fill"
                }, label: {
                    Image(systemName: "face.smiling.fill")
                        .foregroundColor(getColor(color: color))
                        .font( icon == "face.smiling.fill" ? .title : .title3 )
                })
                Button(action: {
                    icon = "exclamationmark.circle.fill"
                }, label: {
                    Image(systemName: "exclamationmark.circle.fill")
                        .foregroundColor(getColor(color: color))
                        .font( icon == "exclamationmark.circle.fill" ? .title : .title3 )
                })
                Button(action: {
                    icon = "questionmark.circle.fill"
                }, label: {
                    Image(systemName: "questionmark.circle.fill")
                        .foregroundColor(getColor(color: color))
                        .font( icon == "questionmark.circle.fill" ? .title : .title3 )
                })
                Button(action: {
                    icon = "number.circle.fill"
                }, label: {
                    Image(systemName: "number.circle.fill")
                        .foregroundColor(getColor(color: color))
                        .font( icon == "number.circle.fill" ? .title : .title3 )
                })
                Button(action: {
                    icon = "at.circle.fill"
                }, label: {
                    Image(systemName: "at.circle.fill")
                        .foregroundColor(getColor(color: color))
                        .font( icon == "at.circle.fill" ? .title : .title3 )
                })
                Button(action: {
                    icon = "dollarsign.circle.fill"
                }, label: {
                    Image(systemName: "dollarsign.circle.fill")
                        .foregroundColor(getColor(color: color))
                        .font( icon == "dollarsign.circle.fill" ? .title : .title3 )
                })
                Button(action: {
                    icon = "staroflife.circle.fill"
                }, label: {
                    Image(systemName: "staroflife.circle.fill")
                        .foregroundColor(getColor(color: color))
                        .font( icon == "staroflife.circle.fill" ? .title : .title3 )
                })
            }
            .padding(.bottom, 2)
            HStack{
                Button(action: {
                    icon = "folder.circle.fill"
                }, label: {
                    Image(systemName: "folder.circle.fill")
                        .foregroundColor(getColor(color: color))
                        .font( icon == "folder.circle.fill" ? .title : .title3 )
                })
                Button(action: {
                    icon = "book.circle.fill"
                }, label: {
                    Image(systemName: "book.circle.fill")
                        .foregroundColor(getColor(color: color))
                        .font( icon == "book.circle.fill" ? .title : .title3 )
                })
                Button(action: {
                    icon = "bookmark.circle.fill"
                }, label: {
                    Image(systemName: "bookmark.circle.fill")
                        .foregroundColor(getColor(color: color))
                        .font( icon == "bookmark.circle.fill" ? .title : .title3 )
                })
                Button(action: {
                    icon = "person.circle.fill"
                }, label: {
                    Image(systemName: "person.circle.fill")
                        .foregroundColor(getColor(color: color))
                        .font( icon == "person.circle.fill" ? .title : .title3 )
                })
                Button(action: {
                    icon = "pin.circle.fill"
                }, label: {
                    Image(systemName: "pin.circle.fill")
                        .foregroundColor(getColor(color: color))
                        .font( icon == "pin.circle.fill" ? .title : .title3 )
                })
                Button(action: {
                    icon = "cart.circle.fill"
                }, label: {
                    Image(systemName: "cart.circle.fill")
                        .foregroundColor(getColor(color: color))
                        .font( icon == "cart.circle.fill" ? .title : .title3 )
                })
                Button(action: {
                    icon = "airplane.circle.fill"
                }, label: {
                    Image(systemName: "airplane.circle.fill")
                        .foregroundColor(getColor(color: color))
                        .font( icon == "airplane.circle.fill" ? .title : .title3 )
                })
                Button(action: {
                    icon = "tv.circle.fill"
                }, label: {
                    Image(systemName: "tv.circle.fill")
                        .foregroundColor(getColor(color: color))
                        .font( icon == "tv.circle.fill" ? .title : .title3 )
                })
                Button(action: {
                    icon = "house.circle.fill"
                }, label: {
                    Image(systemName: "house.circle.fill")
                        .foregroundColor(getColor(color: color))
                        .font( icon == "house.circle.fill" ? .title : .title3 )
                })
                Button(action: {
                    icon = "bolt.circle.fill"
                }, label: {
                    Image(systemName: "bolt.circle.fill")
                        .foregroundColor(getColor(color: color))
                        .font( icon == "bolt.circle.fill" ? .title : .title3 )
                })
            }
        }
    }
}

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

struct IconView: View {
    var icon: String
    var color: String

    var body: some View {
        Image(systemName: icon)
            .foregroundColor(getColor(color:color) )
    }
}

