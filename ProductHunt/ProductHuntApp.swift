//
//  ProductHuntApp.swift
//  ProductHunt


import SwiftUI

@main
struct ProductHuntApp: App {
    
    private let container = AppContainer()

    var body: some Scene {
        WindowGroup {
            CatalogView(
                viewModel: container?.catalogViewModel
            )
        }
    }
}
