//
//  ColorChoice.swift
//  RateIt
//
//  Created by Yu-Chen Huang on 7/9/21.
//

import SwiftUI

struct ColorChoice: View {
    @Binding var color: String
    let colors = ["black", "red", "orange", "yellow", "green", "blue", "purple", "gray"]
    
    var body: some View {
        HStack{
            
            ForEach(colors, id: \.self) { choice in
                Button(action: {
                    color = choice
                }, label: {
                    Image(systemName: "circle.fill")
                        .foregroundColor(getColor(color: choice))
                        .font( color == choice ? .title : .title3 )
                })
            }
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

/*
func getTextColor(color: String) -> Color {
    return Color.black
    if color == "black" {return Color.white}
    else {
        return Color.black
    }
}
 */
