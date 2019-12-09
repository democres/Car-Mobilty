//
//  MapPlaceMarkViewController.swift
//  CarMobility
//
//  Created by Jesus Alberto on 12/8/19.
//  Copyright © 2019 Jesus. All rights reserved.
//

import Foundation
import GoogleMaps
import CoreLocation

class MapPlaceMarkViewController: UIViewController {
    
    @IBOutlet var mapView: GMSMapView! {
        didSet {
            mapView.animate(toZoom: initalZoom)
            mapView.isMyLocationEnabled = true
            mapView.settings.compassButton = true
        }
    }
    
    private let placeMarks: [PlaceMark]
    private let initalZoom: Float = 8
    private let cityCenter: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 53.5584902,longitude: 9.7877401)
    private let viewModel: MapPlaceMarkViewModel
    
    init(with marks:[PlaceMark], viewModel: MapPlaceMarkViewModel) {
        self.placeMarks = marks
        self.viewModel = viewModel
        super.init(nibName: String(describing: MapPlaceMarkViewController.self), bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setMap()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigation()
    }
}

extension MapPlaceMarkViewController {
    
    private func setMap() {
        viewModel.setupCars(with: placeMarks, map: mapView)
    }
    
    private func setNavigation() {
        if placeMarks.count <= 1 {
            navigationItem.title = placeMarks[0].address
        } else {
            navigationItem.title = "Avaliable cars"
        }
        navigationItem.leftBarButtonItem?.title = ""
        navigationController?.navigationBar.titleTextAttributes =
                       [NSAttributedString.Key.foregroundColor: UIColor.charcoal(),
                        NSAttributedString.Key.font: UIFont.coordinatesFont(size: 14)]
    }
}
