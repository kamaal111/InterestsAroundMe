//
//  View+Extensions.swift
//  InterestAroundMe
//
//  Created by Kamaal M Farah on 30/12/2021.
//

import SwiftUI

extension View {
    func withNavigationPoints(
        selectedScreen: Binding<StackNavigator.Screens?>,
        stackNavigator: StackNavigator) -> some View {
        ZStack {
            ForEach(StackNavigator.Screens.allCases, id: \.self) { screen in
                NavigationLink(
                    destination: screen.view.environmentObject(stackNavigator),
                    tag: screen,
                    selection: selectedScreen,
                    label: { EmptyView() })
            }
            self
        }
    }
}
