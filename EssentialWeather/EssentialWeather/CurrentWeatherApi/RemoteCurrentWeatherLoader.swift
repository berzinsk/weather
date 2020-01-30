//
//  RemoteCurrentWeatherLoader.swift
//  EssentialWeather
//
//  Created by karlis.berzins on 22/01/2020.
//  Copyright © 2020 karlis.berzins. All rights reserved.
//

import Foundation

public typealias HTTPClientResult = Swift.Result<(Data, HTTPURLResponse), Error>

public protocol HTTPClient {
    func get(from url: URL, completion: @escaping (HTTPClientResult) -> Void)
}

public final class RemoteCurrentWeatherLoader
 {
    private let url: URL
    private let client: HTTPClient

    public enum Error: Swift.Error {
        case connectivity
        case invalidData
        case missingData
    }

    public typealias Result = Swift.Result<CurrentWeather, Error>

    public init(url: URL, client: HTTPClient) {
        self.url = url
        self.client = client
    }

    public func load(completion: @escaping (Result) -> Void) {
        client.get(from: url) { result in
            switch result {
            case let .success(data, _):
                if let currentWeather = try? JSONDecoder().decode(CurrentWeather.self, from: data) {
                    completion(.success(currentWeather))
                } else if let _ = try? JSONSerialization.jsonObject(with: data) {
                    completion(.failure(.missingData))
                } else {
                    completion(.failure(.invalidData))
                }
            case .failure:
                completion(.failure(.connectivity))
            }
        }
    }
}
