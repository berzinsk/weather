//
//  CurrentWeather.swift
//  EssentialWeather
//
//  Created by karlis.berzins on 16/01/2020.
//  Copyright © 2020 karlis.berzins. All rights reserved.
//

import Foundation

public struct CurrentWeather: Equatable {
    public let weather: [Weather]
    public let temperature: Temperature
    public let wind: Wind

    public init(weather: [Weather], temperature: Temperature, wind: Wind) {
        self.weather = weather
        self.temperature = temperature
        self.wind = wind
    }
}

extension CurrentWeather: Decodable {
    private enum CodingKeys: String, CodingKey {
        case weather
        case temperature = "main"
        case wind
    }
}
