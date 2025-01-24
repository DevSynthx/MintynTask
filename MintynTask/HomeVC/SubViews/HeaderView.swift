//
//  HeaderView.swift
//  MintynTask
//
//  Created by Inyene on 1/23/25.
//

import UIKit

class HeaderView: UIView {

    private let hStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.spacing = 16
        sv.distribution = .equalSpacing
        sv.alignment = .center
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()

    private let topIconsStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.spacing = 8
        sv.distribution = .fill
        sv.alignment = .center
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()

    private let username: UILabel = {
        let label = UILabel()
        label.text = "Mintyn"
        label.font = .systemFont(ofSize: 24, weight: .black)
        label.textColor = .white
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
        [hStackView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }

        setupHeader()
    }

    private func setupHeader() {
      
        hStackView.addArrangedSubview(username)
        hStackView.addArrangedSubview(topIconsStackView)

        
        let icons = ["magnifyingglass", "headphones", "bell"]
        icons.forEach { iconName in
            let iconButton = createCircularButton(systemName: iconName)
            topIconsStackView.addArrangedSubview(iconButton)
        }

      
        NSLayoutConstraint.activate([
            hStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            hStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            hStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            hStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16)
        ])
    }

    private func createCircularButton(systemName: String) -> UIButton {
        let button = UIButton()
        button.setImage(UIImage(systemName: systemName), for: .normal)
        button.tintColor = .white
        button.backgroundColor = UIColor(white: 0.2, alpha: 1.0)
        button.layer.cornerRadius = 20
        button.widthAnchor.constraint(equalToConstant: 40).isActive = true
        button.heightAnchor.constraint(equalToConstant: 40).isActive = true
        return button
    }
}


extension HeaderView {
    func updateTheme() {
        backgroundColor = ThemeManager.shared.currentTheme.backgroundColor
        username.textColor = ThemeManager.shared.currentTheme.textColor
        let buttonColor = ThemeManager.shared.currentTheme == .light ?
            UIColor(white: 0.9, alpha: 1.0) :
            UIColor(white: 0.2, alpha: 1.0)
            
        topIconsStackView.arrangedSubviews.forEach { view in
            if let button = view as? UIButton {
                button.backgroundColor = buttonColor
                button.tintColor = ThemeManager.shared.currentTheme.textColor
            }
        }
    }
}
