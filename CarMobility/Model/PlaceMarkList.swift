//
//  PlaceMarkList.swift
//  CarMobility
//
//  Created by Jesus Alberto on 12/8/19.
//  Copyright © 2019 Jesus. All rights reserved.
//

import Foundation

struct PlaceMarkList: Decodable {
    let placeMarks: [PlaceMark]
    
    enum CodingKeys: String, CodingKey {
        case placemarks
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        placeMarks = try container.decodeIfPresent([PlaceMark].self, forKey: .placemarks) ?? []
    }
}
