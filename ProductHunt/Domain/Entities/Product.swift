//
//  Product.swift
//  ProductHunt

import Foundation

// MARK: - ProductList
struct ProductList: Decodable {
    let products: [Product]
    let total, skip, limit: Int
}

// MARK: - Product
struct Product: Decodable {
    let id: Int
    let title, productDescription, category: String
    let price, discountPercentage, rating: Double
    let stock: Int
    let tags: [String]
    let brand, sku: String
    let weight: Int
    let dimensions: Dimensions
    let warrantyInformation, shippingInformation, availabilityStatus: String
    let reviews: [Review]
    let returnPolicy: String
    let minimumOrderQuantity: Int
    let meta: Meta
    let thumbnail: String
    let images: [String]
}

// MARK: - Dimensions
struct Dimensions: Decodable {
    let width, height, depth: Double
}

// MARK: - Meta
struct Meta: Decodable {
    let createdAt, updatedAt, barcode, qrCode: String
}

// MARK: - Review
struct Review: Decodable {
    let rating: Int
    let comment, date, reviewerName, reviewerEmail: String
}

