//
//  CarMobilityTests.swift
//  CarMobilityTests
//
//  Created by Jesus Alberto on 12/8/19.
//  Copyright © 2019 Jesus. All rights reserved.
//

import Foundation
import XCTest
import RxSwift
import Moya
@testable import CarMobility

class PlaceMarkerTest: XCTestCase {
    
    private var viewModel: PlaceMarkListViewModel?
    private var provider = MoyaProvider<PlaceMarkAPI>.init(stubClosure: MoyaProvider<PlaceMarkAPI>.immediatelyStub)
    private let disposeBag = DisposeBag()
    
    override func setUp() {
        super.setUp()
        viewModel =  PlaceMarkListViewModel(with: provider)
    }
    
    func test_placeMarkList_ShouldBeEqualTo() {
        var marks: [PlaceMark] = []
        let expectedCount: Int = 423
        provider = MoyaProvider<PlaceMarkAPI>.init(stubClosure: MoyaProvider<PlaceMarkAPI>.immediatelyStub)
        let expectation =  self.expectation(description: "start fetching cars")
        provider.rx.request(.placeMarkList)
            .map(PlaceMarkList.self)
            .asObservable()
            .subscribe(onNext: { list in
                marks = list.placeMarks
                expectation.fulfill()
            }).disposed(by: disposeBag)
        
        waitForExpectations(timeout: 5) { error in
            if (error != nil) {
                XCTFail("sample data fail")
            }
        }
        XCTAssertEqual(marks.count, expectedCount)
    }
}
