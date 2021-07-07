//
//  RateItApp.swift
//  RateIt
//
//  Created by Yu-Chen Huang on 7/7/21.
//

import SwiftUI

@main
struct RateItApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
