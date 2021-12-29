//
//  HomeScreen.swift
//  InterestAroundMe
//
//  Created by Kamaal M Farah on 29/12/2021.
//

import SwiftUI
import PopperUp
import os.log

struct HomeScreen: View {
    @EnvironmentObject
    private var popperUpManager: PopperUpManager

    @StateObject private var viewModel = ViewModel()

    private let preview: Bool

    init(preview: Bool = false) {
        self.preview = preview
    }

    var body: some View {
        VStack {
            Text("Hello world!")
        }
        .onAppear(perform: {
            Task {
                do {
                    try await viewModel.loadViewData(preview: preview)
                } catch {
                    Logger.homeScreen.error("Hello \(error.localizedDescription)")
                    popperUpManager.showPopup(
                        ofType: .error,
                        title: "Sorry",
                        description: "Something went wrong while fetching data")
                }
            }
        })
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen(preview: true)
            .withPopperUp(PopperUpManager())
    }
}
