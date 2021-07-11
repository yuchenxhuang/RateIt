//
//  NumberChoice.swift
//  RateIt
//
//  Created by Yu-Chen Huang on 7/10/21.
//

import SwiftUI

struct NumberChoice: View {
    @Binding var rating: Double
    
    var body: some View {
        HStack{
            Button(action: {
                rating = 1
            }, label: {
                Image(systemName: rating == 1 ? "1.circle.fill" : "1.circle")
                    .font( rating == 1 ? .title : .title3 )
            })
            Button(action: {
                rating = 2
            }, label: {
                Image(systemName: rating == 2 ? "2.circle.fill" : "2.circle")
                    .font( rating == 2 ? .title : .title3 )
            })
            Button(action: {
                rating = 3
            }, label: {
                Image(systemName: rating == 3 ? "3.circle.fill" : "3.circle")
                    .font( rating == 3 ? .title : .title3 )
            })
            Button(action: {
                rating = 4
            }, label: {
                Image(systemName: rating == 4 ? "4.circle.fill" : "4.circle")
                    .font( rating == 4 ? .title : .title3 )
            })
            Button(action: {
                rating = 5
            }, label: {
                Image(systemName: rating == 5 ? "5.circle.fill" : "5.circle")
                    .font( rating == 5 ? .title : .title3 )
            })
            Button(action: {
                rating = 6
            }, label: {
                Image(systemName: rating == 6 ? "6.circle.fill" : "6.circle")
                    .font( rating == 6 ? .title : .title3 )
            })
            Button(action: {
                rating = 7
            }, label: {
                Image(systemName: rating == 7 ? "7.circle.fill" : "7.circle")
                    .font( rating == 7 ? .title : .title3 )
            })
            Button(action: {
                rating = 8
            }, label: {
                Image(systemName: rating == 8 ? "8.circle.fill" : "8.circle")
                    .font( rating == 8 ? .title : .title3 )
            })
            Button(action: {
                rating = 9
            }, label: {
                Image(systemName: rating == 9 ? "9.circle.fill" : "9.circle")
                    .font( rating == 9 ? .title : .title3 )
            })
            Button(action: {
                rating = 10
            }, label: {
                Image(systemName: rating == 10 ? "10.circle.fill" : "10.circle")
                    .font( rating == 10 ? .title : .title3 )
            })
        }
    }
}

struct NumberChoice_Previews: PreviewProvider {
    static var previews: some View {
        Text("Hello")
        //NumberChoice()
    }
}
