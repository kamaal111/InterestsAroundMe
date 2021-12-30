//
//  DetailsScreen.swift
//  InterestAroundMe
//
//  Created by Kamaal M Farah on 30/12/2021.
//

import SwiftUI
import IAMNetworker
import PopperUp

struct DetailsScreen: View {
    @EnvironmentObject
    private var popperUpManager: PopperUpManager
    @EnvironmentObject
    private var stackNavigator: StackNavigator

    @StateObject private var viewModel = ViewModel()

    let preview: Bool

    init(preview: Bool = false) {
        self.preview = preview
    }

    var body: some View {
        VStack {
            Text("Hello, World!")
        }
        .onChange(of: viewModel.error, perform: { newValue in
            guard let error = newValue else {
                popperUpManager.hidePopup()
                return
            }
            popperUpManager.showPopup(
                ofType: .error,
                title: "Sorry",
                description: error.errorDescription,
                timeout: 3)
        })
        .onAppear(perform: {
            viewModel.setPreview(preview)
            guard let place = stackNavigator.currentOptions?["place"] as? IAMNPlace else { return }
            viewModel.setPlace(place)
        })
    }
}

struct DetailsScreen_Previews: PreviewProvider {
    static var previews: some View {
        DetailsScreen(preview: true)
            .environmentObject(StackNavigator())
    }
}
