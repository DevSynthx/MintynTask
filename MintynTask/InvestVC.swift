//
//  InvestVC.swift
//  MintynTask
//
//  Created by Inyene on 1/13/25.
//

import UIKit

class InvestViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Invest"
        setupPlaceholderContent()
    }
    
    private func setupPlaceholderContent() {
        let label = UILabel()
        label.text = "Invest Screen"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
