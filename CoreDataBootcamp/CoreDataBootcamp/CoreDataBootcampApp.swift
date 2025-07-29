//
//  CoreDataBootcampApp.swift
//  CoreDataBootcamp
//
//  Created by Juan David Gutierrez Olarte on 29/07/25.
//

import SwiftUI

@main
struct CoreDataBootcampApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
