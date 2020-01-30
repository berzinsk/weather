//
//  RemoteCurrentWeatherLoaderTests.swift
//  EssentialWeatherTests
//
//  Created by karlis.berzins on 18/01/2020.
//  Copyright © 2020 karlis.berzins. All rights reserved.
//

import XCTest
import EssentialWeather

class RemoteCurrentWeatherLoaderTests: XCTestCase {
    func test_init_doesNotRequestDataFromURL() {
        let (_, client) = makeSUT()

        XCTAssertTrue(client.requestedURLs.isEmpty)
    }

    func test_load_requestsDataFromURL() {
        let url = URL(string: "http://a-given-url.com")!
        let (sut, client) = makeSUT(url: url)

        sut.load { _ in }

        XCTAssertEqual(client.requestedURLs, [url])
    }

    func test_loadTwice_requestsDataFromURLTwice() {
        let url = URL(string: "http://a-given-url.com")!
        let (sut, client) = makeSUT(url: url)

        sut.load { _ in }
        sut.load { _ in }

        XCTAssertEqual(client.requestedURLs, [url, url])
    }

    func test_load_deliversErrorOnClientError() {
        let (sut, client) = makeSUT()

        expect(sut, toCompleteWith: .failure(.connectivity), when: {
            let clientError = NSError(domain: "Test", code: 0)
            client.complete(with: clientError)
        })
    }

    func test_load_deliversErrorOnNon200HTTPResponse() {
        let (sut, client) = makeSUT()

        let samples = [199, 201, 300, 400, 500].enumerated()
        samples.forEach { index, code in
            expect(sut, toCompleteWith: .failure(.invalidData), when: {
                let json = makeItemJSON([:])
                client.complete(withStatusCode: code, data: json, at: index)
            })
        }
    }

    func test_load_deliversErrorOn200HTTPResponseWithInvalidJSON() {
        let (sut, client) = makeSUT()

        expect(sut, toCompleteWith: .failure(.invalidData), when: {
            let invalidJSON = Data("invalid json".utf8)
            client.complete(withStatusCode: 200, data: invalidJSON)
        })
    }

    func test_load_deliversNoCurrentWeatherItemOn200HTTPResponseWithEmptyJSON() {
        let (sut, client) = makeSUT()

        expect(sut, toCompleteWith: .failure(.invalidData), when: {
            let emptyJSON = makeItemJSON([:])
            client.complete(withStatusCode: 200, data: emptyJSON)
        })
    }

    func test_load_deliversCurrentWeatherItemOn200HTTPResponseWithJSONItem() {
        let (sut, client) = makeSUT()

        let weather = makeWeatherItem(id: 800, status: "Clear", description: "clear sky", icon: "01n")
        let temperature = makeTemperatureItem(temperature: 10.1, feelsLike: 11.0, minTemp: 7.2, maxTemp: 12, humidity: 85)
        let wind = makeWindItem(speed: 12.3)
        let currentWeather = makeCurrentWeatherItem(weather: [weather], temperature: temperature, wind: wind)

        expect(sut, toCompleteWith: .success(currentWeather.model), when: {
            let json = makeItemJSON(currentWeather.json)
            client.complete(withStatusCode: 200, data: json)
        })
    }

    // MARK:- Helpers

    private func makeSUT(url: URL = URL(string: "http://a-url.com")!) -> (sut: RemoteCurrentWeatherLoader, client: HTTPClientSpy) {
        let client = HTTPClientSpy()
        let sut = RemoteCurrentWeatherLoader(url: url, client: client)

        return (sut, client)
    }

    private func expect(_ sut: RemoteCurrentWeatherLoader, toCompleteWith result: RemoteCurrentWeatherLoader.Result, when action: () -> Void, file: StaticString = #file, line: UInt = #line) {
        var capturedResults: [RemoteCurrentWeatherLoader.Result] = []
        sut.load { capturedResults.append($0) }

        action()

        XCTAssertEqual(capturedResults, [result], file: file, line: line)
    }

    private func makeCurrentWeatherItem(
        weather: [(model: Weather, json: [String: Any])],
        temperature: (model: Temperature, json: [String: Any]),
        wind: (model: Wind, json: [String: Any])
    ) -> (model: CurrentWeather, json: [String: Any]) {
        let weatherModelArray = weather.map { $0.model }
        let weatherJSONArray = weather.map { $0.json }

        let model = CurrentWeather(weather: weatherModelArray, temperature: temperature.model, wind: wind.model)
        let json: [String: Any] = [
            "weather": weatherJSONArray,
            "main": temperature.json,
            "wind": wind.json,
        ]

        return (model, json)
    }

    private func makeWeatherItem(id: Int, status: String, description: String, icon: String) -> (model: Weather, json: [String: Any]) {
        let model = Weather(id: id, status: status, description: description, icon: icon)
        let json: [String: Any] = [
            "id": model.id,
            "main": model.status,
            "description": model.description,
            "icon": model.icon,
        ]

        return (model, json)
    }

    private func makeTemperatureItem(temperature: Double, feelsLike: Double, minTemp: Double, maxTemp: Double, humidity: Int) -> (model: Temperature, json: [String: Any]) {
        let model = Temperature(temperature: temperature, feelsLike: feelsLike, minTemperature: minTemp, maxTemperature: maxTemp, humidity: humidity)
        let json: [String: Any] = [
            "temp": model.temperature,
            "feels_like": model.feelsLike,
            "temp_min": model.minTemperature,
            "temp_max": model.maxTemperature,
            "humidity": model.humidity
        ]

        return (model, json)
    }

    private func makeWindItem(speed: Double) -> (model: Wind, json: [String: Any]) {
        let model = Wind(speed: speed)
        let json = ["speed": model.speed]

        return (model, json)
    }

    private func makeItemJSON(_ item: [String: Any]) -> Data {
        return try! JSONSerialization.data(withJSONObject: item)
    }

    private class HTTPClientSpy: HTTPClient {
        private var messages = [(url: URL, completion: (HTTPClientResult) -> Void)]()
        var requestedURLs: [URL] {
            return messages.map { $0.url }
        }

        func get(from url: URL, completion: @escaping (HTTPClientResult) -> Void) {
            messages.append((url, completion))
        }

        func complete(with error: Error, at index: Int = 0) {
            messages[index].completion(.failure(error))
        }

        func complete(withStatusCode code: Int, data: Data, at index: Int = 0) {
            let response = HTTPURLResponse(
                url: requestedURLs[index],
                statusCode: code,
                httpVersion: nil,
                headerFields: nil
            )!

            messages[index].completion(.success((data, response)))
        }
    }
}
