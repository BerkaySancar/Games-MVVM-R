//
//  HorizontalGamesCell.swift
//  AppcentGameList
//
//  Created by Berkay Sancar on 6.03.2023.
//

import UIKit
import Kingfisher

final class HorizontalGamesCell: UICollectionViewCell {
    
    static let identifier = "HorizontalGamesCell"
    
    private lazy var gameImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        addSubview(gameImageView)
        gameImageView.clipsToBounds = true
        gameImageView.layer.cornerRadius = 8
        gameImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    internal func setData(imageURL: String) {
        if let url = URL(string: imageURL) {
            gameImageView.kf.setImage(with: url)
        }
    }
}
