//
//  Weather.swift
//  EssentialWeather
//
//  Created by karlis.berzins on 16/01/2020.
//  Copyright © 2020 karlis.berzins. All rights reserved.
//

import Foundation

public struct Weather: Equatable {
    public let id: Int
    public let status: String
    public let description: String
    public let icon: String

    public init(id: Int, status: String, description: String, icon: String) {
        self.id = id
        self.status = status
        self.description = description
        self.icon = icon
    }
}

extension Weather: Decodable {
    private enum CodingKeys: String, CodingKey {
        case id
        case status = "main"
        case description
        case icon
    }
}
