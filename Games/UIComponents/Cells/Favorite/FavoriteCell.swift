//
//  FavoriteCell.swift
//  Games
//
//  Created by Berkay Sancar on 7.03.2023.
//

import UIKit
import Kingfisher

final class FavoriteCell: UITableViewCell {
    
    static let identifier = "FavoriteCell"
    
    private lazy var gameImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private lazy var gameName: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        contentView.addSubview(gameImageView)
        contentView.addSubview(gameName)
        
        gameImageView.clipsToBounds = true
        gameImageView.layer.cornerRadius = 8
        
        gameImageView.snp.makeConstraints { make in
            make.width.height.equalTo(72)
            make.left.equalTo(contentView.snp.left).offset(16)
            make.centerY.equalTo(contentView.snp.centerY)
        }
        
        gameName.snp.makeConstraints { make in
            make.left.equalTo(gameImageView.snp.right).offset(16)
            make.centerY.equalTo(gameImageView)
        }
    }
    
    internal func setData(game: Favorite?) {
        gameName.text = game?.name
        if let url = URL(string: game?.imageURL ?? "") {
            gameImageView.kf.setImage(with: url)
        }
    }
}
