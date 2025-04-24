//
//  LocationSpot.swift
//  SafeSpot
//
//  Created by Thomas on 4/24/25.
//

import Foundation

// parsing data from api

struct LocationSpot: Codable {
    let features: [Features]
}

struct Features: Codable {
    let properties: Properties
    let geometry: Geometry
}

struct Properties: Codable {
    let name: String

}

struct Geometry: Codable {
    let coordinates: [Double]
}
