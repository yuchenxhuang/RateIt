//
//  ColorChoice.swift
//  RateIt
//
//  Created by Yu-Chen Huang on 7/9/21.
//

import SwiftUI

struct ColorChoice: View {
    @Binding var color: String
    
    var body: some View {
        HStack{
            Button(action: {
                color = "white"
            }, label: {
                Image(systemName: "circle")
                    .foregroundColor(Color.gray)
                    .font( color == "white" ? .title : .title3 )
            })
            Button(action: {
                color = "red"
            }, label: {
                Image(systemName: "circle.fill")
                    .foregroundColor(Color.red)
                    .font( color == "red" ? .title : .title3 )

            })
            Button(action: {
                color = "orange"
            }, label: {
                Image(systemName: "circle.fill")
                    .foregroundColor(Color.orange)
                    .font( color == "orange" ? .title : .title3 )

            })
            Button(action: {
                color = "yellow"
            }, label: {
                Image(systemName: "circle.fill")
                    .foregroundColor(Color.yellow)
                    .font( color == "yellow" ? .title : .title3 )

            })
            Button(action: {
                color = "green"
            }, label: {
                Image(systemName: "circle.fill")
                    .foregroundColor(Color.green)
                    .font( color == "green" ? .title : .title3 )

            })
            Button(action: {
                color = "blue"
            }, label: {
                Image(systemName: "circle.fill")
                    .foregroundColor(Color.blue)
                    .font( color == "blue" ? .title : .title3 )

            })
            Button(action: {
                color = "purple"
            }, label: {
                Image(systemName: "circle.fill")
                    .foregroundColor(Color.purple)
                    .font( color == "purple" ? .title : .title3 )

            })
            Button(action: {
                color = "black"
            }, label: {
                Image(systemName: "circle.fill")
                    .foregroundColor(Color.black)
                    .font( color == "black" ? .title : .title3 )
            })
        }
    }
}

struct ColorChoice_Previews: PreviewProvider {
    static var previews: some View {
        ColorChoice(color: .constant("white"))
    }
}

func getColor(color: String) -> Color {
    if color == "white" {return Color.white}
    if color == "red" {return Color.red}
    if color == "orange" {return Color.orange}
    if color == "yellow" {return Color.yellow}
    if color == "green" {return Color.green}
    if color == "blue" {return Color.blue}
    if color == "purple" {return Color.purple}
    if color == "black" {return Color.black}
    else {return Color.white}
}

func getTextColor(color: String) -> Color {
    if color == "black" {return Color.white}
    else {return Color.black}
}

