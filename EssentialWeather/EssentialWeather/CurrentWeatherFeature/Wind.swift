//
//  Wind.swift
//  EssentialWeather
//
//  Created by karlis.berzins on 27/01/2020.
//  Copyright © 2020 karlis.berzins. All rights reserved.
//

import Foundation

public struct Wind: Equatable {
    public let speed: Double

    public init(speed: Double) {
        self.speed = speed
    }
}
