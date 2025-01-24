//
//  GridVC.swift
//  MintynTask
//
//  Created by Inyene on 1/23/25.
//

import UIKit

class GridPageViewController: UIPageViewController {
    private var pages: [UIViewController] = []
    private let customPageIndicator: CustomPageIndicator = {
          let indicator = CustomPageIndicator(frame: .zero)
          return indicator
      }()
      
    
    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
         super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
     }
     
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) not implemented")
    }
    
    override func viewDidLoad() {
         super.viewDidLoad()
         setupPages()
         setupCustomPageIndicator()
         
         dataSource = self
         delegate = self
         
         if let firstPage = pages.first {
             setViewControllers([firstPage], direction: .forward, animated: true)
         }
     }
     
    
    private func setupPages() {
        // First page with 4 items
        let firstPage = GridViewController()
        firstPage.items = ["Quick Transfer", "Bills Payment", "Check Balance", "Transaction History"]
        firstPage.gridLayout = .twoByTwo
        
        // Second page with 3 items
        let secondPage = GridViewController()
        secondPage.items = ["Settings", "Support", "About"]
        secondPage.gridLayout = .threeItems
        
        pages = [firstPage, secondPage]
    }
    
    private func setupCustomPageIndicator() {
         view.addSubview(customPageIndicator)
         customPageIndicator.translatesAutoresizingMaskIntoConstraints = false
         
         NSLayoutConstraint.activate([
             customPageIndicator.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
             customPageIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
             customPageIndicator.widthAnchor.constraint(equalToConstant: 34),
             customPageIndicator.heightAnchor.constraint(equalToConstant: 6)
         ])
     }
}

extension GridPageViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(of: viewController) else { return nil }
        return currentIndex > 0 ? pages[currentIndex - 1] : nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = pages.firstIndex(of: viewController) else { return nil }
        return currentIndex < pages.count - 1 ? pages[currentIndex + 1] : nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed,
           let currentViewController = pageViewController.viewControllers?.first,
           let currentIndex = pages.firstIndex(of: currentViewController) {
            customPageIndicator.setCurrentPage(currentIndex)
        }
    }
}

enum GridLayout {
    case twoByTwo
    case threeItems
}

class GridViewController: UIViewController {
    var items: [String] = []
    var gridLayout: GridLayout = .twoByTwo
    
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 16
        stack.distribution = .fillEqually
        return stack
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupGridView()
    }
    
    private func setupGridView() {
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            stackView.heightAnchor.constraint(equalToConstant: 150)
        ])
        
        switch gridLayout {
        case .twoByTwo:
            setupTwoByTwoGrid()
        case .threeItems:
            setupThreeItemGrid()
        }
    }
    
    private func setupTwoByTwoGrid() {
        for row in 0..<2 {
            let rowStack = UIStackView()
            rowStack.axis = .horizontal
            rowStack.spacing = 16
            rowStack.distribution = .fillEqually
            
            for col in 0..<2 {
                let index = row * 2 + col
                if index < items.count {
                    rowStack.addArrangedSubview(createGridItem(with: items[index]))
                }
            }
            
            stackView.addArrangedSubview(rowStack)
        }
    }
    
    private func setupThreeItemGrid() {
        // First row with two items
        let topRow = UIStackView()
        topRow.axis = .horizontal
        topRow.spacing = 16
        topRow.distribution = .fillEqually
        
        for i in 0..<2 {
            if i < items.count {
                topRow.addArrangedSubview(createGridItem(with: items[i]))
            }
        }
        stackView.addArrangedSubview(topRow)
        
        // Second row with one item
        if items.count > 2 {
            let bottomRow = UIStackView()
            bottomRow.axis = .horizontal
            bottomRow.spacing = 16
            
            let item = createGridItem(with: items[2])
            let spacer = UIView()
            
            bottomRow.addArrangedSubview(item)
            bottomRow.addArrangedSubview(spacer)
            
            stackView.addArrangedSubview(bottomRow)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if gridLayout == .threeItems {
            let itemWidth = (stackView.bounds.width - 16) / 2
            if let bottomRow = stackView.arrangedSubviews.last as? UIStackView,
               let item = bottomRow.arrangedSubviews.first {
                item.widthAnchor.constraint(equalToConstant: itemWidth).isActive = true
            }
        }
    }
    
    private func createGridItem(with title: String) -> UIView {
        let container = UIView()
        container.backgroundColor = UIColor(white: 0.15, alpha: 1.0)
        container.layer.cornerRadius = 12
        
        let label = UILabel()
        label.text = title
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14)
        
        container.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            label.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: 8),
            label.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -8)
        ])
        
        return container
    }
}



class CustomPageIndicator: UIView {
    private var dots: [UIView] = []
    private var currentPage: Int = 0 {
        didSet { animateDotChange() }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupDots()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) not implemented")
    }
    
    private func setupDots() {
        // Create two dots
        for i in 0..<2 {
            let dot = UIView()
            dot.backgroundColor = i == 0 ? UIColor(red: 0.91, green: 0.69, blue: 0.24, alpha: 1.0) : .gray
            dot.layer.cornerRadius = 3
            addSubview(dot)
            dots.append(dot)
        }
        
        layoutDots()
    }
    
    private func layoutDots() {
        let dotHeight = 6.0
        let dotWidth = currentPage == 0 ? 20.0 : 6.0
        let spacing = 8.0
        
        dots[0].frame = CGRect(x: 0, y: 0, width: dotWidth, height: dotHeight)
        dots[1].frame = CGRect(x: dotWidth + spacing, y: 0, width: currentPage == 1 ? 20.0 : 6.0, height: dotHeight)
    }
    
    private func animateDotChange() {
        UIView.animate(withDuration: 0.3) {
            self.layoutDots()
            self.dots.enumerated().forEach { index, dot in
                dot.backgroundColor = index == self.currentPage ?
                    UIColor(red: 0.91, green: 0.69, blue: 0.24, alpha: 1.0) : .gray
            }
        }
    }
    
    func setCurrentPage(_ page: Int) {
        currentPage = page
    }
}

