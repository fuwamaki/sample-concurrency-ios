//
//  SampleConcurrencyApp.swift
//  SampleConcurrency
//
//  Created by yusaku maki on 2021/06/10.
//

import SwiftUI
import Network

@main
struct SampleConcurrencyApp: App {
    private let monitor = NWPathMonitor()
    let persistenceController = PersistenceController.shared

    init() {
        UITableView.appearance().backgroundColor = UIColor.systemBackground
        monitor.pathUpdateHandler = { path in
            APIClient.networkStatus = path.status
        }
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(
                    \.managedObjectContext,
                     persistenceController.container.viewContext)
        }
    }
}
