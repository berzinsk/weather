//
//  Temperature.swift
//  EssentialWeather
//
//  Created by karlis.berzins on 16/01/2020.
//  Copyright © 2020 karlis.berzins. All rights reserved.
//

import Foundation

public struct Temperature: Equatable {
    public let temperature: Double
    public let feelsLike: Double
    public let minTemperature: Double
    public let maxTemperature: Double
    public let humidity: Int

    public init(temperature: Double, feelsLike: Double, minTemperature: Double, maxTemperature: Double, humidity: Int) {
        self.temperature = temperature
        self.feelsLike = feelsLike
        self.minTemperature = minTemperature
        self.maxTemperature = maxTemperature
        self.humidity = humidity
    }
}

extension Temperature: Decodable {
    private enum CodingKeys: String, CodingKey {
        case temperature = "temp"
        case feelsLike = "feels_like"
        case minTemperature = "temp_min"
        case maxTemperature = "temp_max"
        case humidity
    }
}
