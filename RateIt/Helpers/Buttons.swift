//
//  FloatingButton.swift
//  RateIt
//
//  Created by Yu-Chen Huang on 7/17/21.
//

import SwiftUI

struct FloatingButton: View {
    @Binding var isPresented: Bool
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Button(action: {
                    isPresented = true
                }, label: {
                    ZStack {
                        Image(systemName: "circle.fill")
                            .font(.system(size: 50))
                            .foregroundColor(Color.white)
                        Image(systemName: "plus.circle.fill")
                            .font(.system(size: 50))
                            .foregroundColor(Color.blue)
                    }
                })
                .padding(.trailing, 20)
                //.padding(.bottom, 3)
            }
        }
        
    }
}

struct SortingButton: View {
    let name: String
    let Name: String
    @Binding var sortedBy: String
    
    var body: some View {
        Button(action: {
            sortedBy = name
        }, label: {
            HStack() {
                Text(Name)
                if sortedBy == name {
                    Image(systemName: "checkmark")
                }
            }
        })
    }
}
