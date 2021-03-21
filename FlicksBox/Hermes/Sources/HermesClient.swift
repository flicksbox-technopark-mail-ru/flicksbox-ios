//
//  HermesClient.swift
//  FlicksBox
//
//  Created by sn.alekseev on 06.03.2021.
//

import Foundation

public final class HermesClient {
    private let baseUrl: String
    
    private let headers: [String: String]
    
    private var standartHeaders: [String: String] {
        return [
            "Content-Type": "application/json",
            "User-Agent": "FlicksBox/1.0 iOS"
        ]
    }
    
    public init(with baseUrl: String, headers: [String: String]? = nil) {
        self.baseUrl = baseUrl
        self.headers = headers ?? [:]
    }
    
    private func createRequest(with request: HermesRequest) -> URLRequest? {
        let urlString = baseUrl + request.path
        var components = URLComponents(string: urlString)
        components?.queryItems = request.params.map { (key, value) in
            URLQueryItem(name: key, value: value)
        }
        guard let encodedQuery = components?.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B") else {
            return nil
        }
        components?.percentEncodedQuery = encodedQuery
        guard let url = components?.url else {
            return nil
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        urlRequest.httpBody = request.body
        var httpHeaders = standartHeaders
        for (key, value) in headers {
            httpHeaders.updateValue(value, forKey: key)
        }
        for (key, value) in request.headers {
            httpHeaders.updateValue(value, forKey: key)
        }
        urlRequest.allHTTPHeaderFields = httpHeaders
        return urlRequest
    }
    
    public func run(with request: HermesRequest) {
        guard let urlRequest = createRequest(with: request) else {
            request.errorHandler?(HermesError.invalidUrl)
            return
        }
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                request.errorHandler?(error)
                return
            }
            guard let data = data else {
                request.errorHandler?(HermesError.emptyData)
                return
            }
            guard let response = response as? HTTPURLResponse else {
                request.errorHandler?(HermesError.invalidCode)
                return
            }
            request.successHandler?(.init(data: .init(with: data), code: response.statusCode, headers: response.allHeaderFields))
        }
        task.resume()
    }
}
