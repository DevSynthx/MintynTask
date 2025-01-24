//
//  SystemVC.swift
//  MintynTask
//
//  Created by Inyene on 1/24/25.
//

import UIKit

class SystemViewController: UIViewController {
    
    private let options = ["Default", "Light Mode", "Dark Mode"]
    private var selectedOption = 0
    
    private let tableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .insetGrouped)
        tv.backgroundColor = .black
        tv.register(SettingsCell.self, forCellReuseIdentifier: "SettingsCell")
        tv.separatorStyle = .none
        return tv
    }()
    
    private let backButton: UIButton = {
          let button = UIButton(type: .system)
          button.setImage(UIImage(systemName: "chevron.left")?.withRenderingMode(.alwaysTemplate), for: .normal)
          return button
      }()

    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        selectedOption = ThemeManager.shared.currentTheme.rawValue
        setupTheme()
        NotificationCenter.default.addObserver(self,
                                            selector: #selector(themeDidChange),
                                            name: .themeDidChange,
                                            object: nil)
    }
    
    private func setupView() {
        view.backgroundColor = .black
        title = "Appearance"
        
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    
    private func setupTheme() {
        view.backgroundColor = ThemeManager.shared.currentTheme.backgroundColor
        tableView.backgroundColor = ThemeManager.shared.currentTheme.backgroundColor
        title = "Appearance"
        navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: ThemeManager.shared.currentTheme.textColor
        ]
        backButton.tintColor = ThemeManager.shared.currentTheme.textColor

    }
    
    @objc private func themeDidChange() {
        setupTheme()
        tableView.reloadData()
    }
    
}

extension SystemViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsCell", for: indexPath) as! SettingsCell
           cell.configure(with: options[indexPath.row],
                         icon: nil,
                         showDisclosure: false,
                         theme: ThemeManager.shared.currentTheme)
           
           if indexPath.row == selectedOption {
               let checkmark = UIImage(systemName: "checkmark")?
                   .withTintColor(ThemeManager.shared.currentTheme.textColor, renderingMode: .alwaysTemplate)
               cell.accessoryView = UIImageView(image: checkmark)
           } else {
               cell.accessoryView = nil
           }
           
           return cell
       }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
  
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedOption = indexPath.row
        ThemeManager.shared.currentTheme = ThemeManager.Theme(rawValue: indexPath.row) ?? .default
            ThemeManager.shared.applyTheme(to: view.window)
        tableView.reloadData()
        
        switch indexPath.row {
        case 0:
            view.window?.overrideUserInterfaceStyle = .unspecified
        case 1:
            view.window?.overrideUserInterfaceStyle = .light
        case 2:
            view.window?.overrideUserInterfaceStyle = .dark
        default:
            break
        }
    }
}




