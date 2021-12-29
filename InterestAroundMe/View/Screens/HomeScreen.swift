//
//  HomeScreen.swift
//  InterestAroundMe
//
//  Created by Kamaal M Farah on 29/12/2021.
//

import SwiftUI
import IAMNetworker

struct HomeScreen: View {
    var body: some View {
        Text("Hello world!")
        .onAppear(perform: {
            let networker = IAMNetworker(foursquareAPIKey: Config.foursquareApiKey, kowalskiAnalysis: false)
            Task {
                let result = await networker.findNearbyPlaces(of: (41.8781, -87.6298), limitTo: 5, preview: true)
                print(result)
            }
        })
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
