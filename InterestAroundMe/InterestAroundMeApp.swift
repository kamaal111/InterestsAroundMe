//
//  InterestAroundMeApp.swift
//  InterestAroundMe
//
//  Created by Kamaal M Farah on 28/12/2021.
//

import SwiftUI

@main
struct InterestAroundMeApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
