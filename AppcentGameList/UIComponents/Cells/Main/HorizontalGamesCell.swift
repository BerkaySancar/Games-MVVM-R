//
//  HorizontalGamesCell.swift
//  AppcentGameList
//
//  Created by Berkay Sancar on 6.03.2023.
//

import UIKit

final class HorizontalGamesCell: UICollectionViewCell {
    
    static let identifier = "HorizontalGamesCell"
    
    lazy var label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(label)
        label.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.height.equalTo(200)
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
