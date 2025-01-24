//
//  HomeVC.swift
//  MintynTask
//
//  Created by Inyene on 1/13/25.
//

// HomeViewController.swift
import UIKit


class HomeViewController: UIViewController {
    private let scrollView = UIScrollView()
     private let contentView = UIView()
     
     private let headerView = HeaderView()
     private let userName = UserNameView()
     private let userBalance = UserBalanceView()
     private let actionButton = ActionButtonsView()
     private let quickAccessView = QuickAccessView()
     private let exploreView = ExploreView()
     private let transactionsView = TransactionsView()
  
     
     override func viewDidLoad() {
         super.viewDidLoad()
      
         setupView()
         setupThemeSupport()
     }
     
     private func setupView() {
         view.backgroundColor = .black
         setupHeader()
         setupScrollView()
         setupSubviews()
         setupTheme()
     }
    
    
    private func setupHeader() {
          headerView.translatesAutoresizingMaskIntoConstraints = false
          view.addSubview(headerView)
          
          NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
              headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
              headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
          ])
      }

     
    private func setupScrollView() {
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
     
     private func setupSubviews() {
         [userName, userBalance, actionButton, quickAccessView, exploreView, transactionsView].forEach { subview in
             subview.translatesAutoresizingMaskIntoConstraints = false
             contentView.addSubview(subview)
         }
         
         NSLayoutConstraint.activate([
            // userName View
            userName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: -30),
            userName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            userName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
              
              // Balance View 
              userBalance.topAnchor.constraint(equalTo: userName.bottomAnchor, constant: 24),
              userBalance.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
              userBalance.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
              
              // Action Buttons
              actionButton.topAnchor.constraint(equalTo: userBalance.bottomAnchor, constant: 32),
              actionButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
              actionButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
              
              // Quick Access
              quickAccessView.topAnchor.constraint(equalTo: actionButton.bottomAnchor, constant: 32),
              quickAccessView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
              quickAccessView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
              
              // Explore View
              exploreView.topAnchor.constraint(equalTo: quickAccessView.bottomAnchor, constant: 32),
              exploreView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
              exploreView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
              
              // Transactions View
              transactionsView.topAnchor.constraint(equalTo: exploreView.bottomAnchor, constant: 32),
              transactionsView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
              transactionsView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            transactionsView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -50)
          ])
     }
}

#Preview{
    MainTabBarController()
}

extension HomeViewController {
    private func setupThemeSupport() {
        setupTheme()
        NotificationCenter.default.addObserver(self,
                                            selector: #selector(themeDidChange),
                                            name: .themeDidChange,
                                            object: nil)
    }
    
    private func setupTheme() {
        view.backgroundColor = ThemeManager.shared.currentTheme.backgroundColor
        contentView.backgroundColor = ThemeManager.shared.currentTheme.backgroundColor
        scrollView.backgroundColor = ThemeManager.shared.currentTheme.backgroundColor
        [userName, userBalance, actionButton, quickAccessView, exploreView, transactionsView].forEach { view in
            view.backgroundColor = ThemeManager.shared.currentTheme.backgroundColor
        }
        
        
          headerView.updateTheme()
          userName.updateTheme()
          userBalance.updateTheme()
          actionButton.updateTheme()
          quickAccessView.updateTheme()
          exploreView.updateTheme()
          transactionsView.updateTheme()
    }
    
    @objc private func themeDidChange() {
        setupTheme()
    }
}

