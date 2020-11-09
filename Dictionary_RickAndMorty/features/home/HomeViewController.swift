//
//  HomeViewController.swift
//  Dictionary_RickAndMorty
//
//  Created by Rodrigo Martins on 05/11/20.
//

import UIKit

class HomeViewController: UIViewController {
    
    private struct Constant {
        static let CharacterCell = "CharacterCell"
    }
    
    private let viewModel: HomeViewModel
    private var data: [CharacterModel] = []
    private var isLoadingMore: Bool = false
    
    init(_ viewModel: HomeViewModel = HomeViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.alwaysBounceVertical = true
        collectionView.isHidden = true
        collectionView.register(CharacterCell.self, forCellWithReuseIdentifier: Constant.CharacterCell)
        return collectionView
    }()
    
    private lazy var refreshControl: UIRefreshControl = {
        let refresh = UIRefreshControl()
        refresh.attributedTitle = NSAttributedString(string: "Puxe para atualizar!")
        refresh.tintColor = UIColor(named: "primary")
        refresh.addTarget(self, action: #selector(loadData), for: .valueChanged)
        return refresh
    }()
    
    private lazy var emptyLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        label.textColor = UIColor(named: "primaryText")
        label.textAlignment = .center
        label.numberOfLines = 1
        label.text = "Nenhum dado encontrado!"
        label.isHidden = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(named: "background")
        setupUI()
        loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    private func setupUI(){
        self.view.addSubview(self.collectionView)
        self.collectionView.fillSuperview()
        self.collectionView.addSubview(self.refreshControl)
    }
    
    @objc private func loadData(){
        viewModel.fetchCharacters { (result) in
            self.data.removeAll()
            self.updateContentData(result: result)
            
            self.emptyLabel.isHidden = !self.data.isEmpty
            self.collectionView.isHidden = self.data.isEmpty
        }
    }
    
    private func loadMoreData(){
        viewModel.fetchNextPage { (result) in
            self.updateContentData(result: result)
        }
    }
    
    private func updateContentData(result: Result<[CharacterModel], NetworkError>){
        switch result {
        case .success(let model):
            self.data.append(contentsOf: model)
            break
        case .failure(let error):
            print(error)
            break
        }
        self.refreshControl.endRefreshing()
        self.collectionView.reloadData()
        
        self.isLoadingMore = false
    }
    
}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constant.CharacterCell, for: indexPath) as! CharacterCell
        cell.bind(model: data[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.navigationController?.pushViewController(DetailViewController(character: data[indexPath.item]),animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 24, height: 75)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        .init(top: 8, left: 12, bottom: 8, right: 12)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == data.count - 5 && !self.isLoadingMore {
            self.isLoadingMore = true
            self.loadMoreData()
        }
    }
    
}
