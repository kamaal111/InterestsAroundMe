//
//  ContentView.swift
//  InterestAroundMe
//
//  Created by Kamaal M Farah on 28/12/2021.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            HomeScreen()
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
