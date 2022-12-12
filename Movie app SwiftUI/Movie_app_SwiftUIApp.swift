//
//  Movie_app_SwiftUIApp.swift
//  Movie app SwiftUI
//
//  Created by Gabriel Busto on 12/7/22.
//

import SwiftUI

@main
struct Movie_app_SwiftUIApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
