//
//  NumberChoice.swift
//  RateIt
//
//  Created by Yu-Chen Huang on 7/10/21.
//

import SwiftUI

struct NumberChoice: View {
    @Binding var rating: Double
    let numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

    var body: some View {
        HStack{
            ForEach(numbers, id: \.self) { choice in
                Button(action: {
                    rating = Double(choice)
                }, label: {
                    Image(systemName: "\(choice).circle.fill")
                        .font( rating == Double(choice) ? .title : .title2 )
                })
                .padding(.trailing, choice == 10 ? 0 : -3)
            }
        }
    }
}

struct NumberChoiceDetail: View {
    @Binding var rating: Double
    @Binding var isRating: Bool
    let numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

    var body: some View {
        HStack(){
            ForEach(numbers, id: \.self) { choice in
                Button(action: {
                    rating = Double(choice)
                    isRating = false
                }, label: {
                    Image(systemName: "\(choice).circle.fill")
                        .font( rating == Double(choice) ? .title : .title2 )
                })
                .padding(.trailing, 0)
            }
        }
    }
}

struct NumberChoice_Previews: PreviewProvider {
    static var previews: some View {
        NumberChoice(rating: .constant(1.0))
    }
}
