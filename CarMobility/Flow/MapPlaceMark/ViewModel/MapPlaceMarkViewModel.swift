//
//  MapPlaceMarkViewModel.swift
//  CarMobility
//
//  Created by Jesus Alberto on 12/8/19.
//  Copyright © 2019 Jesus. All rights reserved.
//

import Foundation
import GoogleMaps

class MapPlaceMarkViewModel {
    
    init() {}
    
    func setupCars(with marks: [PlaceMark], map: GMSMapView) {
        var bounds = GMSCoordinateBounds()
        for car in marks {
            let marker: GMSMarker = GMSMarker()
            marker.icon = setIconMapImage(with: UIImage(named: "mapCar"), size: CGSize(width: 30, height: 30) )
            marker.position = CLLocationCoordinate2DMake(car.coordinates.latitude, car.coordinates.longitude)
            bounds = bounds.includingCoordinate(marker.position)
            marker.title = car.address
            marker.map = map
        }
        let camera: GMSCameraPosition = map.camera(for: bounds, insets: .zero) ?? GMSCameraPosition()
        map.animate(to: camera)
    }
    
    private func setIconMapImage(with image: UIImage?, size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        image?.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
}
