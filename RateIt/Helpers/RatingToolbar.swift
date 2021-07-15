//
//  RatingToolbar.swift
//  RateIt
//
//  Created by Yu-Chen Huang on 7/15/21.
//

import SwiftUI

struct RatingToolbar: View {
    @ObservedObject var item: Item
    @Binding var date: Date
    @Binding var rating: Double
    @Binding var isRating: Bool
    
    var body: some View {
        HStack() {
            VStack{
                Button(action: {
                    isRating = !isRating
                }, label: {
                    Image(systemName: "\(item.rating).circle.fill")
                        .font(.largeTitle)
                        .foregroundColor(getColor(color: item.category != nil ? item.category!.color! : "black"))
                })
                .onChange(of: rating, perform: { _ in
                    PersistenceProvider.default.updateRating(item, with: rating)
                })
            }
            .frame(maxWidth: .infinity)
            
            VStack (alignment: .center){
                DatePicker(
                    "Date",
                    selection: $date,
                    displayedComponents: [.date]
                )
                .labelsHidden()
                .accentColor(.black)
                .id(date) // fixes short/medium format switching
                .onChange(of: date, perform: { _ in
                    PersistenceProvider.default.updateDate(item, with: date)
                })
            }
            .frame(maxWidth: .infinity)
            
            VStack{
                Image(systemName: item.favorite ? "star.fill" : "star")
                    .foregroundColor(item.favorite ? Color.yellow : Color.gray)
                    .onTapGesture { PersistenceProvider.default.toggle(item)}
                    .font(.title)
            }
            .frame(maxWidth: .infinity)
        }
        .padding(.leading).padding(.trailing)
        .padding(.bottom, 10)    }
}
