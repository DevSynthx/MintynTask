//
//  UserBalanceView.swift
//  MintynTask
//
//  Created by Inyene on 1/23/25.
//

import UIKit

class UserBalanceView: UIView {
    private var isBalanceHidden = false
    private var balance: Double = 0.0
    
    private let balanceStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 8
        stack.alignment = .center
        return stack
    }()
    
    private let balanceLabel: UILabel = {
        let label = UILabel()
        label.text = "₦0.00"
        label.font = .systemFont(ofSize: 36, weight: .medium)
        label.textColor = .white
        return label
    }()
    
    private let eyeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "eye.slash.fill"), for: .normal)
        button.tintColor = UIColor(red: 0.83, green: 0.69, blue: 0.22, alpha: 1.0)
        return button
    }()
    
    private let accountStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 8
        stack.alignment = .center
        return stack
    }()
    
    private let containerStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        stack.alignment = .center
        return stack
    }()
    
    private let accountLabel: UILabel = {
           let label = UILabel()
           let text = NSMutableAttributedString(string: "Individual • ", attributes: [
               .foregroundColor: UIColor.gray,
               .font: UIFont.systemFont(ofSize: 14)
           ])
           
           text.append(NSAttributedString(string: "1114441001 • ", attributes: [
               .foregroundColor: UIColor.white,
               .font: UIFont.systemFont(ofSize: 14)
           ]))
           
           text.append(NSAttributedString(string: "Tier 1 ", attributes: [
               .foregroundColor: UIColor.white,
               .font: UIFont.systemFont(ofSize: 14)
           ]))
           
           
           label.attributedText = text
           return label
       }()
    
    private let tierImage: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(systemName: "square.filled.on.square")
        iv.tintColor = UIColor(red: 0.83, green: 0.69, blue: 0.22, alpha: 1.0)
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = .black
        
        [containerStack].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
        
        balanceStackView.addArrangedSubview(balanceLabel)
        balanceStackView.addArrangedSubview(eyeButton)
        
        accountStack.addArrangedSubview(accountLabel)
        accountStack.addArrangedSubview(tierImage)
        
        containerStack.addArrangedSubview(balanceStackView)
        containerStack.addArrangedSubview(accountStack)
        
        setupActions()
        
        NSLayoutConstraint.activate([
            containerStack.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            containerStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            containerStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            containerStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            
            eyeButton.widthAnchor.constraint(equalToConstant: 24),
            eyeButton.heightAnchor.constraint(equalToConstant: 24),
            tierImage.widthAnchor.constraint(equalToConstant: 20),
            tierImage.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    private func setupActions() {
        eyeButton.addTarget(self, action: #selector(toggleBalance), for: .touchUpInside)
    }
    
    func updateBalance(_ amount: Double) {
        balance = amount
        updateBalanceDisplay()
    }
    
    private func updateBalanceDisplay() {
        if isBalanceHidden {
            balanceLabel.text = "₦•••••"
            eyeButton.setImage(UIImage(systemName: "eye.fill"), for: .normal)
        } else {
            balanceLabel.text = String(format: "₦%.2f", balance)
            eyeButton.setImage(UIImage(systemName: "eye.slash.fill"), for: .normal)
        }
    }
    
    @objc private func toggleBalance() {
        isBalanceHidden.toggle()
        updateBalanceDisplay()
    }
}


extension UserBalanceView {
    func updateTheme() {
        backgroundColor = ThemeManager.shared.currentTheme.backgroundColor
        balanceLabel.textColor = ThemeManager.shared.currentTheme.textColor
        updateAccountLabel()
    }
    
    private func updateAccountLabel() {
        let text = NSMutableAttributedString(string: "Individual • ", attributes: [
            .foregroundColor: UIColor.gray,
            .font: UIFont.systemFont(ofSize: 14)
        ])
        
        text.append(NSAttributedString(string: "1114441001 • ", attributes: [
            .foregroundColor: ThemeManager.shared.currentTheme.textColor,
            .font: UIFont.systemFont(ofSize: 14)
        ]))
        
        text.append(NSAttributedString(string: "Tier 1 ", attributes: [
            .foregroundColor: ThemeManager.shared.currentTheme.textColor,
            .font: UIFont.systemFont(ofSize: 14)
        ]))
        
        accountLabel.attributedText = text
    }
}
