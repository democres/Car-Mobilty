//
//  PlaceMark.swift
//  CarMobility
//
//  Created by Jesus Alberto on 12/8/19.
//  Copyright © 2019 Jesus. All rights reserved.
//

import Foundation
import CoreLocation

class PlaceMark: Decodable {
    
    let address: String
    let engineType: String
    let exterior: String
    let fuel: Int
    let interior: String
    let name: String
    let vin: String
    var coordinates: CLLocationCoordinate2D
    private let coordinatesArray: [Double]
    
    enum CodingKeys: String, CodingKey {
        case address
        case engineType
        case exterior
        case fuel
        case interior
        case name
        case vin
        case coordinates
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        address = try container.decodeIfPresent(String.self, forKey: .address) ?? ""
        engineType = try container.decodeIfPresent(String.self, forKey: .engineType) ?? ""
        fuel = try container.decodeIfPresent(Int.self, forKey: .fuel) ?? 0
        exterior = try container.decodeIfPresent(String.self, forKey: .exterior) ?? ""
        interior = try container.decodeIfPresent(String.self, forKey: .interior) ?? ""
        name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        vin = try container.decodeIfPresent(String.self, forKey: .engineType) ?? ""
        coordinatesArray = try container.decodeIfPresent([Double].self, forKey: .coordinates) ?? []
        coordinates = CLLocationCoordinate2D(latitude: coordinatesArray[1], longitude: coordinatesArray[0])
    }
}


struct Coordinates: Decodable {
    
    var latitude: Double = 0.0
    var longitude: Double = 0.0
    
    enum CodingKeys: String, CodingKey {
        case latitude
        case longitude
    }
}
