//
//  RemoteCurrentWeatherLoaderTests.swift
//  EssentialWeatherTests
//
//  Created by karlis.berzins on 18/01/2020.
//  Copyright © 2020 karlis.berzins. All rights reserved.
//

import XCTest

class RemoteCurrentWeatherLoader {
    private let client: HTTPClient

    init(client: HTTPClient) {
        self.client = client
    }
    func load() {
        client.get(from: URL(string: "http://a-url.com")!)
    }
}

protocol HTTPClient {
    func get(from url: URL)
}

class HTTPClientSpy: HTTPClient {
    var requestedURL: URL?

    func get(from url: URL) {
        requestedURL = url
    }
}

class RemoteCurrentWeatherLoaderTests: XCTestCase {
    func test_init_doesNotRequestDataFromURL() {
        let client = HTTPClientSpy()
        _ = RemoteCurrentWeatherLoader(client: client)

        XCTAssertNil(client.requestedURL)
    }

    func test_load_requestDataFromURL() {
        let client = HTTPClientSpy()
        let sut = RemoteCurrentWeatherLoader(client: client)

        sut.load()

        XCTAssertNotNil(client.requestedURL)
    }
}
