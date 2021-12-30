//
//  DetailsScreen.swift
//  InterestAroundMe
//
//  Created by Kamaal M Farah on 30/12/2021.
//

import SwiftUI
import IAMNetworker

struct DetailsScreen: View {
    @EnvironmentObject
    private var stackNavigator: StackNavigator

    @StateObject private var viewModel = ViewModel()

    var body: some View {
        VStack {
            Text("Hello, World!")
        }
        .onAppear(perform: {
            print(stackNavigator.currentOptions?["place"] as? IAMNPlace)
        })
    }
}

struct DetailsScreen_Previews: PreviewProvider {
    static var previews: some View {
        DetailsScreen()
            .environmentObject(StackNavigator())
    }
}
