//
//  MainViewModelTests.swift
//  Games
//
//  Created by Berkay Sancar on 16.03.2023.
//

import Foundation
import XCTest
@testable import Games

final class MainViewModelTests: XCTestCase {
    
    private var viewModel: MainViewModel!
    private var view: MockMainView!
    private var router: MockMainRouter!
    private var api: MockGameAPI!
    
    override func setUp() {
        super.setUp()
        
        view = .init()
        router = .init()
        api = .init()
        viewModel = .init(delegate: view, router: router, gameAPI: api)
    }
    
    override func tearDown() {
        super.tearDown()
        
        view = nil
        router = nil
        api = nil
        viewModel = nil
    }
    
    func test_viewDidLoad_invokesRequiredMethods() {
        XCTAssertEqual(view.invokedPrepareCollectionView, 0)
        XCTAssertEqual(view.invokedPrepareAIV, 0)
        XCTAssertEqual(view.invokedSetViewBackgroundColor, 0)
        XCTAssertEqual(view.invokedPrepareSearchController, 0)
        XCTAssertEqual(api.invokedGetGameList, 0)
        
        viewModel.viewDidLoad()
        
        XCTAssertEqual(view.invokedPrepareCollectionView, 1)
        XCTAssertEqual(view.invokedPrepareAIV, 1)
        XCTAssertEqual(view.invokedSetViewBackgroundColor, 1)
        XCTAssertEqual(view.invokedPrepareSearchController, 1)
        XCTAssertEqual(api.invokedGetGameList, 1)
    }
   
//    func test_didSelectItemAt_WithAllIndex_RouteToDetail() {
//        XCTAssertEqual(router.invokedToDetailCount, 0)
//        XCTAssertNil(router.invokedID)
//        viewModel.games.append(Game(id: 5, name: "game1", metacritic: nil, backgroundImage: nil, released: nil))
//
//        viewModel.didSelectItemAt(index: 0)
//
//        XCTAssertEqual(router.invokedToDetailCount, 1)
//        XCTAssertEqual(router.invokedID, 5)
//    }
}
