//
//  PlaceMarkListCell.swift
//  CarMobility
//
//  Created by Jesus Alberto on 12/8/19.
//  Copyright © 2019 Jesus. All rights reserved.
//

import UIKit
import Foundation

class PlaceMarkListCell: UICollectionViewCell {
    
    @IBOutlet weak var carIconImage: UIImageView! {
        didSet {
            carIconImage.contentMode = .scaleAspectFit
            carIconImage.image = UIImage(named: "carIcon")
        }
    }
    
    @IBOutlet weak var addressLabel: UILabel! {
        didSet {
            addressLabel.font = UIFont.coordinatesFont(size: 14)
            addressLabel.textColor = UIColor.charcoal()
        }
    }
    @IBOutlet weak var carTypeLabel: UILabel! {
        didSet {
            carTypeLabel.font = UIFont.coordinatesFont(size: 10)
            carTypeLabel.textColor = UIColor.charcoal()
        }
    }
    @IBOutlet weak var coordinatesLabel: UILabel! {
        didSet {
            coordinatesLabel.font = UIFont.coordinatesFont()
            coordinatesLabel.textColor = UIColor.purpleBrown()
        }
    }
    
    @IBOutlet weak var exteriorStatusLabel: UILabel! {
        didSet {
        exteriorStatusLabel.font = UIFont.coordinatesFont(size: 8)
        }
    }
    @IBOutlet weak var interiorStatusLabel: UILabel! {
        didSet {
            interiorStatusLabel.font = UIFont.coordinatesFont(size: 8)
        }
    }
    
    enum cartStatus: String {
        case good = "GOOD"
        case unacceptable = "UNACCEPTABLE"
    }
    
    private var placeMark: PlaceMark?
    
    func buildCell(for mark: PlaceMark) {
        self.placeMark = mark
        setStyleCarLabel(for: mark)
        coordinatesLabel.text = "(lat: " + String(describing: mark.coordinates.latitude) + ", long:" + String(describing: mark.coordinates.longitude) + ")"
        setSytles()
    }
}

extension PlaceMarkListCell {
    
    private func setSytles() {
        self.contentView.layer.cornerRadius = 2.0
        self.contentView.layer.borderWidth = 2.0
        self.contentView.layer.borderColor = UIColor.black.cgColor
        self.contentView.layer.masksToBounds = true
    }
    
    private func setStyleCarLabel(for placeMark: PlaceMark) {
        addressLabel.text = placeMark.address
        carTypeLabel.text = placeMark.name
        
        switch placeMark.interior {
        case cartStatus.good.rawValue:
            interiorStatusLabel.text = "Interior: Good"
            interiorStatusLabel.textColor = UIColor.semaphoreGreen()
            interiorStatusLabel.alpha = 0.8
        default:
            interiorStatusLabel.text = "Interior: Unacceptable"
            interiorStatusLabel.textColor = UIColor.semaphoreRed()
            interiorStatusLabel.alpha = 0.8
        }
        
        switch placeMark.exterior {
        case cartStatus.good.rawValue:
            exteriorStatusLabel.text = "Exterior: Good"
            exteriorStatusLabel.textColor = UIColor.semaphoreGreen()
            exteriorStatusLabel.alpha = 0.8
        default:
            exteriorStatusLabel.text = "Exterior: Unacceptable"
            exteriorStatusLabel.textColor = UIColor.semaphoreRed()
            exteriorStatusLabel.alpha = 0.8
        }
    }
}
