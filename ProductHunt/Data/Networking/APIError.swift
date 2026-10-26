//
//  APIError.swift
//  ProductHunt

import Foundation

enum APIError: LocalizedError {
    case invalidURL
    case invalidResponse
    case httpStatus(Int)
    case decoding(Error)

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid request URL."
        case .invalidResponse:
            return "Invalid server response."
        case .httpStatus(let code):
            return "Server returned HTTP \(code)."
        case .decoding:
            return "Unable to decode server data."
        }
    }
}
