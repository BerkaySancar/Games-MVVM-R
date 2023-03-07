//
//  MainViewModel.swift
//  AppcentGameList
//
//  Created by Berkay Sancar on 6.03.2023.
//

import Foundation

protocol MainViewModelOutputs: AnyObject {
    func setViewBackgroundColor()
    func prepareCollectionView()
    func prepareActivtyIndicatorView()
    func setUpConstraints()
    func beginRefreshing()
    func endRefreshing()
    func dataRefreshed()
}

protocol MainViewModelInputs {
    func viewDidLoad()
    func numberOfSection() -> Int
    func numberOfItemsIn(section: Int) -> Int
    func sizeForItemAt(indexPath: IndexPath) -> CGSize
    func cellForItemAt(item: Int) -> Game
    func didSelectItemAt(index: Int)
    func topHorizontalGames() -> [Game]
    func loadMoreGames(indexPath: IndexPath)
}

// MARK: - View Model
final class MainViewModel {
    private weak var delegate: MainViewModelOutputs?
    private let router: MainRouterProtocol
    private let gameAPI: GameAPIProtocol
    
    private var games: [Game] = []
    private var isPaginating = false
    private var page = 1
    
    init(delegate: MainViewModelOutputs, router: MainRouterProtocol, gameAPI: GameAPIProtocol) {
        self.delegate = delegate
        self.router = router
        self.gameAPI = gameAPI
    }
    
    private func fetchGames() {
        delegate?.beginRefreshing()
        gameAPI.getGameList(page: self.page) { [weak self] results in
            guard let self else { return }
            self.delegate?.endRefreshing()
            switch results {
            case .success(let games):
                DispatchQueue.main.async {
                    self.games.append(contentsOf: games)
                    self.delegate?.dataRefreshed()
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
        delegate?.prepareActivtyIndicatorView()
        delegate?.setUpConstraints()
        delegate?.setViewBackgroundColor()
        fetchGames()
    }
    
    func numberOfSection() -> Int {
        return 2
    }
    
    func numberOfItemsIn(section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return self.games.count
        }
    }

    func sizeForItemAt(indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            return .init(width: ScreenBounds.width - 32, height: 260)
        } else {
            return .init(width: ScreenBounds.width - 32, height: 144)
        }
    }
    
    func cellForItemAt(item: Int) -> Game {
        return self.games[item]
    }
    
    func didSelectItemAt(index: Int) {
        let selectedGameID = self.games[index].id
        self.router.toDetail(id: selectedGameID)
    }
    
    func topHorizontalGames() -> [Game] {
        let firstFiveGames = Array(games.prefix(5))
        return firstFiveGames
    }
    
    func loadMoreGames(indexPath: IndexPath) {
        if indexPath.item == self.games.count - 1, !self.isPaginating {
            self.isPaginating = true
            self.page += 1
            self.fetchGames()
            self.isPaginating = false
        }
    }
}
