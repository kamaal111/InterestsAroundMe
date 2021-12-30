//
//  StackNavigator.swift
//  InterestAroundMe
//
//  Created by Kamaal M Farah on 30/12/2021.
//

import SwiftUI

final class StackNavigator: ObservableObject {

    @Published var selectedScreen: Screens?
    @Published private(set) var currentOptions: [String: Codable]?

    enum Screens: CaseIterable {
        case home
        case details

        var view: some View {
            ZStack {
                switch self {
                case .home: HomeScreen()
                case .details: DetailsScreen()
                }
            }
        }
    }

    func navigate(to screen: Screens?, options: [String: Codable]? = nil) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.selectedScreen = screen
            self.currentOptions = options
        }
    }

}
