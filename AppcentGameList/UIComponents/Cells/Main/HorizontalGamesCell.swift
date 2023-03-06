//
//  HorizontalGamesCell.swift
//  AppcentGameList
//
//  Created by Berkay Sancar on 6.03.2023.
//

import UIKit

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
        gameImageView.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.height.equalTo(200)
            make.edges.equalToSuperview()
        }
    }
    
    internal func setData(imageURL: String) {
        
    }
}
