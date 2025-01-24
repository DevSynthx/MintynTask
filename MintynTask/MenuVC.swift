//
//  MenuVC.swift
//  MintynTask
//
//  Created by Inyene on 1/23/25.
//

import UIKit

class MenuViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Menu"
        setupPlaceholderContent()
    }
    
    private func setupPlaceholderContent() {
        let label = UILabel()
        label.text = "Menu Screen"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
