//
//  ContentView.swift
//  RateIt
//
//  Created by Yu-Chen Huang on 7/9/21.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        //ImagePickerExampleView()

        NavigationView {
            HomeView()
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
