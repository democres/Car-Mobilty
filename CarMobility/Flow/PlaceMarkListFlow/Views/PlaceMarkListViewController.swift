//
//  PlaceMarkListViewController.swift
//  CarMobility
//
//  Created by Jesus Alberto on 12/8/19.
//  Copyright © 2019 Jesus. All rights reserved.
//

import Foundation
import RxDataSources
import RxSwift
import RxCocoa

class PlaceMarkListViewController: UIViewController, UICollectionViewDelegate {
    
    @IBOutlet private weak var placeMarkCollectionView: UICollectionView! {
        didSet {
            placeMarkCollectionView.showsVerticalScrollIndicator = false
            placeMarkCollectionView.register(UINib(nibName: "PlaceMarkListCell", bundle: nil), forCellWithReuseIdentifier:"PlaceMarkListCell")
        }
    }
    
    @IBOutlet private weak var spinner: UIActivityIndicatorView! {
           didSet {
               spinner.hidesWhenStopped = true
           }
       }
       
    private let disposeBag = DisposeBag()
    private let model: PlaceMarkListViewModel
    private let insets: CGFloat = 10
    private let cellHegiht: CGFloat = 90
    
    init(with model: PlaceMarkListViewModel) {
        self.model = model
        super.init(nibName: String(describing: PlaceMarkListViewController.self), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        return nil
     }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addMapButtonNavigation()
        navigationItem.title = "Available cars"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
}

extension PlaceMarkListViewController {
    
    private func bind() {
        let config: PlaceMarkListIntput = (
            collectionView: placeMarkCollectionView.rx,
            navigation: navigationController,
            spinner: spinner
        )
        
        let output = model.setup(input:config)
        
        placeMarkCollectionView.rx
            .setDelegate(self)
            .disposed(by: disposeBag)
        
        output.section.disposed(by: disposeBag)
        
        output.selectCell
            .subscribe(onNext: { [weak self] mark in
                guard let self = self else { return }
                self.model.showMapView(with: [mark], navigation: self.navigationController)
            }).disposed(by: disposeBag)
        
    }
    
    @objc private func showAllCarsOnMap() {
        self.model.showMapView(navigation: self.navigationController)
    }
}

//MARK: - UICollectionViewDelegateFlowLayout

extension PlaceMarkListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.contentSize.width, height: cellHegiht)
        
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: insets, left: insets, bottom: insets , right: insets)
    }
}

// MARK: - Navigation Bar Buttons
extension PlaceMarkListViewController {
    func addMapButtonNavigation()  {
        let showMapButton = UIBarButtonItem()
        showMapButton.image = UIImage(named: "mapIconBar")?.withRenderingMode(.alwaysTemplate)
        showMapButton.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        showMapButton.action = #selector(showAllCarsOnMap)
        showMapButton.target = self
        
        self.navigationItem.rightBarButtonItem = showMapButton
        self.navigationItem.rightBarButtonItem?.tintColor = .red
    }
}
