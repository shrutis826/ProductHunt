//
//  AppContainer.swift
//  ProductHunt
//

import Foundation

struct AppContainer {
    let apiClient: APIClient
    let productRepository: DefaultProductRepository
    let getProductsUseCase: GetProductsUseCase
    let catalogViewModel: CatalogViewModel

    init?() {
        
        guard let client = APIClient(baseURL: URL(string: "https://dummyjson.com")) else {
            return nil
        }
        self.apiClient = client
        
        let remoteDataSource = ProductDataSource(client: client)

        let repository = DefaultProductRepository(
            remoteDataSource: remoteDataSource
        )

        let useCase = GetProductsUseCase(
            repository: repository
        )

        self.productRepository = repository
        self.getProductsUseCase = useCase
        self.catalogViewModel = CatalogViewModel(getProducts: useCase)
    }
}
