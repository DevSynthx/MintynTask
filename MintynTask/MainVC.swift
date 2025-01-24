//
//  MenuVC.swift
//  MintynTask
//
//  Created by Inyene on 1/13/25.
//

import UIKit


class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        setupViewControllers()
        setupCustomTabBar()
    }
    
    private func setupViewControllers() {
        let homeVC = UINavigationController(rootViewController: HomeViewController())
        let investVC = UINavigationController(rootViewController: InvestViewController())
        let menuVC = UINavigationController(rootViewController: MenuViewController())
        let transactionsVC = UINavigationController(rootViewController: TransactionsViewController())
        let settingsVC = UINavigationController(rootViewController: SettingsViewController())
        
        homeVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
        investVC.tabBarItem = UITabBarItem(title: "Invest", image: UIImage(systemName: "chart.bar"), selectedImage: UIImage(systemName: "chart.bar.fill"))
        menuVC.tabBarItem = UITabBarItem(title: "Menu", image: UIImage(systemName: "square.grid.2x2"), selectedImage: UIImage(systemName: "square.grid.2x2.fill"))
        transactionsVC.tabBarItem = UITabBarItem(title: "Transactions", image: UIImage(systemName: "creditcard"), selectedImage: UIImage(systemName: "creditcard.fill"))
        settingsVC.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "gear"), selectedImage: UIImage(systemName: "gear.fill"))
        
        viewControllers = [homeVC, investVC, menuVC, transactionsVC, settingsVC]
    }
    
    private func setupCustomTabBar() {
        let customTabBar = CustomTabBar()
        setValue(customTabBar, forKey: "tabBar")
        
        tabBar.backgroundColor = .black
        tabBar.tintColor = UIColor(red: 0.85, green: 0.65, blue: 0.13, alpha: 1.0)
        tabBar.unselectedItemTintColor = .lightGray
    }
}



class CustomTabBar: UITabBar {
    private var shapeLayer: CALayer?
    private var centerButton: UIButton!
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        setupCenterButton()
    }
    
    private func setupCenterButton() {
        if centerButton == nil {
            centerButton = UIButton(frame: CGRect(x: (self.bounds.width / 2) - 30,
                                                y: -30,
                                                width: 60,
                                                height: 60))
            
            centerButton.backgroundColor = UIColor(red: 0.85, green: 0.65, blue: 0.13, alpha: 1.0)
            centerButton.layer.cornerRadius = 30
            centerButton.layer.shadowColor = UIColor.black.cgColor
            centerButton.layer.shadowOffset = CGSize(width: 0, height: 2)
            centerButton.layer.shadowRadius = 4
            centerButton.layer.shadowOpacity = 0.3
            
            let menuImage = UIImage(systemName: "square.grid.2x2.fill")?.withRenderingMode(.alwaysTemplate)
            centerButton.setImage(menuImage, for: .normal)
            centerButton.tintColor = .white
            
            addSubview(centerButton)
        }
    }
}


#Preview{
    MainTabBarController()
}








