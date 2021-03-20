//
//  HermesClient.swift
//  FlicksBox
//
//  Created by sn.alekseev on 06.03.2021.
//

import Foundation

public final class HermesClient {
    private var baseUrl: String
    
    public init(with baseUrl: String) {
        self.baseUrl = baseUrl
    }
    
    public func run(request: HermesRequest) {
        let urlString = baseUrl + request.path
        var components = URLComponents(string: urlString)
        components?.queryItems = request.params.map { (key, value) in
            URLQueryItem(name: key, value: value)
        }
        guard let encodedQuery = components?.percentEncodedQuery?.replacingOccurrences(of: "+", with: "%2B") else {
            request.errorHandler?(HermesError.invalidUrl)
            return
        }
        components?.percentEncodedQuery = encodedQuery
        guard let url = components?.url else {
            request.errorHandler?(HermesError.invalidUrl)
            return
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
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
            request.successHandler?(HermesResponse(data: HermesData(with: data), code: response.statusCode))
        }
        task.resume()
    }
}
