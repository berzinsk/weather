//
//  RemoteCurrentWeatherLoaderTests.swift
//  EssentialWeatherTests
//
//  Created by karlis.berzins on 18/01/2020.
//  Copyright © 2020 karlis.berzins. All rights reserved.
//

import XCTest

class RemoteCurrentWeatherLoader {
    private let url: URL
    private let client: HTTPClient

    init(url: URL, client: HTTPClient) {
        self.url = url
        self.client = client
    }
    func load() {
        client.get(from: url)
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
        let url = URL(string: "http://a-url.com")!
        let client = HTTPClientSpy()
        _ = RemoteCurrentWeatherLoader(url: url, client: client)

        XCTAssertNil(client.requestedURL)
    }

    func test_load_requestDataFromURL() {
        let url = URL(string: "http://a-given-url.com")!
        let client = HTTPClientSpy()
        let sut = RemoteCurrentWeatherLoader(url: url, client: client)

        sut.load()

        XCTAssertEqual(client.requestedURL, url)
    }
}
