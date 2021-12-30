//
//  ContentView.swift
//  InterestAroundMe
//
//  Created by Kamaal M Farah on 28/12/2021.
//

import SwiftUI
import PopperUp

struct ContentView: View {
    @StateObject private var popperUpManager = PopperUpManager()
    @StateObject private var locationManager = LocationManager()

    var body: some View {
        NavigationView {
            HomeScreen(preview: Features.previewFoursquareData)
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .environmentObject(locationManager)
        .withPopperUp(popperUpManager)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
            .environmentObject(LocationManager())
            .withPopperUp(PopperUpManager())
    }
}
