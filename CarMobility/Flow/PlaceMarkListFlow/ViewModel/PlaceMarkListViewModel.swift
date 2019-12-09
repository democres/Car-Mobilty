//
//  PlaceMarkListViewModel.swift
//  CarMobility
//
//  Created by Jesus Alberto on 12/8/19.
//  Copyright © 2019 Jesus. All rights reserved.
//

import Foundation
import Moya
import RxSwift
import RxCocoa
import RxDataSources

typealias PlaceMarkListOutput = (
    section: Disposable,
    selectCell: Observable<PlaceMark>
)

typealias PlaceMarkListIntput = (
    collectionView: Reactive<UICollectionView>,
    navigation: UINavigationController?,
    spinner: UIActivityIndicatorView
)

enum PlaceMarkSelectionType {
    case showAll(marks: [PlaceMark], nav: UINavigationController?)
    case showDetailed(placeMark: PlaceMark, nav: UINavigationController?)
}

final class PlaceMarkListViewModel {
    
    private let provider: MoyaProvider<PlaceMarkAPI>
    private let disposeBag = DisposeBag()
    private var marks: [PlaceMark] = []
    
    init(with provider: MoyaProvider<PlaceMarkAPI>) {
        self.provider = provider
    }
    
    func setup(input: PlaceMarkListIntput) -> PlaceMarkListOutput {
        
        input.spinner.startAnimating()
        
        let placesMarks = provider.rx.request(.placeMarkList)
            .do(onSuccess: {  _ in
                input.spinner.stopAnimating()
            }, onError: { [weak self] _ in
                input.spinner.stopAnimating()
                self?.showOfflineAlert(with: input.navigation)
            })
            .asObservable()
            .map(PlaceMarkList.self)
            .retry(3)
        
        let dataSource = createDataSource()
        
        let section = placesMarks.asObservable()
            .map(setPlaceMarks)
            .bind(to: input.collectionView.items(dataSource: dataSource))
        
        let selectCell = input.collectionView.modelSelected(PlaceMark.self)
            .asObservable()
        
        return (section: section,
                selectCell: selectCell)
    }
    
    func showMapView(with marks: [PlaceMark]? = nil, navigation: UINavigationController?) {
        if let mark =  marks  {
            showView(with: mark, navigation: navigation)
        } else {
            showView(with:self.marks, navigation: navigation)
        }
    }
}

extension PlaceMarkListViewModel {
    
    private func showView(with marks: [PlaceMark], navigation: UINavigationController?) {
        let viewModel = MapPlaceMarkViewModel()
        let mapVC = MapPlaceMarkViewController(with: marks, viewModel: viewModel)
        navigation?.pushFadeAnimation(viewController: mapVC)
    }
    
    private func setPlaceMarks(marks: PlaceMarkList) -> [PlaceMarkListSection] {
        var results: [PlaceMarkListSection] = []
        self.marks = marks.placeMarks
        results.append(PlaceMarkListSection (header: "", items: self.marks))
        return results
    }
    
    private func createDataSource() -> RxCollectionViewSectionedReloadDataSource<PlaceMarkListSection> {
        let dataSource = RxCollectionViewSectionedReloadDataSource<PlaceMarkListSection>(configureCell:{ (dataSource: CollectionViewSectionedDataSource<PlaceMarkListSection>, collectionView: UICollectionView, indexPath: IndexPath, item: PlaceMark) in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlaceMarkListCell", for: indexPath) as? PlaceMarkListCell else {
                return UICollectionViewCell()
            }
            cell.buildCell(for: item)
            return cell
        })
        return dataSource
    }
    
    private func showOfflineAlert(with navigation: UINavigationController?) {
        let alertController = UIAlertController(title: NSLocalizedString("Error", comment: "Error"), message: NSLocalizedString("You are offline", comment: "You are offline"), preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alertController.addAction(action)
        if let navigation = navigation?.visibleViewController {
            if !(navigation.isKind(of: UIAlertController.self)) {
                OperationQueue.main.addOperation {
                    navigation.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
}
