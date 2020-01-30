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
    }

    public typealias Result = Swift.Result<CurrentWeather, Error>

    public init(url: URL, client: HTTPClient) {
        self.url = url
        self.client = client
    }

    public func load(completion: @escaping (Result) -> Void) {
        client.get(from: url) { result in
            switch result {
            case let .success(data, response):
                do {
                    let currentWeather = try CurrentWeatherItemMapper.map(data, response)
                    completion(.success(currentWeather))
                } catch {
                    completion(.failure(.invalidData))
                }
            case .failure:
                completion(.failure(.connectivity))
            }
        }
    }
}

private class CurrentWeatherItemMapper {
    private struct Item: Decodable {
        let weather: [WeatherItem]
        let main: TemperatureItem
        let wind: Wind

        var item: CurrentWeather {
            let mapperWeather = weather.map { $0.item }
            return CurrentWeather(weather: mapperWeather, temperature: main.item, wind: wind)
        }
    }

    private struct WeatherItem: Decodable {
        let id: Int
        let main: String
        let description: String
        let icon: String

        var item: Weather {
            return Weather(id: id, status: main, description: description, icon: icon)
        }
    }

    private struct TemperatureItem: Decodable {
        let temp: Double
        let feelsLike: Double
        let tempMin: Double
        let tempMax: Double
        let humidity: Int

        var item: Temperature {
            return Temperature(temperature: temp, feelsLike: feelsLike, minTemperature: tempMin, maxTemperature: tempMax, humidity: humidity)
        }

        private enum CodingKeys: String, CodingKey {
            case temp = "temp"
            case feelsLike = "feels_like"
            case tempMin = "temp_min"
            case tempMax = "temp_max"
            case humidity
        }
    }

    static func map(_ data: Data, _ response: HTTPURLResponse) throws -> CurrentWeather {
        guard response.statusCode == 200 else {
            throw RemoteCurrentWeatherLoader.Error.invalidData
        }

        return try JSONDecoder().decode(Item.self, from: data).item
    }
}
