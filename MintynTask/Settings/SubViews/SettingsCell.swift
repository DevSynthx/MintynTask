//
//  SettingsCell.swift
//  MintynTask
//
//  Created by Inyene on 1/23/25.
//




import UIKit



class SettingsCell: UITableViewCell {
    private let iconContainer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.2, alpha: 1.0)
        view.layer.cornerRadius = 8
        return view
    }()
    
    private let iconImageView: UIImageView = {
        let iv = UIImageView()
        iv.tintColor = .white
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        backgroundColor = .black
        
        [iconContainer, titleLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        iconContainer.addSubview(iconImageView)
        
        NSLayoutConstraint.activate([
            iconContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            iconContainer.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            iconContainer.widthAnchor.constraint(equalToConstant: 32),
            iconContainer.heightAnchor.constraint(equalToConstant: 32),
            
            iconImageView.centerXAnchor.constraint(equalTo: iconContainer.centerXAnchor),
            iconImageView.centerYAnchor.constraint(equalTo: iconContainer.centerYAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 25),
            iconImageView.heightAnchor.constraint(equalToConstant: 25),
            
            titleLabel.leadingAnchor.constraint(equalTo: iconContainer.trailingAnchor, constant: 16),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
        ])
    }
    
    func configure(with title: String, icon: String? = nil, showDisclosure: Bool = false, isSubItem: Bool = false) {
           titleLabel.text = title
           if let icon = icon {
               iconImageView.image = UIImage(systemName: icon)
               iconContainer.isHidden = false
           } else {
               iconContainer.isHidden = true
           }
           
           if isSubItem {
               contentView.backgroundColor = .black
               titleLabel.font = .systemFont(ofSize: 18)
               iconContainer.backgroundColor = .clear
           } else {
               contentView.backgroundColor = .black
               titleLabel.font = .systemFont(ofSize: 18)
               iconContainer.backgroundColor = .clear
           }
       }
}


struct SettingsSection {
    let title: String
    var icon: String?
    var isExpanded: Bool
    var items: [SettingsItem]?
    
    init(title: String, icon: String? = nil, isExpanded: Bool = false, items: [SettingsItem]? = nil) {
        self.title = title
        self.icon = icon
        self.isExpanded = isExpanded
        self.items = items
    }
}

struct SettingsItem {
    let title: String
    let icon: String
}


extension SettingsCell {
    func configure(with title: String, icon: String? = nil, showDisclosure: Bool = false, isSubItem: Bool = false, theme: ThemeManager.Theme = ThemeManager.shared.currentTheme) {
        titleLabel.text = title
        titleLabel.textColor = theme.textColor
        
        if let icon = icon {
            iconImageView.image = UIImage(systemName: icon)?.withTintColor(theme.textColor, renderingMode: .alwaysTemplate)
            iconContainer.isHidden = false
        } else {
            iconContainer.isHidden = true
        }
        
        backgroundColor = theme.backgroundColor
        contentView.backgroundColor = theme.backgroundColor
        iconContainer.backgroundColor = theme.iconContainerColor
    }
}

