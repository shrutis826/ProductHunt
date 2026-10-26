//
//  ProductDataSource.swift
//  ProductHunt

import Foundation

struct ProductDataSource {
    let client: APIClient

    func fetchProducts(limit: Int = 10, skip: Int = 0) async throws -> ProductList {
        try await client.get("products",
                             queryItems: [
                                URLQueryItem(
                                    name: "limit",
                                    value: String(limit)
                                ),
                                URLQueryItem(
                                    name: "skip",
                                    value: String(skip)
                                )
                             ]
        )
    }
}
