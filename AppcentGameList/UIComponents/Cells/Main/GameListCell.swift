//
//  GameListCell.swift
//  AppcentGameList
//
//  Created by Berkay Sancar on 6.03.2023.
//

import UIKit

final class GameListCell: UICollectionViewCell {
    
    static let identifier = "GameListCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .orange
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
