//
//  CurrentWeatherLoader.swift
//  EssentialWeather
//
//  Created by karlis.berzins on 16/01/2020.
//  Copyright © 2020 karlis.berzins. All rights reserved.
//

import Foundation

typealias LoadCurrentWeatherResult = Swift.Result<CurrentWeather, Error>

protocol CurrentWeatherLoader {
    func load(completion: @escaping (LoadCurrentWeatherResult) -> Void)
}
