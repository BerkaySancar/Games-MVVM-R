//
//  MockMainView.swift
//  Games
//
//  Created by Berkay Sancar on 16.03.2023.
//

import Foundation
@testable import AppcentGameList

final class MockMainView: MainViewModelOutputs {
    
    var invokedSetViewBackgroundColor = 0
    func setViewBackgroundColor() {
        invokedSetViewBackgroundColor += 1
    }
    
    var invokedPrepareCollectionView = 0
    func prepareCollectionView() {
        invokedPrepareCollectionView += 1
    }
    
    var invokedPrepareAIV = 0
    func prepareActivtyIndicatorView() {
        invokedPrepareAIV += 1
    }
    
    var invokedPrepareSearchController = 0
    func prepareSearchController() {
        invokedPrepareSearchController += 1
    }
    
    var invokedBeginRefreshing = 0
    func beginRefreshing() {
        invokedBeginRefreshing += 1
    }
    
    var invokedEndRefreshing = 0
    func endRefreshing() {
        invokedEndRefreshing += 1
    }
    
    var invokedDataRefreshed = 0
    func dataRefreshed() {
        invokedDataRefreshed += 1
    }
    
    func onError(message: String) {
        
    }
}
