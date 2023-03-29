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
    func prepareFavButton()
    func prepareScrollView()
    func prepareContentView()
    func prepareGameImageView()
    func prepareGameNameLabel()
    func prepareGameDescriptionLabel()
    func prepareActivityIndicatorView()
    func showGame(game: GameDetailResponse)
    func beginRefreshing()
    func endRefreshing()
}

protocol DetailViewModelInputs {
    func viewDidLoad()
    func viewDidAppear()
    func addFavorite()
    func checkFav() -> Bool
}

// MARK: - ViewModel
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
                self.game = game
                self.delegate?.showGame(game: game)
            case .failure(let error):
                print(error)
            }
        }
    }
}

// MARK: - View Model Inputs
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
        fetchGameDetail()
    }
    
    func viewDidAppear() {
        delegate?.prepareFavButton()
    }
   
    func addFavorite() {
        if let game, !checkFav() {
            coreDataManager.addFavorite(name: game.name, imageURL: game.backgroundImage ?? "")
        } else {
            if let index = coreDataManager.getFavorites()?.firstIndex(where: { $0.name == self.game?.name }) {
                coreDataManager.deleteFavorite(index: index)
            }
        }
    }
    
    func checkFav() -> Bool {
        if coreDataManager.getFavorites()?.contains(where: { $0.name == self.game?.name}) == true {
            return true
        } else {
             return false
        }
    }
}
