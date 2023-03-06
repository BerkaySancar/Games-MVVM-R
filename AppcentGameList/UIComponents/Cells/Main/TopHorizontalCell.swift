//
//  TopHorizontalCell.swift
//  AppcentGameList
//
//  Created by Berkay Sancar on 6.03.2023.
//

import UIKit

final class TopHorizontalCell: UICollectionViewCell {
    
    static let identifier = "TopHorizontalCell"
    
    private lazy var collectionView: UICollectionView = {
        let layout = SnappingLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.decelerationRate = .fast
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        contentView.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(HorizontalGamesCell.self, forCellWithReuseIdentifier: HorizontalGamesCell.identifier)
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

extension TopHorizontalCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HorizontalGamesCell.identifier, for: indexPath) as? HorizontalGamesCell else { return UICollectionViewCell() }
        let arr = ["asdasd", "asda","qweqwe"]
        cell.label.text = arr[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: contentView.frame.width, height: contentView.frame.height)
    }
}
