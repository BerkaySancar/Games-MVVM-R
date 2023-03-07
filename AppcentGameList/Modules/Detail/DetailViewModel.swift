//
//  DetailViewModel.swift
//  AppcentGameList
//
//  Created by Berkay Sancar on 6.03.2023.
//

import Foundation

protocol DetailViewModelOutputs: AnyObject {
    func setNavTitle(title: String)
    func setViewBackgroundColor()
    func prepareScrollView()
    func prepareContentView()
    func prepareGameImageView()
    func prepareGameNameLabel()
    func prepareGameDescriptionLabel()
    func prepareActivityIndicatorView()
    func prepareFavoritesButton()
    func showGame(game: GameDetailResponse)
    func beginRefreshing()
    func endRefreshing()
}

protocol DetailViewModelInputs {
    func viewDidLoad()
    func addFavorite()
    func checkFav() -> Bool
}

final class DetailViewModel {
    
    private var game: GameDetailResponse?
    private weak var delegate: DetailViewModelOutputs?
    private let gameAPI: GameAPIProtocol
    private let gameID: Int
    private let coreDataManager: CoreDataManager
    
    init(delegate: DetailViewModelOutputs, gameAPI: GameAPIProtocol, gameID: Int, coreDataManager: CoreDataManager) {
        self.delegate = delegate
        self.gameAPI = gameAPI
        self.gameID = gameID
        self.coreDataManager = coreDataManager
    }
    
    private func fetchGameDetail() {
        delegate?.beginRefreshing()
        gameAPI.getGameDetail(id: self.gameID) { [weak self] results in
            guard let self else { return }
            self.delegate?.endRefreshing()
            switch results {
            case .success(let game):
                self.delegate?.showGame(game: game)
                self.game = game
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension DetailViewModel: DetailViewModelInputs {
  
    func viewDidLoad() {
        delegate?.setNavTitle(title: "Detail")
        delegate?.setViewBackgroundColor()
        delegate?.prepareScrollView()
        delegate?.prepareContentView()
        delegate?.prepareGameImageView()
        delegate?.prepareGameNameLabel()
        delegate?.prepareGameDescriptionLabel()
        delegate?.prepareActivityIndicatorView()
        delegate?.prepareFavoritesButton()
        fetchGameDetail()
    }
    
    func addFavorite() {
        if let game, !checkFav() {
            coreDataManager.addFavorite(name: game.name, imageURL: game.backgroundImage ?? "")
        }
    }
    
    func checkFav() -> Bool {
        if coreDataManager.getFavorites()?.contains(where: { $0.name == game?.name }) == false {
            return false
        } else {
            return true
        }
    }
}
