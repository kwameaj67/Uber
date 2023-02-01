//
//  TabBarVC.swift
//  Uber
//
//  Created by Kwame Agyenim - Boateng on 18/11/2022.
//

import UIKit

class TabBarVC: UITabBarController {

    private var tabItem = UITabBarItem()
    private var tabBarAppearance = UITabBar.appearance()
    private var tabBarItemAppearance = UITabBarItem.appearance()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let HomeVC = UINavigationController(rootViewController: HomeVC())
        let ActivityVC = UINavigationController(rootViewController: ActivityVC())
        let AccountVC = UINavigationController(rootViewController: AccountVC())
        
        viewControllers = [HomeVC   , ActivityVC, AccountVC]
        setupTabBar()
        
        // tabs
        setupTabItem("home-bold", "home-outline", 0, "Home")
        setupTabItem("activity-bold", "activity-outline", 1, "Activity")
        setupTabItem("account-bold", "account-outline", 2, "Account")
        
        tabBar.standardAppearance.shadowColor = nil
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    func setupTabBar(){
        tabBar.barTintColor = UIColor.white
        tabBar.backgroundImage = UIImage()
        tabBar.shadowImage = UIImage()
        tabBar.backgroundColor = UIColor.white
        tabBar.isTranslucent = true
        
        tabBar.layer.borderColor = UIColor.systemGray3.cgColor
        tabBar.layer.borderWidth = 0.7

        tabBarAppearance.tintColor = .black
        tabBarAppearance.unselectedItemTintColor = .systemGray2
        
        additionalSafeAreaInsets.top = 20
    }
    
    func setupTabItem(_ activeImage: String, _ inactiveImage: String, _ index: Int,_ tabTitle: String){
        let selectedImage = UIImage(named: activeImage)?.withRenderingMode(.alwaysOriginal)
        let deSelectedImage = UIImage(named: inactiveImage)?.withRenderingMode(.alwaysTemplate)
        deSelectedImage?.withTintColor(.systemGray3)
        tabItem = self.tabBar.items![index]
        tabItem.image = deSelectedImage
        tabItem.selectedImage = selectedImage
        tabItem.title = tabTitle
        tabItem.imageInsets.bottom = -10
//        tabItem.imageInsets = UIEdgeInsets(top: -2, left: -10, bottom: -2, right: -10)
        tabItem.titlePositionAdjustment = .init(horizontal: 0, vertical: 6)
    }
    
    override var selectedIndex: Int {
        didSet{
            guard let _ = viewControllers?[selectedIndex] else { return }
            tabBarItemAppearance.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: Font.medium.rawValue, size: 12)!,NSAttributedString.Key.foregroundColor:UIColor.black], for: .normal)
        }
    }
    override var selectedViewController: UIViewController?{
        didSet{
            guard let viewControllers = viewControllers else { return }
            for viewVC in viewControllers{
                if viewVC == selectedViewController {
                    tabBarItemAppearance.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: Font.medium.rawValue, size: 12)!,NSAttributedString.Key.foregroundColor:UIColor.black], for: .normal)
                    }
                else {
                    tabBarItemAppearance.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: Font.medium.rawValue, size: 12)!,NSAttributedString.Key.foregroundColor:UIColor.systemGray2], for: .normal)
                    }
            }
        }
    }
    
    // bouncy tab bar icon animation
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        let orderedTabBarItemViews: [UIView] = {
            let interactionViews = tabBar.subviews.filter({ $0 is UIControl })
            return interactionViews.sorted(by: { $0.frame.minX < $1.frame.minX })
        }()
        guard
            let index = tabBar.items?.firstIndex(of: item),
            let subview = orderedTabBarItemViews[index].subviews.first
        else {
            return
        }
        performSpringAnimation(for: subview)
    }
    func performSpringAnimation(for view: UIView) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
                view.transform = CGAffineTransform(scaleX: 1.08, y: 1.08)
                UIView.animate(withDuration: 0.5, delay: 0.2, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
                    view.transform = CGAffineTransform(scaleX: 1, y: 1)
                }, completion: nil)
            }, completion: nil)
    }

}
