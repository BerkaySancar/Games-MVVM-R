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
    
    private lazy var favButton: UIButton = {
        let button = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: 32)
        button.setImage(UIImage(systemName: "star", withConfiguration: config), for: .normal)
        button.setImage(UIImage(systemName: "star.fill", withConfiguration: config), for: .selected)
        button.clipsToBounds = true
        button.tintColor = .systemYellow
        button.backgroundColor = .white
        button.layer.cornerRadius = 8
        return button
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        favButton.isSelected = viewModel.checkFav()
    }
    
// MARK: - Actions
    @objc
    private func favButtonTapped(_ sender: UIButton) {
        sender.isSelected.toggle()
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
    
    func prepareFavoritesButton() {
        contentView.addSubview(favButton)
        favButton.addTarget(self, action: #selector(favButtonTapped), for: .touchUpInside)
        
        favButton.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(16)
            make.top.equalTo(contentView.snp.top).offset(20)
        }
    }
    
    func showGame(game: GameDetailResponse) {
        self.gameNameLabel.text = game.name
        self.gameDescriptionLabel.text = game.description ?? ""
        if let url = URL(string: game.backgroundImage ?? "") {
            self.gameImageView.kf.setImage(with: url)
        }
        
        favButton.isSelected = viewModel.checkFav()
    }
    
    func beginRefreshing() {
        activityIndicatorView.startAnimating()
    }
    
    func endRefreshing() {
        activityIndicatorView.stopAnimating()
    }
}
