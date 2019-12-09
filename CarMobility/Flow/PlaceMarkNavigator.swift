//
//  PlaceMarkNavigator.swift
//  CarMobility
//
//  Created by Jesus Alberto on 12/8/19.
//  Copyright © 2019 Jesus. All rights reserved.
//

import Foundation
import Moya
import RxSwift

final class PlaceMarkNavigator {
    
    let provider = MoyaProvider<PlaceMarkAPI>()
    var navigationController: UINavigationController?
    private let disposeBag = DisposeBag()
    
    init(with window: UIWindow) {
        let viewModel = PlaceMarkListViewModel(with: provider)
        let vc = PlaceMarkListViewController(with: viewModel)
        navigationController = UINavigationController(rootViewController: vc)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
    }
}
