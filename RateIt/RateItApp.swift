//
//  RateItApp.swift
//  RateIt
//
//  Created by Yu-Chen Huang on 7/7/21.
//

import SwiftUI

@main
struct RateItApp: App {
    
    // test font family names
    /*
    init() {
        for family in UIFont.familyNames.sorted() {
            let names = UIFont.fontNames(forFamilyName: family)
            print("Family: \(family) Font names: \(names)")
        }
    }
    */
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, PersistenceProvider.default.context)
        }
    }
    

}
