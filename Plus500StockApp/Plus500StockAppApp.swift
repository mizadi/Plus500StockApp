//
//  Plus500StockAppApp.swift
//  Plus500StockApp
//
//  Created by Adi Mizrahi on 06/05/2025.
//

import SwiftUI

@main
struct Plus500StockAppApp: App {

    @StateObject private var viewModel: MainViewModel

    init() {
        let service = Plus500ApiService()
        _viewModel = StateObject(wrappedValue: MainViewModel(service: service))
    }

    var body: some Scene {
        WindowGroup {
            MainView(viewModel: viewModel)
        }
    }
}
/*
 1. 2 Service instances (reduce to 1)
 2. 2 FeedUpdater instance (reduce to 1)
 3. Clean up views (DetailView)
 4. Manage FeedUpdater lifecycle
 5. Error handling , throw gracfully + alert to user
 6. Improve feed model, to handle
 7. Improve network layer, Error handling, better SOC
 8. Improve detailView init, currently using Factory but can be much better
 */
