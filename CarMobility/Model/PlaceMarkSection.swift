//
//  PlaceMarkSection.swift
//  CarMobility
//
//  Created by Jesus Alberto on 12/8/19.
//  Copyright © 2019 Jesus. All rights reserved.
//

import RxSwift
import RxDataSources

struct PlaceMarkListSection {
    var header: String
    var items: [PlaceMark]
}

extension PlaceMarkListSection: SectionModelType {
    
    init(original: PlaceMarkListSection, items: [PlaceMark]) {
        self = original
        self.items =  items
    }
}

