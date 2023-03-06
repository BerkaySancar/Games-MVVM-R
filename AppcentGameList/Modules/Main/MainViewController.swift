//
//  ViewController.swift
//  AppcentGameList
//
//  Created by Berkay Sancar on 6.03.2023.
//

import UIKit

final class MainViewController: UIViewController {
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
    
    internal var viewModel: MainViewModelInputs!

// MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
       
        viewModel.viewDidLoad()
    }
}

// MARK: - UICollectionView Delegate & Data Source & FlowLayout
extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.numberOfSection()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItemsIn(section: section)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopHorizontalCell.identifier, for: indexPath) as? TopHorizontalCell else { return UICollectionViewCell() }
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GameListCell.identifier, for: indexPath) as? GameListCell else { return UICollectionViewCell() }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return viewModel.sizeForItemAt(indexPath: indexPath)
    }
}

// MARK: - View Model Outputs
extension MainViewController: MainViewModelOutputs {
    
    func setNavTitle(title: String) {
        self.title = title
    }
    
    func prepareCollectionView() {
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(TopHorizontalCell.self, forCellWithReuseIdentifier: TopHorizontalCell.identifier)
        collectionView.register(GameListCell.self, forCellWithReuseIdentifier: GameListCell.identifier)
    }
    
    func setUpConstraints() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func beginRefreshing() {
        
    }
    
    func endRefreshing() {
        
    }
    
    func dataRefreshed() {
        self.collectionView.reloadData()
    }
}
