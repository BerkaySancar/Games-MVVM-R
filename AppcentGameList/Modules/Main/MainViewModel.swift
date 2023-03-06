//
//  MainViewModel.swift
//  AppcentGameList
//
//  Created by Berkay Sancar on 6.03.2023.
//

import Foundation

protocol MainViewModelOutputs: AnyObject {
    func prepareCollectionView()
    func setUpConstraints()
}

protocol MainViewModelInputs {
    func viewDidLoad()
    func numberOfSection() -> Int
    func numberOfItemsIn(section: Int) -> Int
    func sizeForItemAt(indexPath: IndexPath) -> CGSize
}

// MARK: - View Model
final class MainViewModel {
    private weak var delegate: MainViewModelOutputs?
    private let router: MainRouterProtocol
    private let gameAPI: GameAPIProtocol
    
    private var games: [Game] = []
    
    init(delegate: MainViewModelOutputs, router: MainRouterProtocol, gameAPI: GameAPIProtocol) {
        self.delegate = delegate
        self.router = router
        self.gameAPI = gameAPI
    }
    
    private func fetchGames() {
        gameAPI.getGameList(page: 1) { [weak self] results in
            guard let self else { return }
            switch results {
            case .success(let games):
                DispatchQueue.main.async {
                    self.games = games
                }
            case .failure(let error):
                print(error)
            }
            
        }
    }
}

// MARK: - Inputs
extension MainViewModel: MainViewModelInputs {
    
    func viewDidLoad() {
        delegate?.prepareCollectionView()
        delegate?.setUpConstraints()
        fetchGames()
    }
    
    func numberOfSection() -> Int {
        return 2
    }
    
    func numberOfItemsIn(section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return 5
        }
    }

    func sizeForItemAt(indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            return .init(width: ScreenBounds.width, height: 300)
        } else {
            return .init(width: ScreenBounds.width, height: 200)
        }
    }
}
