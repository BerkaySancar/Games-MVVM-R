//
//  GameListCell.swift
//  AppcentGameList
//
//  Created by Berkay Sancar on 6.03.2023.
//

import UIKit
import Kingfisher

final class GameListCell: UICollectionViewCell {
    
    static let identifier = "GameListCell"
    
    private lazy var gameImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private lazy var gameName: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private lazy var gameReleased: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private lazy var gameMetacritics: UILabel = {
        let label = UILabel()
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        contentView.addSubview(gameImageView)
        contentView.addSubview(gameName)
        contentView.addSubview(gameReleased)
        contentView.addSubview(gameMetacritics)
        
        gameImageView.clipsToBounds = true
        gameImageView.layer.cornerRadius = 8
        
        gameImageView.snp.makeConstraints { make in
            make.width.height.equalTo(116)
            make.left.equalTo(contentView.snp.left).offset(16)
            make.top.equalTo(contentView.snp.top).offset(16)
        }
        
        gameName.snp.makeConstraints { make in
            make.left.equalTo(gameImageView.snp.right).offset(16)
            make.right.equalTo(contentView.snp.right).offset(-16)
            make.top.equalTo(gameImageView)
        }
        
        gameReleased.snp.makeConstraints { make in
            make.left.equalTo(gameName)
            make.top.equalTo(gameName.snp.bottom).offset(8)
        }
        
        gameMetacritics.snp.makeConstraints { make in
            make.left.equalTo(gameReleased)
            make.top.equalTo(gameReleased.snp.bottom).offset(8)
        }
    }
    
    internal func setData(game: Game) {
        if let url = URL(string: game.backgroundImage ?? "") {
            gameImageView.kf.setImage(with: url)
        }
        gameName.text = "Name: \(game.name)"
        gameReleased.text = "Released: \(game.released ?? "")"
        gameMetacritics.text = "Metacritics: \(game.metacritic ?? 0)"
    }
}
