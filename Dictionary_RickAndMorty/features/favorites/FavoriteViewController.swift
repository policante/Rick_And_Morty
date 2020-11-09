//
//  FavoriteViewController.swift
//  Dictionary_RickAndMorty
//
//  Created by Rodrigo Martins on 06/11/20.
//

import UIKit

class FavoriteViewController: UIViewController {
    
    private var data: [CharacterModel] = []
    private var viewModel: FavoriteViewModel
    
    private struct Constant {
        static let CharacterCell = "CharacterCell"
    }
    
    init(_ viewModel: FavoriteViewModel = FavoriteViewModel()) {
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        
        self.viewModel.loadFavorites { (result) in
            self.data.removeAll()
            self.data.append(contentsOf: result)
            self.collectionView.reloadData()
            
            self.emptyLabel.isHidden = !self.data.isEmpty
            self.collectionView.isHidden = self.data.isEmpty
        }
    }
    
    private func setupUI(){
        self.view.addSubview(self.collectionView)
        self.view.addSubview(self.emptyLabel)
        self.collectionView.fillSuperview()
        self.emptyLabel.centerToSuperview()
    }
    
}

extension FavoriteViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
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
    
}

