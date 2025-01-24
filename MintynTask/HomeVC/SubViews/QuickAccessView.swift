//
//  QuickAccessView.swift
//  MintynTask
//
//  Created by Inyene on 1/23/25.
//

import UIKit


class QuickAccessView: UIView {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Quick Access"
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.textColor = .white
        return label
    }()
    
    private let gridView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.15, alpha: 1.0)
        view.layer.cornerRadius = 16
        return view
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = createGridLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.delegate = self
        cv.dataSource = self
        cv.register(QuickAccessCell.self, forCellWithReuseIdentifier: QuickAccessCell.identifier)
        return cv
    }()
    
    private let items: [(icon: String, title: String)] = [
        ("arrow.up.arrow.down", "Remita"),
        ("phone", "Airtime $ Data"),
        ("dollarsign.circle", "Betting"),
        ("building", "Business"),
        ("creditcard", "Card"),
        ("gift", "Gift Card"),
        ("bag", "Other bills"),
        ("piggy.bank", "Savings")
    ]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        [titleLabel, gridView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        gridView.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            
            gridView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            gridView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            gridView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            gridView.heightAnchor.constraint(equalToConstant: 200),
            gridView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            collectionView.topAnchor.constraint(equalTo: gridView.topAnchor, constant: 16),
            collectionView.leadingAnchor.constraint(equalTo: gridView.leadingAnchor, constant: 16),
            collectionView.trailingAnchor.constraint(equalTo: gridView.trailingAnchor, constant: -16),
            collectionView.bottomAnchor.constraint(equalTo: gridView.bottomAnchor, constant: -16)
        ])
    }
    
    private func createGridLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 16
        layout.minimumLineSpacing = 16
        
        let width = (UIScreen.main.bounds.width - 64 - (3 * 16)) / 4
        layout.itemSize = CGSize(width: width, height: width)
        
        return layout
    }
}

extension QuickAccessView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: QuickAccessCell.identifier, for: indexPath) as? QuickAccessCell else {
            return UICollectionViewCell()
        }
        
        let item = items[indexPath.item]
        cell.configure(icon: item.icon, title: item.title)
        cell.updateTheme()
        return cell
    }
}

extension QuickAccessView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}


class QuickAccessCell: UICollectionViewCell {
    static let identifier = "QuickAccessCell"
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .white
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.font = .systemFont(ofSize: 12)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.7
        label.numberOfLines = 1
        return label
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.2, alpha: 1.0)
        view.layer.cornerRadius = 12
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        contentView.addSubview(containerView)
        contentView.addSubview(titleLabel)
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            containerView.widthAnchor.constraint(equalToConstant: 50),
            containerView.heightAnchor.constraint(equalToConstant: 50),
            
            titleLabel.topAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            titleLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor)
        ])
    }
    
    func configure(icon: String, title: String) {
        iconImageView.image = UIImage(systemName: icon)
        titleLabel.text = title
        containerView.addSubview(iconImageView)
        
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            iconImageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            iconImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 20),
            iconImageView.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
}



extension QuickAccessView {
   func updateTheme() {
       backgroundColor = ThemeManager.shared.currentTheme.backgroundColor
       titleLabel.textColor = ThemeManager.shared.currentTheme.textColor
       gridView.backgroundColor = ThemeManager.shared.currentTheme.cellBackgroundColor
       
       collectionView.reloadData()
   }
}

extension QuickAccessCell {
   func updateTheme() {
       containerView.backgroundColor = ThemeManager.shared.currentTheme == .light ?
           UIColor(white: 0.7, alpha: 1.0) :
           UIColor(white: 0.2, alpha: 1.0)
       iconImageView.tintColor = ThemeManager.shared.currentTheme.textColor
       titleLabel.textColor = ThemeManager.shared.currentTheme.textColor
   }
  
}
