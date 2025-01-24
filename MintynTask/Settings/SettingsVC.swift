//
//  SettingsVC.swift
//  MintynTask
//
//  Created by Inyene on 1/13/25.
//


import UIKit

class SettingsViewController: UIViewController {
    private let tableView: UITableView = {
        let tv = UITableView(frame: .zero, style: .insetGrouped)
        tv.backgroundColor = .black
        tv.register(SettingsCell.self, forCellReuseIdentifier: "SettingsCell")
        tv.separatorStyle = .none
        return tv
    }()
    
    private var sections: [SettingsSection] = [
        SettingsSection(title: "Profile", icon: "person.circle.fill", isExpanded: false, items: [
            SettingsItem(title: "Personal Information", icon: "person.fill"),
            SettingsItem(title: "Employment Information", icon: "briefcase.fill"),
            SettingsItem(title: "Identification Information", icon: "person.text.rectangle.fill"),
            SettingsItem(title: "Next of Kin", icon: "person.2.fill")
        ]),
        SettingsSection(title: "Account Management", icon: "creditcard.fill", isExpanded: false),
        SettingsSection(title: "Referrals", icon: "megaphone.fill", isExpanded: false),
        SettingsSection(title: "Legal", icon: "shield.fill", isExpanded: false),
        SettingsSection(title: "Help and Support", icon: "24.circle.fill", isExpanded: false),
        SettingsSection(title: "System", icon: "iphone", isExpanded: false, items: [
               SettingsItem(title: "Autologoff", icon: "timer"),
               SettingsItem(title: "Appearance", icon: "paintbrush.fill")
           ]),
        SettingsSection(title: "Log out", icon: "rectangle.portrait.and.arrow.right.fill", isExpanded: false)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupThemeSupport()
    }
    
    private func setupView() {
        
        view.backgroundColor = .black
        title = "Settings"
        
        navigationController?.navigationBar.barTintColor = .black
      
        navigationController?.navigationBar.titleTextAttributes = [
                .foregroundColor: UIColor.white
            ]
            
        setupTheme()
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
}


extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = sections[section]
        return section.isExpanded ? (section.items?.count ?? 0) + 1 : 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsCell", for: indexPath) as! SettingsCell
        let section = sections[indexPath.section]
        
        cell.selectionStyle = .none
        
        if indexPath.row == 0 {
            cell.configure(with: section.title,
                         icon: section.icon,
                         showDisclosure: true,
                         theme: ThemeManager.shared.currentTheme)
            
            if section.items != nil {
                let imageConfig = UIImage.SymbolConfiguration(pointSize: 13, weight: .semibold)
                let chevronImage = section.isExpanded ?
                    UIImage(systemName: "chevron.down", withConfiguration: imageConfig) :
                    UIImage(systemName: "chevron.right", withConfiguration: imageConfig)
                let imageView = UIImageView(image: chevronImage?.withRenderingMode(.alwaysTemplate))
                imageView.frame = CGRect(x: 0, y: 0, width: 15, height: 15)
                imageView.contentMode = .scaleAspectFit
                imageView.tintColor = ThemeManager.shared.currentTheme.textColor
                cell.accessoryView = imageView
            } else {
                let imageConfig = UIImage.SymbolConfiguration(pointSize: 13, weight: .semibold)
                let imageView = UIImageView(image: UIImage(systemName: "chevron.right", withConfiguration: imageConfig)?.withRenderingMode(.alwaysTemplate))
                imageView.frame = CGRect(x: 0, y: 0, width: 15, height: 15)
                imageView.contentMode = .scaleAspectFit
                imageView.tintColor = ThemeManager.shared.currentTheme.textColor
                cell.accessoryView = imageView
            }
        } else {
            let item = section.items![indexPath.row - 1]
            cell.configure(with: item.title,
                         icon: item.icon,
                         isSubItem: true,
                         theme: ThemeManager.shared.currentTheme)
            
            let imageConfig = UIImage.SymbolConfiguration(pointSize: 13, weight: .semibold)
            let imageView = UIImageView(image: UIImage(systemName: "chevron.right", withConfiguration: imageConfig)?.withRenderingMode(.alwaysTemplate))
            imageView.frame = CGRect(x: 0, y: 0, width: 15, height: 15)
            imageView.contentMode = .scaleAspectFit
            imageView.tintColor = ThemeManager.shared.currentTheme.textColor
            cell.accessoryView = imageView
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return 60
       }
       
       func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
           let headerView = UIView()
           headerView.backgroundColor = .clear
           return headerView
       }
       
       func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
           return 20
       }
       
       func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
           return UIView()
       }
       
       func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
           return 0
       }
    
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           tableView.deselectRow(at: indexPath, animated: true)
           let section = sections[indexPath.section]
           
           if indexPath.row == 0 && section.items != nil {
               sections[indexPath.section].isExpanded.toggle()
               tableView.reloadSections(IndexSet(integer: indexPath.section), with: .automatic)
           } else if section.title == "System" && indexPath.row > 0 && section.items?[indexPath.row - 1].title == "Appearance" {
               let systemVC = SystemViewController()
               navigationController?.pushViewController(systemVC, animated: true)
           } else if section.title == "Log out" {
               let loginVC = LoginViewController()
               if let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) {
                   window.rootViewController = UINavigationController(rootViewController: loginVC)
                   window.makeKeyAndVisible()
               }
           }
       }
    
}


#Preview{
    MainTabBarController()
}


extension SettingsViewController {
   private func setupThemeSupport() {
       setupTheme()
       NotificationCenter.default.addObserver(self,
                                           selector: #selector(themeDidChange),
                                           name: .themeDidChange,
                                           object: nil)
   }
   
   private func setupTheme() {
       view.backgroundColor = ThemeManager.shared.currentTheme.backgroundColor
       tableView.backgroundColor = ThemeManager.shared.currentTheme.backgroundColor
       navigationController?.navigationBar.titleTextAttributes = [
           .foregroundColor: ThemeManager.shared.currentTheme.textColor
       ]
   }
   
   @objc private func themeDidChange() {
       setupTheme()
       tableView.reloadData()
   }
   

}






