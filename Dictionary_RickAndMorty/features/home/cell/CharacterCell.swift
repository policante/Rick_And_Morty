//
//  CharacterCell.swift
//  Dictionary_RickAndMorty
//
//  Created by Rodrigo Martins on 06/11/20.
//

import UIKit

class CharacterCell: UICollectionViewCell {
        
    private let iconView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .clear
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.textColor = UIColor(named: "primaryText")
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = UIColor(named: "primaryText")
        label.alpha = 0.7
        label.textAlignment = .left
        label.numberOfLines = 2
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setupUI(){
        backgroundColor = UIColor(named: "backgroundCell")
        layer.cornerRadius = 8
        layer.masksToBounds = true
        layer.borderColor = UIColor(named: "divider")?.cgColor
        
        let labels = stack(titleLabel, subtitleLabel,
                           spacing: 4,
                           alignment: .leading)
        labels.removeConstraints(labels.constraints)
        labels.distribution = .fill
        
        hstack(iconView.withWidth(iconView.heightAnchor),
               UIView(labels),
               spacing: 16).withMargins(.init(top: 0, left: 0, bottom: 0, right: 12))
        labels.centerYToSuperview()
        labels.anchor(left: labels.superview?.leftAnchor, right: labels.superview?.rightAnchor)
    }
    
    func bind(model: CharacterModel){
        self.iconView.image = ImageCache.shared.image(string: model.image)
        self.titleLabel.text = model.name
        self.subtitleLabel.text = "\(model.status) - \(model.species)"
    }
    
}
