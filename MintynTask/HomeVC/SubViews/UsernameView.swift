//
//  UsernameView.swift
//  MintynTask
//
//  Created by Inyene on 1/23/25.
//


import UIKit

class UserNameView: UIView {
    private let avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor(white: 0.2, alpha: 1.0)
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        imageView.image = UIImage(systemName: "person.fill")
        imageView.tintColor = .white
        imageView.contentMode = .center
        return imageView
    }()
    
    private let username: UILabel = {
        let label = UILabel()
        label.text = "Inyene Celestine Etoedia"
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .white
        return label
    }()
    
    private let switchAccountButton: UIButton = {
        let button = UIButton()
        button.setTitle("Switch Account", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        button.backgroundColor = UIColor(white: 0.2, alpha: 1.0)
        button.layer.cornerRadius = 20
        button.contentEdgeInsets = UIEdgeInsets(top: 11, left: 0, bottom: 13, right: 0)
        return button
    }()
    
    private let hstackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.spacing = 16
        sv.distribution = .fillProportionally
        sv.alignment = .center
        return sv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        [hstackView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
        
        setupLayout()
    }
    
    private func setupLayout() {
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        hstackView.addArrangedSubview(avatarImageView)
        hstackView.addArrangedSubview(username)
        hstackView.addArrangedSubview(switchAccountButton)
        
        NSLayoutConstraint.activate([
            hstackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            hstackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            hstackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            hstackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -0),
            
            avatarImageView.widthAnchor.constraint(equalToConstant: 40),
            avatarImageView.heightAnchor.constraint(equalToConstant: 40),
            
            switchAccountButton.widthAnchor.constraint(equalToConstant: 110)
        ])
    }
}




extension UserNameView {
    func updateTheme() {
        backgroundColor = ThemeManager.shared.currentTheme.backgroundColor
        username.textColor = ThemeManager.shared.currentTheme.textColor
        avatarImageView.tintColor = ThemeManager.shared.currentTheme.textColor
        switchAccountButton.backgroundColor = ThemeManager.shared.currentTheme == .light ?
        UIColor(white: 0.9, alpha: 1.0) :
        UIColor(white: 0.2, alpha: 1.0)
        switchAccountButton.setTitleColor(ThemeManager.shared.currentTheme == .light ? .black : .white, for: .normal)
    }
    
}
