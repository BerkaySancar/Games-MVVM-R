//
//  TopHorizontalCell.swift
//  Games
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
    
    private let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.tintColor = .white
        pageControl.currentPageIndicatorTintColor = .systemBlue
        pageControl.pageIndicatorTintColor = .white
        pageControl.backgroundColor = .systemGray6
        pageControl.layer.cornerRadius = 8
        return pageControl
    }()
    
    private var games: [Game] = [] {
        didSet {
            self.collectionView.reloadData()
            pageControl.numberOfPages = games.count
        }
    }
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: UI Configure
    private func configure() {
        contentView.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(HorizontalGamesCell.self, forCellWithReuseIdentifier: HorizontalGamesCell.identifier)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .systemBackground
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
        
        contentView.addSubview(pageControl)
        
        pageControl.snp.makeConstraints { make in
            make.centerX.equalTo(contentView.snp.centerX)
            make.bottom.equalTo(contentView.snp.bottom).offset(-10)
        }
    }
    
    // MARK: - Set Data
    internal func setData(games: [Game]) {
        self.games = games
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
extension TopHorizontalCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return games.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HorizontalGamesCell.identifier, for: indexPath) as? HorizontalGamesCell else { return UICollectionViewCell() }
        cell.setData(imageURL: games[indexPath.row].backgroundImage ?? "")
        cell.backgroundColor = .systemBackground
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: contentView.frame.width, height: contentView.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.pageControl.currentPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }
}
