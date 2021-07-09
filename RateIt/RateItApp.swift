//
//  RateItApp.swift
//  RateIt
//
//  Created by Yu-Chen Huang on 7/7/21.
//

import SwiftUI

@main
struct RateItApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, PersistenceProvider.default.context)
        }
    }
}
