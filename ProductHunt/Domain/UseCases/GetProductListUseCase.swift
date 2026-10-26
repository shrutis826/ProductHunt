//
//  GetProductListUseCase.swift
//  ProductHunt


struct GetProductsUseCase {
    let repository: ProductRepository

    func execute(limit: Int = 10, skip: Int = 0) async throws -> ProductList {
        try await repository.fetchProducts(limit: limit, skip: skip
        )
    }
}
