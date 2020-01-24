//
//  Weather.swift
//  EssentialWeather
//
//  Created by karlis.berzins on 16/01/2020.
//  Copyright © 2020 karlis.berzins. All rights reserved.
//

import Foundation

public struct Weather: Equatable {
    let id: String
    let status: String
    let description: String
    let icon: String
    let windSpeed: Double
    let temperature: Temperature
}
