//
//  DetailViewController.swift
//  Dictionary_RickAndMorty
//
//  Created by Rodrigo Martins on 06/11/20.
//

import UIKit

class DetailViewController: UIViewController {
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .clear
        scrollView.contentInsetAdjustmentBehavior = .automatic
        scrollView.contentSize = view.frame.size
        scrollView.alwaysBounceVertical = true
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 8
        return imageView
    }()
     
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = UIColor(named: "primaryText")
        label.font = UIFont.systemFont(ofSize: 21, weight: .bold)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = UIColor(named: "primaryText")
        label.alpha = 0.7
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var moreInfoView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.backgroundColor = UIColor(named: "backgroundCell")
        return view
    }()
    
    private lazy var moreInfoTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = UIColor(named: "primaryText")
        label.textAlignment = .left
        label.numberOfLines = 1
        label.text = "Informações"
        return label
    }()
    
    private lazy var moreInfoSubtitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = UIColor(named: "primaryText")
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    
    private let viewModel: DetailViewModel
    
    private let model: CharacterModel
    private var imageStackView: UIStackView!
    private var imageConstraint: NSLayoutConstraint!
    
    private var favoriteBarButton: UIBarButtonItem!
    
    private var isFavorite: Bool = false {
        didSet{
            self.favoriteBarButton.image = isFavorite ? #imageLiteral(resourceName: "ic_favorite_on") : #imageLiteral(resourceName: "ic_favorite_off")
        }
    }
    
    init(character model: CharacterModel, viewModel: DetailViewModel = DetailViewModel()) {
        self.model = model
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(named: "background")
        self.title = "Detalhes"
        
        self.favoriteBarButton = UIBarButtonItem(image: #imageLiteral(resourceName: "ic_favorite_off"), style: .plain, target: self, action: #selector(handleFavorite))
        self.navigationItem.rightBarButtonItem = self.favoriteBarButton
        setupUI()
        bindView()
        
        self.viewModel.loadFavorite(byId: self.model.id) { (isFavorite) in
            self.isFavorite = isFavorite
        }
    }
    
    @objc private func handleFavorite(){
        self.viewModel.toggleFavorite(model: self.model) { (isFavorite) in
            self.isFavorite = isFavorite
        }
    }
    
    private func setupUI(){
        let labels = UIView().stack(titleLabel, subtitleLabel, spacing: 0)
        
        self.imageStackView = UIView().stack(
            UIView().stack(iconImageView,
                           labels,
                           spacing: 8),
            moreInfoView,
            spacing: 22)
        
        moreInfoView.stack(
            moreInfoTitleLabel,
            moreInfoSubtitleLabel,
            UIView(backgroundColor: .clear),
            spacing: 12
        ).withMargins(.init(top: 8, left: 12, bottom: 8, right: 12))
        
        iconImageView.withHeight(iconImageView.widthAnchor)
        self.imageConstraint = self.iconImageView.widthAnchor.constraint(equalToConstant: 150)
        
        view.addSubview(scrollView)
        scrollView.fillSuperview()
        scrollView.addSubview(self.imageStackView)
        
        self.imageStackView.fillSuperview(padding: .init(top: 12, left: 0, bottom: 12, right: 0))
        self.imageStackView.padLeft(16).padRight(16)
        self.imageStackView.withWidth(scrollView.widthAnchor)
        
        self.updateOrientation()
    }
    
    private func bindView(){
        iconImageView.image = ImageCache.shared.image(string: model.image)
        titleLabel.text = model.name
        subtitleLabel.text = "\(model.status) - \(model.species)"
        moreInfoSubtitleLabel.attributedText = NSMutableAttributedString()
            .bold("Sexo", size: 14).newLine()
            .regular(model.gender, size: 12).newLine().newLine()
            .bold("Último localização", size: 14).newLine()
            .regular(model.location.name, size: 12).newLine().newLine()
            .bold("Criação", size: 14).newLine()
            .regular(model.created, size: 12)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        self.updateOrientation()
    }
    
    private func updateOrientation(){
        self.imageConstraint.isActive = UIDevice.current.orientation.isLandscape
        self.imageStackView.axis = UIDevice.current.orientation.isLandscape ? .horizontal : .vertical
    }
}
