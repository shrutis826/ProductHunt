//
//  APIClient.swift
//  ProductHunt


import Foundation

struct APIClient {
    let baseURL: URL
    let session: URLSession

    init?(
        baseURL: URL? = URL(string: "https://dummyjson.com/products"),
        session: URLSession = .shared
    ) {
        guard let baseURL = baseURL else {
            return nil
        }

        self.baseURL = baseURL
        self.session = session
    }

    func get<T: Decodable>(_ path: String, queryItems: [URLQueryItem] = []) async throws -> T {
        let endpoint = baseURL.appending(path: path)

        guard var components = URLComponents(
            url: endpoint,
            resolvingAgainstBaseURL: false
        ) else {
            throw APIError.invalidURL
        }

        components.queryItems = queryItems

        guard let url = components.url else {
            throw APIError.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Accept"
        )

        let (data, response) = try await session.data(
            for: request
        )

        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.invalidResponse
        }

        guard (200..<300).contains(httpResponse.statusCode) else {
            throw APIError.httpStatus(httpResponse.statusCode)
        }

        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw APIError.decoding(error)
        }
    }
}
