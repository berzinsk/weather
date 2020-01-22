//
//  RemoteCurrentWeatherLoader.swift
//  EssentialWeather
//
//  Created by karlis.berzins on 22/01/2020.
//  Copyright © 2020 karlis.berzins. All rights reserved.
//

import Foundation

public protocol HTTPClient {
    func get(from url: URL)
}

public final class RemoteCurrentWeatherLoader {
    private let url: URL
    private let client: HTTPClient

    public init(url: URL, client: HTTPClient) {
        self.url = url
        self.client = client
    }

    public func load() {
        client.get(from: url)
    }
}
