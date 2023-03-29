//
//  DetailViewController.swift
//  AppcentGameList
//
//  Created by Berkay Sancar on 6.03.2023.
//

import UIKit
import Kingfisher

final class DetailViewController: UIViewController {
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var gameImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private lazy var gameNameLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private lazy var gameDescriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var activityIndicatorView: UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView(style: .large)
        aiv.hidesWhenStopped = true
        aiv.color = .label
        return aiv
    }()
    
    internal var viewModel: DetailViewModelInputs!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        viewModel.viewDidAppear()
    }
    
    // MARK: - Actions
    @objc
    private func starButtonTapped(_ sender: UIBarButtonItem) {
        if sender.image == .init(systemName: "star.fill") {
            sender.image = .init(systemName: "star")
        } else {
            sender.image = .init(systemName: "star.fill")
        }
        
        viewModel.addFavorite()
    }
}

// MARK: - View Model Outputs
extension DetailViewController: DetailViewModelOutputs {
    func setNavTitle(title: String) {
        self.title = title
    }
    
    func setViewBackgroundColor() {
        view.backgroundColor = .white
    }
    
    func prepareFavButton() {
        let favButton = UIBarButtonItem(image: self.viewModel.checkFav() ? .init(systemName: "star.fill") : .init(systemName: "star"),
                                        style: .done,
                                        target: self,
                                        action: #selector(self.starButtonTapped))
        
        self.navigationItem.rightBarButtonItem = favButton
    }
    
    func prepareScrollView() {
        view.addSubview(scrollView)
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.left.right.bottom.equalTo(view)
        }
    }
        
    func prepareContentView() {
        scrollView.addSubview(contentView)
        
        contentView.snp.makeConstraints { make in
            make.top.bottom.equalTo(scrollView)
            make.left.right.equalTo(view)
        }
    }
    
    func prepareGameImageView() {
        contentView.addSubview(gameImageView)
        
        gameImageView.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top)
            make.left.right.equalTo(contentView)
            make.height.equalTo(300)
        }
    }
    
    func prepareGameNameLabel() {
        contentView.addSubview(gameNameLabel)
        
        gameNameLabel.snp.makeConstraints { make in
            make.top.equalTo(gameImageView.snp.bottom).offset(20)
            make.centerX.equalTo(scrollView)
        }
    }
    
    func prepareGameDescriptionLabel() {
        contentView.addSubview(gameDescriptionLabel)
        
        gameDescriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(gameNameLabel.snp.bottom).offset(20)
            make.left.right.equalToSuperview().inset(16)
            make.bottom.equalTo(contentView).offset(-20)
        }
    }
    
    func prepareActivityIndicatorView() {
        view.addSubview(activityIndicatorView)
        activityIndicatorView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
    
    func showGame(game: GameDetailResponse) {
        self.gameNameLabel.text = game.name
        self.gameDescriptionLabel.text = game.description ?? ""
        if let url = URL(string: game.backgroundImage ?? "") {
            self.gameImageView.kf.setImage(with: url)
        }
    }
    
    func beginRefreshing() {
        activityIndicatorView.startAnimating()
    }
    
    func endRefreshing() {
        activityIndicatorView.stopAnimating()
    }
}
