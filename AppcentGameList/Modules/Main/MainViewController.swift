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
    
    private lazy var activityIndicatorView: UIActivityIndicatorView = {
         let aiv = UIActivityIndicatorView(style: .large)
         aiv.hidesWhenStopped = true
         aiv.color = .label
         return aiv
     }()
    
    private lazy var searchController: UISearchController = {
        let searchVC = UISearchController(searchResultsController: nil)
           return searchVC
       }()
    
    private lazy var refreshControl: UIRefreshControl = {
        let refControl = UIRefreshControl()
        refControl.addTarget(self, action: #selector(refreshCollectionView), for: UIControl.Event.valueChanged)
        return refControl
    }()
    
    internal var viewModel: MainViewModelInputs!

// MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
       
        viewModel.viewDidLoad()
    }
    
// MARK: - Actions
    
    @objc
    private func refreshCollectionView() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.viewModel.refreshCollectionView()
            self.refreshControl.endRefreshing()
        }
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
            if !viewModel.showSearchStatus() {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopHorizontalCell.identifier, for: indexPath) as? TopHorizontalCell else { return UICollectionViewCell() }
                cell.setData(games: viewModel.topHorizontalGames())
                return cell
            } else {
                return collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
            }
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GameListCell.identifier, for: indexPath) as? GameListCell else { return UICollectionViewCell() }
            cell.setData(game: viewModel.cellForItemAt(item: indexPath.item))
            cell.layer.borderWidth = 2
            cell.layer.borderColor = UIColor.black.cgColor
            cell.layer.cornerRadius = 8
            
            // Pagination
            viewModel.loadMoreGames(indexPath: indexPath)
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return viewModel.sizeForItemAt(indexPath: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 16, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        viewModel.didSelectItemAt(index: indexPath.item)
    }
}

// MARK: - View Model Outputs
extension MainViewController: MainViewModelOutputs {
    
    func setViewBackgroundColor() {
        view.backgroundColor = .white
    }
    
    func prepareCollectionView() {
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        collectionView.register(TopHorizontalCell.self, forCellWithReuseIdentifier: TopHorizontalCell.identifier)
        collectionView.register(GameListCell.self, forCellWithReuseIdentifier: GameListCell.identifier)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.keyboardDismissMode = .onDrag
        collectionView.refreshControl = self.refreshControl
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func prepareActivtyIndicatorView() {
        view.addSubview(activityIndicatorView)
        activityIndicatorView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
    
    func prepareSearchController() {
        self.navigationItem.searchController = self.searchController
        self.navigationItem.hidesSearchBarWhenScrolling = true
        self.searchController.searchBar.delegate = self
        self.searchController.searchBar.placeholder = "Search"
    }
    
    func beginRefreshing() {
        activityIndicatorView.startAnimating()
    }
    
    func endRefreshing() {
        activityIndicatorView.stopAnimating()
    }
    
    func dataRefreshed() {
        self.collectionView.reloadData()
    }
    
    func onError(message: String) {
        self.showErrorAlert(message: message)
    }
}

// MARK: - SearchBar Delegate
extension MainViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.searchTextDidChange(text: searchText)
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        viewModel.toggleSearchStatus()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        viewModel.toggleSearchStatus()
    }
}
