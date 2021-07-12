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
                color = "black"
            }, label: {
                Image(systemName: "circle.fill")
                    .foregroundColor(getColor(color: "black"))
                    .font( color == "black" ? .title : .title3 )
            })
            Button(action: {
                color = "red"
            }, label: {
                Image(systemName: "circle.fill")
                    .foregroundColor(getColor(color: "red"))
                    .font( color == "red" ? .title : .title3 )

            })
            Button(action: {
                color = "orange"
            }, label: {
                Image(systemName: "circle.fill")
                    .foregroundColor(getColor(color: "orange"))
                    .font( color == "orange" ? .title : .title3 )
            })
            Button(action: {
                color = "yellow"
            }, label: {
                Image(systemName: "circle.fill")
                    .foregroundColor(getColor(color: "yellow"))
                    .font( color == "yellow" ? .title : .title3 )

            })
            Button(action: {
                color = "green"
            }, label: {
                Image(systemName: "circle.fill")
                    .foregroundColor(getColor(color: "green"))
                    .font( color == "green" ? .title : .title3 )

            })
            Button(action: {
                color = "blue"
            }, label: {
                Image(systemName: "circle.fill")
                    .foregroundColor(getColor(color: "blue"))
                    .font( color == "blue" ? .title : .title3 )

            })
            Button(action: {
                color = "purple"
            }, label: {
                Image(systemName: "circle.fill")
                    .foregroundColor(getColor(color: "purple"))
                    .font( color == "purple" ? .title : .title3 )
            })
        }
    }
}

struct ColorChoice_Previews: PreviewProvider {
    static var previews: some View {
        ColorChoice(color: .constant("black"))
    }
}

func getColor(color: String) -> Color {
    //if color == "white" {return Color.white}
    if color == "black" {return Color.black.opacity(1.0)}
    if color == "red" {return Color.red.opacity(1.0)}
    if color == "orange" {return Color.orange.opacity(1.0)}
    if color == "yellow" {return Color.yellow.opacity(1.0)}
    if color == "green" {return Color.green.opacity(1.0)}
    if color == "blue" {return Color.blue.opacity(1.0)}
    if color == "purple" {return Color.purple.opacity(1.0)}
    if color == "gray" {return Color.gray.opacity(1.0)}
    else {return Color.black}
}

func getTextColor(color: String) -> Color {
    return Color.black
    /*if color == "black" {return Color.white}
    else {
        return Color.black
        
    }*/
}

