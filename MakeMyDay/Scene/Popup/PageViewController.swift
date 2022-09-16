//
//  navigationView.swift
//  MakeMyDay
//
//  Created by Y on 2022/09/13.
//

import UIKit

class PageViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    let pageZero = PopupZeroViewController()
    
    let pageOne = PopupOneViewController()
    
    lazy var pages: [UIViewController] = {
        return [pageZero, pageOne]
    }()
    
    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .black
        delegate.self = self
        dataSource.self = self
        guard let first = pages.first else { return }
        setViewControllers([first], direction: .forward, animated: true)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController) else { return nil }
            let previousIndex = index - 1
            if previousIndex < 0 {
                return nil
            }
            return pages[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = pages.firstIndex(of: viewController) else { return nil }
              let nextIndex = index + 1
              if nextIndex == pages.count {
                  return nil
              }
              return pages[nextIndex]
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return pages.count
    }

    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        guard let first = pages.first, let index = pages.firstIndex(of: first) else { return 0 }
        
        return index
    }
}
