//
//  TransactionsView.swift
//  MintynTask
//
//  Created by Inyene on 1/23/25.
//

import UIKit

class TransactionsView: UIView {
    private let headerStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        return stack
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Recent Transactions"
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.textColor = .white
        return label
    }()
    
    private let seeAllButton: UIButton = {
        let button = UIButton()
        button.setTitle("See all ", for: .normal)
        button.setTitleColor(UIColor(red: 0.85, green: 0.65, blue: 0.13, alpha: 1.0), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.setImage(UIImage(systemName: "chevron.right"), for: .normal)
        button.tintColor = UIColor(red: 0.85, green: 0.65, blue: 0.13, alpha: 1.0)
        button.semanticContentAttribute = .forceRightToLeft
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 4, bottom: 0, right: 0)
        return button
    }()
    
    private let emptyStateView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.15, alpha: 1.0)
        view.layer.cornerRadius = 16
        return view
    }()
    
    private let emptyStateStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 16
        stack.alignment = .center
        return stack
    }()
    
    private let emptyStateIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "doc.text")
        imageView.tintColor = .gray
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let emptyStateLabel: UILabel = {
        let label = UILabel()
        label.text = "No transaction records"
        label.font = .systemFont(ofSize: 14)
        label.textColor = .gray
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        [headerStack, emptyStateView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
        
        emptyStateStack.translatesAutoresizingMaskIntoConstraints = false
        emptyStateView.addSubview(emptyStateStack)
        
        [emptyStateIcon, emptyStateLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            emptyStateStack.addArrangedSubview($0)
        }
        
        headerStack.addArrangedSubview(titleLabel)
        headerStack.addArrangedSubview(seeAllButton)
        
        NSLayoutConstraint.activate([
            headerStack.topAnchor.constraint(equalTo: topAnchor),
            headerStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            headerStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            
            emptyStateView.topAnchor.constraint(equalTo: headerStack.bottomAnchor, constant: 16),
            emptyStateView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            emptyStateView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            emptyStateView.heightAnchor.constraint(equalToConstant: 260),
            emptyStateView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            emptyStateStack.centerXAnchor.constraint(equalTo: emptyStateView.centerXAnchor),
            emptyStateStack.centerYAnchor.constraint(equalTo: emptyStateView.centerYAnchor),
            
            emptyStateIcon.widthAnchor.constraint(equalToConstant: 40),
            emptyStateIcon.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        seeAllButton.addTarget(self, action: #selector(seeAllTapped), for: .touchUpInside)
    }
    
    @objc private func seeAllTapped() {
     
    }
}


extension TransactionsView {
   func updateTheme() {
       backgroundColor = ThemeManager.shared.currentTheme.backgroundColor
       titleLabel.textColor = ThemeManager.shared.currentTheme.textColor
       emptyStateLabel.textColor = ThemeManager.shared.currentTheme.textColor
       emptyStateView.backgroundColor = ThemeManager.shared.currentTheme == .light ?
       UIColor(white: 0.7, alpha: 1.0) :
       UIColor(white: 0.2, alpha: 1.0)
       
       
   }
}
