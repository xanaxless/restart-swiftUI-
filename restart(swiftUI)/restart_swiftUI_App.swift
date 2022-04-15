//
//  restart_swiftUI_App.swift
//  restart(swiftUI)
//
//  Created by Yerkebulan Serikov on 15.04.2022.
//

import SwiftUI

@main
struct restart_swiftUI_App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
