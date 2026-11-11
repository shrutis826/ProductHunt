//
//  CatalogView.swift
//  ProductHunt
//

import Foundation
import SwiftUI

struct CatalogView: View {
    @State private var viewModel: CatalogViewModel

    init?(viewModel: CatalogViewModel?) {
        guard let viewModel = viewModel else {
            return nil
        }
        _viewModel = State(initialValue: viewModel)
    }

    var body: some View {
        NavigationStack {
            Group {
                switch viewModel.state {
                case .idle, .loading:
                    ProgressView("Loading products...")

                case .loaded(let products):
                    List(products) { product in
                        ListCell(product: product)
                            .padding(.vertical, 4)
                    }

                case .failed(let message):
                    ContentUnavailableView {
                        Label(
                            "Unable to load products",
                            systemImage: "wifi.exclamationmark"
                        )
                    } description: {
                        Text(message)
                    } actions: {
                        Button("Retry") {
                            Task {
                                await viewModel.retry()
                            }
                        }
                    }
                }
            }
            .navigationTitle("ProductList")
            .task {
                if case .idle = viewModel.state {
                    await viewModel.loadProducts()
                }
            }
        }
    }
}

struct ListCell: View {
    
    let product: Product
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            AsyncImage(url: URL(string: product.thumbnail)) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .frame(width: 60, height: 60)
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 60, height: 60)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                case .failure:
                    Image(systemName: "photo")
                        .font(.title2)
                        .foregroundStyle(.secondary)
                        .frame(width: 60, height: 60)
                @unknown default:
                    EmptyView()
                }
            }
            .frame(width: 60, height: 60)
            .background(Color.secondary.opacity(0.1))
            .clipShape(RoundedRectangle(cornerRadius: 8))

            VStack(alignment: .leading, spacing: 4) {
                Text(product.title)
                    .font(.headline)

                if let brand = product.brand, !brand.isEmpty {
                    Text(brand)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }

                Text(product.availabilityStatus)
                    .font(.caption)
                    .foregroundStyle(.secondary)

                Text("$\(product.price, specifier: "%.2f")")
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundStyle(.primary)
            }
        }
    }
}
