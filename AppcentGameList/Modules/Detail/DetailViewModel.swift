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
    func showGame(game: GameDetailResponse)
    func beginRefreshing()
    func endRefreshing()
}

protocol DetailViewModelInputs {
    func viewDidLoad()
}

final class DetailViewModel {
    private weak var delegate: DetailViewModelOutputs?
    private let gameAPI: GameAPIProtocol
    private let gameID: Int
    
    init(delegate: DetailViewModelOutputs, gameAPI: GameAPIProtocol, gameID: Int) {
        self.delegate = delegate
        self.gameAPI = gameAPI
        self.gameID = gameID
    }
    
    func fetchGameDetail() {
        delegate?.beginRefreshing()
        gameAPI.getGameDetail(id: self.gameID) { [weak self] results in
            guard let self else { return }
            self.delegate?.endRefreshing()
            switch results {
            case .success(let game):
                self.delegate?.showGame(game: game)
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
        fetchGameDetail()
    }
}
