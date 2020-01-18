//
//  RemoteCurrentWeatherLoaderTests.swift
//  EssentialWeatherTests
//
//  Created by karlis.berzins on 18/01/2020.
//  Copyright © 2020 karlis.berzins. All rights reserved.
//

import XCTest

class RemoteCurrentWeatherLoader {

}

class HTTPClient {
    var requestedURL: URL?
}

class RemoteCurrentWeatherLoaderTests: XCTestCase {
    func test_init_doesNotRequestDataFromURL() {
        let client = HTTPClient()
        let _ = RemoteCurrentWeatherLoader()

        XCTAssertNil(client.requestedURL)
    }
}
