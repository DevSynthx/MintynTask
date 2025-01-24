//
//  ActionButtonView.swift
//  MintynTask
//
//  Created by Inyene on 1/23/25.
//

import UIKit

class ActionButtonsView: UIView {
   private let containerStack: UIStackView = {
       let stack = UIStackView()
       stack.axis = .vertical
       stack.spacing = 24
       return stack
   }()
   
   private let hStack: UIStackView = {
       let stack = UIStackView()
       stack.axis = .horizontal
       stack.spacing = 16
       stack.distribution = .fillEqually
       return stack
   }()
   
   private let addButton: UIButton = {
       let button = UIButton()
       button.setImage(UIImage(systemName: "plus"), for: .normal)
       button.setTitle(" Add Money", for: .normal)
       button.backgroundColor = UIColor(white: 0.2, alpha: 1.0)
       button.layer.cornerRadius = 25
       button.tintColor = .white
       button.titleLabel?.font = .systemFont(ofSize: 15)
       
       return button
   }()
   
   private let transferButton: UIButton = {
       let button = UIButton()
       button.setImage(UIImage(systemName: "arrow.left.arrow.right"), for: .normal)
       button.setTitle(" Transfer", for: .normal)
       button.backgroundColor = UIColor(red: 0.83, green: 0.69, blue: 0.22, alpha: 1.0)
       button.layer.cornerRadius = 25
       button.tintColor = .white
       button.titleLabel?.font = .systemFont(ofSize: 15)
       return button
   }()
   
   private let updateView: UIView = {
       let view = UIView()
       view.backgroundColor = UIColor(white: 0.2, alpha: 1.0)
       view.layer.cornerRadius = 20
       return view
   }()
   
   private let infoIcon: UIImageView = {
       let iv = UIImageView()
       iv.image = UIImage(systemName: "info.circle.fill")
       iv.tintColor = .green
       return iv
   }()
   
   private let titleLabel: UILabel = {
       let label = UILabel()
       label.text = "Update Account"
       label.font = .systemFont(ofSize: 16, weight: .bold)
       label.textColor = .white
       return label
   }()
   
   private let subtitleLabel: UILabel = {
       let label = UILabel()
       label.text = "Update your account to get unlimited access to your account"
       label.font = .systemFont(ofSize: 14)
       label.textColor = .white
       label.numberOfLines = 0
       return label
   }()
   
   private let updateButton: UIButton = {
       let button = UIButton()
       button.setTitle("Update now", for: .normal)
       button.semanticContentAttribute = .forceRightToLeft
       button.backgroundColor = .white
       button.setTitleColor(.black, for: .normal)
       button.titleLabel?.font = .systemFont(ofSize: 15)
       button.layer.cornerRadius = 20
       button.contentEdgeInsets = UIEdgeInsets(top: 12, left: 15, bottom: 12, right: 15)
       return button
   }()
   
   private let updateStack: UIStackView = {
       let stack = UIStackView()
       stack.axis = .vertical
       stack.spacing = 11
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
       containerStack.translatesAutoresizingMaskIntoConstraints = false
       addSubview(containerStack)
       
       setupButtons()
       setupUpdateView()
       setupConstraints()
   }
   
   private func setupButtons() {
       [addButton, transferButton].forEach { hStack.addArrangedSubview($0) }
       containerStack.addArrangedSubview(hStack)
   }
   
    private func setupUpdateView() {
        let headerStack = UIStackView()
        headerStack.axis = .horizontal
        headerStack.spacing = 8
        headerStack.alignment = .center

        [infoIcon, titleLabel].forEach { headerStack.addArrangedSubview($0) }

        [headerStack, subtitleLabel, updateButton].forEach { updateStack.addArrangedSubview($0) }
        updateStack.setCustomSpacing(10, after: headerStack)
        updateStack.setCustomSpacing(24, after: subtitleLabel)

        // Ensure the updateStack aligns items to the leading
        updateStack.alignment = .leading

        updateStack.translatesAutoresizingMaskIntoConstraints = false
        updateView.addSubview(updateStack)
        containerStack.addArrangedSubview(updateView)

        NSLayoutConstraint.activate([
            updateStack.topAnchor.constraint(equalTo: updateView.topAnchor, constant: 24),
            updateStack.leadingAnchor.constraint(equalTo: updateView.leadingAnchor, constant: 24),
            updateStack.trailingAnchor.constraint(equalTo: updateView.trailingAnchor, constant: -24),

            infoIcon.widthAnchor.constraint(equalToConstant: 24),
            infoIcon.heightAnchor.constraint(equalToConstant: 24),
            
        
        ])
    }

   
   private func setupConstraints() {
       NSLayoutConstraint.activate([
           containerStack.topAnchor.constraint(equalTo: topAnchor, constant: 16),
           containerStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
           containerStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
           containerStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
           
           hStack.heightAnchor.constraint(equalToConstant: 50),
           updateView.heightAnchor.constraint(equalToConstant: 180),
           
           updateStack.topAnchor.constraint(equalTo: updateView.topAnchor, constant: 24),
           updateStack.leadingAnchor.constraint(equalTo: updateView.leadingAnchor, constant: 24),
           updateStack.trailingAnchor.constraint(equalTo: updateView.trailingAnchor, constant: -24),
           
           
           
           infoIcon.widthAnchor.constraint(equalToConstant: 24),
           infoIcon.heightAnchor.constraint(equalToConstant: 24),
           updateButton.heightAnchor.constraint(equalToConstant: 40)
       ])
   }
}


extension ActionButtonsView {
    func updateTheme() {
        backgroundColor = ThemeManager.shared.currentTheme.backgroundColor
        let buttonColor = ThemeManager.shared.currentTheme == .light ?
            UIColor(white: 0.9, alpha: 1.0) :
            UIColor(white: 0.2, alpha: 1.0)
            
        addButton.backgroundColor = buttonColor
        addButton.setTitleColor(ThemeManager.shared.currentTheme == .light ? .black : .white, for: .normal)
        addButton.tintColor = ThemeManager.shared.currentTheme.textColor
        updateView.backgroundColor = buttonColor
        titleLabel.textColor = ThemeManager.shared.currentTheme.textColor
        subtitleLabel.textColor = ThemeManager.shared.currentTheme.textColor
    }
}
