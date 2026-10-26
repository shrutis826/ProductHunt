//
//  ProductRepository.swift
//  ProductHunt

import Foundation

protocol ProductRepository {
    
    func fetchProducts(limit: Int, skip: Int) async throws -> ProductList

}

