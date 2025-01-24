//
//  ThemeManager.swift
//  MintynTask
//
//  Created by Inyene on 1/23/25.
//


import UIKit


class ThemeManager {
    static let shared = ThemeManager()
    
    enum Theme: Int {
        case `default` = 0
        case light
        case dark
        
        var userInterfaceStyle: UIUserInterfaceStyle {
            switch self {
            case .default: return .unspecified
            case .light: return .light
            case .dark: return .dark
            }
        }
        
        var backgroundColor: UIColor {
            switch self {
            case .default, .dark: return .black
            case .light: return .white
            }
        }
        
        var textColor: UIColor {
            switch self {
            case .default, .dark: return .white
            case .light: return .black
            }
        }
        
        var cellBackgroundColor: UIColor {
            switch self {
            case .default, .dark: return UIColor(white: 0.15, alpha: 1.0)
            case .light: return UIColor(white: 0.9, alpha: 1.0)
            }
        }
        
        var iconContainerColor: UIColor {
            switch self {
            case .default, .dark: return UIColor(white: 0.2, alpha: 1.0)
            case .light: return UIColor(white: 0.85, alpha: 1.0)
            }
        }
    }
    
    private init() {}
    
    var currentTheme: Theme = .default {
        didSet {
            NotificationCenter.default.post(name: .themeDidChange, object: nil)
        }
    }
    
    func applyTheme(to window: UIWindow?) {
        window?.overrideUserInterfaceStyle = currentTheme.userInterfaceStyle
    }
}

extension Notification.Name {
    static let themeDidChange = Notification.Name("ThemeDidChange")
}
