//
//  DefaultProductRepository.swift
//  ProductHunt

import Foundation

struct DefaultProductRepository: ProductRepository {
    let remoteDataSource: ProductDataSource

    func fetchProducts(limit: Int, skip: Int
    ) async throws -> ProductList {
        let response = try await remoteDataSource.fetchProducts(
            limit: limit,
            skip: skip
        )
        return ProductList(products: response.products, total: response.total, skip: response.skip, limit: response.limit)
    }
}
