//
//  CatalogViewmOdel.swift
//  ProductHunt


import Foundation
import Observation

@MainActor
@Observable
final class CatalogViewModel {
    enum State {
        case idle
        case loading
        case loaded([Product])
        case failed(String)
    }

    private(set) var state: State = .idle

    private let getProducts: GetProductsUseCase

    init(getProducts: GetProductsUseCase) {
        self.getProducts = getProducts
    }

    func loadProducts() async {
        state = .loading

        do {
            let page = try await getProducts.execute()
            state = .loaded(page.products)
        } catch {
            state = .failed(error.localizedDescription)
        }
    }

    func retry() async {
        await loadProducts()
    }
}
