//
//  ExploreView.swift
//  MintynTask
//
//  Created by Inyene on 1/23/25.
//

import UIKit

class ExploreView: UIView {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Explore Mintyn"
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.textColor = .white
        return label
    }()
    
    
    private let cardsStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 16
        stack.distribution = .fillEqually
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        [titleLabel, cardsStack].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
        
        setupConstraints()
        setupCards()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            
            cardsStack.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            cardsStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            cardsStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            cardsStack.heightAnchor.constraint(equalToConstant: 180),
            cardsStack.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func setupCards() {
        let investmentCard = createCard(
            title: "Mutual Investment",
            subtitle: "Get up-to 18% per annum ROI",
            icon: "leaf.circle.fill"
        )
        
        let marketplaceCard = createCard(
            title: "Marketplace",
            subtitle: "Buy household food supplies at cheaper prices",
            icon: "cart.fill"
        )
        
        cardsStack.addArrangedSubview(investmentCard)
        cardsStack.addArrangedSubview(marketplaceCard)
    }
    
    private func createCard(title: String, subtitle: String, icon: String) -> UIView {
        let card = UIView()
        card.backgroundColor = UIColor(white: 0.15, alpha: 1.0)
        card.layer.cornerRadius = 16
        
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        let titleLabel = UILabel()
        titleLabel.text = title
        titleLabel.font = .systemFont(ofSize: 15, weight: .semibold)
        titleLabel.textColor = .white
        
        let subtitleLabel = UILabel()
        subtitleLabel.text = subtitle
        subtitleLabel.font = .systemFont(ofSize: 13)
        subtitleLabel.textColor = .gray
        subtitleLabel.numberOfLines = 0
        
        let imageView = UIImageView(image: UIImage(systemName: icon))
        imageView.tintColor = .white
        imageView.contentMode = .scaleAspectFit
        
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(subtitleLabel)
        stackView.addArrangedSubview(UIView()) 
        stackView.addArrangedSubview(imageView)
        
        card.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: card.topAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: card.bottomAnchor, constant: -16),
            imageView.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        return card
    }
}


extension ExploreView {
   func updateTheme() {
       backgroundColor = ThemeManager.shared.currentTheme.backgroundColor
       titleLabel.textColor = ThemeManager.shared.currentTheme.textColor
       
       cardsStack.arrangedSubviews.forEach { cardView in
           cardView.backgroundColor = ThemeManager.shared.currentTheme.cellBackgroundColor
           
           guard let stackView = cardView.subviews.first as? UIStackView else { return }
           stackView.arrangedSubviews.forEach { view in
               if let label = view as? UILabel {
                   if label.font.pointSize == 15 {
                       label.textColor = ThemeManager.shared.currentTheme.textColor
                   } else {
                       label.textColor = .gray
                   }
               } else if let imageView = view as? UIImageView {
                   imageView.tintColor = ThemeManager.shared.currentTheme.textColor
               }
           }
       }
   }
}
